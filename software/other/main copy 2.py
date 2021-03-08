import sys
import ubluetooth
import ubinascii
from push_safer import push_safer
from runner import wdt, go_to_sleep, set_pins_held, sys_ok_led, sys_led_timer, store_data_to_rtc_ram, \
					retrieve_data_from_rtc_ram


# we *should have come here via boot.py, if not, import runner
if 'runner' not in sys.modules:
	import runner

wdt.feed() # tick the watchdog

use_bluetooth = False
push_message = False
bypass_wait = True
wait_counter = 0
error_loop = 0

# let the user know we are in main.py
if runner.oled_attached:
	runner.oled_update("EXECUTING", "MAIN.PY...", "RUNNING...", 2)

# grab the WiFi MAC
#mac = runner.WLAN().config('mac')

# set the day counter on 1st execution
day_counter = 0

# setup bluetooth
if use_bluetooth:
	ble = ubluetooth.BLE()
	ble.active(True)

def adv_encode_name(name):
	""" ADV encode name """
	name = bytes(name, "ascii")
	return bytearray((len(name) + 1, 0x09)) + name

def ble_advertise(adv_str_data):
	print("BLUETOOTH PAYLOAD: ", adv_str_data)
	print("-----")
	ble.gap_advertise(62500, bytearray("\x02\x01\x02") + adv_encode_name(adv_str_data))

def looper():
	global bypass_wait

	batt_1_v = runner.check_b1vd_voltage()
	print(batt_1_v)
	print("-----")

	batt_2_v = runner.check_b2vd_voltage()
	print(batt_2_v)
	print("-----")

	batt_2_c = runner.i2c_adc_current_check()
	print("BATT 2 CURRENT DRAW: ", batt_2_c)
	print("-----")

	board_temp = runner.get_board_temp()
	print("BOARD TEMP: ", board_temp )
	if runner.adc_attached:
		adc_temp = runner.i2c_adc_temp()
		print("ADC TEMP: ", adc_temp )
		if runner.oled_attached:
			print("ADC TEMP: ", adc_temp )
	print("-----")

	if runner.oled_attached:
		if batt_1_v[1] and batt_2_v[1]:
			runner.oled_update("BATTERY STATE:", "BATT1: " +  str(batt_1_v[0]) + ' ' + str(batt_1_v[1]), "BATT2: " + str(batt_2_v[0]) + ' ' + str(batt_2_v[1]), 2)
			runner.oled_update("BATTERY VOLTAGE:", "BATT1: " +  str(batt_1_v[2]), "BATT2: " + str(batt_2_v[2]), 2)
		else:
			runner.oled_update("BATTERY STATE:", "BATT1: " +  str(batt_1_v[0]), "BATT2: " + str(batt_2_v[0]), 2)
			runner.oled_update("BATTERY VOLTAGE:", "BATT1: " +  str(batt_1_v[2]), "BATT2: " + str(batt_2_v[2]), 2)
			#runner.oled_update("TEMPERATURES:","BOARD:" + str(board_temp) + "C", "ADC:" + str(adc_temp) + "C", 1) # do we really care about the board temp?

	if use_bluetooth:
		adv_str_data = batt_1_v[0] + ',' + batt_1_v[2] + ',' + batt_2_v[0] + ',' + batt_2_v[2] + ',' + str(board_temp) 
		#TODO: limit to 2 decimal places, instead of 5 chars
		ble_advertise(adv_str_data)


	if push_message and float(batt_2_v[2]) < runner.batt_2_cuttoff_voltage:
		if int(runner.minutes_since_counter_reset) != 0 or wait_counter == 0:
			if runner.minutes_since_counter_reset % 30.00 == 0 or bypass_wait: # send the message every 30 mins and not on boot
				print("-----")

				print("SENDING PUSHSAFER MESSAGE...")
				#push_safer("AUX+BATTERY+LOW+", batt_2_v[2])
				bypass_wait = False
			else:
				print("DEBOUNCING PUSHSAFER VOLTAGE MESSAGE...")
	

# Kick this thing off
loop = 0
while True:
	sys_led_timer.deinit()
	sys_ok_led.value(1)
	try:
		if runner.adc_attached:
			runner.adc_setup()
		
		while loop < 4:
			loop += 1
			looper()
			runner.sleep(1)

		print(retrieve_data_from_rtc_ram())
		store_data_to_rtc_ram()
		go_to_sleep()
		print("\033c", end="") # clear the terminal output at the start of every loop

		#if not runner.mode_button.value():
		#    print('Button pressed!')
		#print("\n")
		#TODO: something with a button press in main
		

	except Exception as e:
		print(e)
		error_loop += 1
		f = open('log.txt', 'w') # to view: print(f.read())
		runner.sys.print_exception(e, f)
		f.close()

		# pushsafer error message rate limiting
		if error_loop == 1:
			print("SENDING ERROR MESSAGE")
			#push_safer("ERROR+DETECTED", "")

		# reset the error_loop counter every ~hour
		if error_loop > 500:
			print("RESETTING ERROR LOOP COUNT")
			error_loop = 0
		else:
			print("DEBOUNCING PUSHSAFER ERROR MESSAGE...")

		if runner.oled_attached:
			runner.oled_update("ERROR!!!", "ERROR!!!", "ERROR!!!", 5)
		
		# reset the IO to a default/safe state, load and batteries will be disconneted
		# it might make sense not to do this is the device is crashing, the relays could flick off/on
		#runner.state_init() 