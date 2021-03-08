import sys
import ubluetooth
import ubinascii
from push_safer import push_safer
from runner import wdt, go_to_sleep, set_pins_held, sys_ok_led, sys_led_timer, store_data_to_rtc_ram, \
					retrieve_data_from_rtc_ram, oled_attached, oled_update, adc_attached, get_board_temp, \
					i2c_adc_temp, minutes_since_counter_reset, batt_2_cuttoff_voltage, adc_setup, sleep, \
					check_b1vd_voltage, check_b2vd_voltage, i2c_adc_current_check, debug


# we *should have come here via boot.py, if not, import runner
if 'runner' not in sys.modules:
	from runner import wdt, go_to_sleep, set_pins_held, sys_ok_led, sys_led_timer, store_data_to_rtc_ram, \
					retrieve_data_from_rtc_ram, oled_attached, oled_update, adc_attached, get_board_temp, \
					i2c_adc_temp, minutes_since_counter_reset, batt_2_cuttoff_voltage, adc_setup, sleep, \
					check_b1vd_voltage, check_b2vd_voltage, i2c_adc_current_check

wdt.feed() # tick the watchdog

loops = 5 # how many times to check data and average
use_bluetooth = False
push_message = False
bypass_wait = True
wait_counter = 0
error_loop = 0

# let the user know we are in main.py
if oled_attached:
	oled_update("EXECUTING", "MAIN.PY...", "RUNNING...", 2)

# grab the WiFi MAC
#mac = WLAN().config('mac')

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

batt_1_voltage = 0
batt_2_voltage = 0
batt_2_current = 0
batt_1_min_voltage = 0
batt_2_min_voltage = 0
batt_1_max_voltage = 0
batt_2_max_voltage = 0
board_temp = 0
adc_temp = 0
batt_1_v_check = None
batt_2_v_check = None
batt_2_c_check = None
batt_1_state = None
batt_2_state = None

def looper():
	global bypass_wait
	global batt_2_voltage
	global batt_1_voltage
	global batt_2_current
	global batt_1_min_voltage
	global batt_2_min_voltage
	global batt_1_v_check
	global batt_2_v_check
	global batt_2_c_check
	global adc_temp
	global board_temp

	batt_1_v_check = check_b1vd_voltage()
	batt_2_v_check = check_b2vd_voltage()
	batt_2_c_check = i2c_adc_current_check()
	board_temp = get_board_temp()

	if adc_attached:
		adc_temp = i2c_adc_temp()

	sleep(1)

	#if oled_attached:
	#	if batt_1_v[1] and batt_2_v[1]:
	#		oled_update("BATTERY STATE:", "BATT1: " +  str(batt_1_v[0]) + ' ' + str(batt_1_v[1]), "BATT2: " + str(batt_2_v[0]) + ' ' + str(batt_2_v[1]), 2)
	#		oled_update("BATTERY VOLTAGE:", "BATT1: " +  str(batt_1_v[2]), "BATT2: " + str(batt_2_v[2]), 2)
	#	else:
	#		oled_update("BATTERY STATE:", "BATT1: " +  str(batt_1_v[0]), "BATT2: " + str(batt_2_v[0]), 2)
	#		oled_update("BATTERY VOLTAGE:", "BATT1: " +  str(batt_1_v[2]), "BATT2: " + str(batt_2_v[2]), 2)
	#		#oled_update("TEMPERATURES:","BOARD:" + str(board_temp) + "C", "ADC:" + str(adc_temp) + "C", 1) # do we really care about the board temp?

	#if use_bluetooth:
	#	adv_str_data = batt_1_v[0] + ',' + batt_1_v[2] + ',' + batt_2_v[0] + ',' + batt_2_v[2] + ',' + str(board_temp) 
	#	#TODO: limit to 2 decimal places, instead of 5 chars
	#	ble_advertise(adv_str_data)


	#if push_message and float(batt_2_v[2]) < batt_2_cuttoff_voltage:
	#	if int(minutes_since_counter_reset) != 0 or wait_counter == 0:
	#		if minutes_since_counter_reset % 30.00 == 0 or bypass_wait: # send the message every 30 mins and not on boot
	#			print("-----")
	#
	#			print("SENDING PUSHSAFER MESSAGE...")
	#			#push_safer("AUX+BATTERY+LOW+", batt_2_v[2])
	#			bypass_wait = False
	#		else:
	#			print("DEBOUNCING PUSHSAFER VOLTAGE MESSAGE...")
	

# Kick this thing off
sys_led_timer.deinit()
loop = 0
while True:
	sys_ok_led.value(1)
	try:
		if adc_attached:
			adc_setup()
		
		while loop < loops:
			looper()
			if loop > 0: # throw away the first returned values after restart
				batt_1_voltage += float(batt_1_v_check[2])
				batt_2_voltage += float(batt_2_v_check[2])
				batt_2_current += float(batt_2_c_check)

			loop += 1
			
		

		print("-----")
		if batt_1_v_check[1] is not None:
			print("OVERALL STATE:  CHARGING", batt_1_v_check[0])
		else:
			print("OVERALL STATE:  DISCHARGING")
		print("-----")
		print("BATT 1 STATE:  ", batt_1_v_check[0])
		print("BATT 1 VOLTAGE:", batt_1_voltage / (loops - 1))
		print("BATT 1 MIN V:  ", batt_1_min_voltage)
		print("BATT 1 MAX V:  ", batt_1_max_voltage)
		print("BATT 1 CURRENT: N/A")
		print("-----")
		print("BATT 2 STATE:  ", batt_2_v_check[0])
		print("BATT 2 VOLTAGE:", batt_2_voltage / (loops - 1))
		print("BATT 2 MIN V:  ", batt_2_min_voltage)
		print("BATT 2 MAX V:  ", batt_2_max_voltage)
		print("BATT 2 CURRENT:", batt_2_current / (loops - 1))
		print("-----")
		print("BOARD TEMP IC: ", board_temp)
		print("ADC TEMP:      ", adc_temp)
		print("-----")


		loop = 0
		batt_1_voltage = 0
		batt_2_voltage = 0
		batt_2_current = 0
		board_temp = 0
		adc_temp = 0		

		if not debug:
			print("GOING TO SLEEP")
			go_to_sleep()
			print("\033c", end="") # clear the terminal output at the start of every loop


		#if not mode_button.value():
		#    print('Button pressed!')
		#print("\n")
		#TODO: something with a button press in main
		

	except Exception as e:
		# pushsafer error message rate limiting
		if error_loop == 0:
			error_loop += 1
			f = open('log.txt', 'w') # to view: print(f.read())
			sys.print_exception(e)
			f.close()

			print("SENDING ERROR MESSAGE")
			#push_safer("ERROR+DETECTED", "")

		# reset the error_loop counter every ~hour
		if error_loop > 500:
			print("RESETTING ERROR LOOP COUNT")
			error_loop = 0
		else:
			print("DEBOUNCING PUSHSAFER ERROR MESSAGE...")
			sleep(10)

		if oled_attached:
			oled_update("ERROR!!!", "ERROR!!!", "ERROR!!!", 5)