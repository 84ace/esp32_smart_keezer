from machine import Pin, I2C, PWM, deepsleep, Timer, WDT, reset_cause, DEEPSLEEP_RESET, RTC
from network import WLAN, STA_IF, AP_IF, STAT_IDLE, STAT_CONNECTING, STAT_WRONG_PASSWORD, STAT_NO_AP_FOUND, STAT_GOT_IP
from math import floor
from time import sleep
import utime
import sys
import ssd1306
import usocket as socket
import gc

# enable the watchdog timer
wdt = WDT(timeout=50000) # 50 second timeout for hardware watchdog

# initialise the RTC's RAM
rtc = RTC()

# set debug to True to enable WiFi without pressing the mode button at boot
debug = False

# 1st boot ever?
first_boot_ever = False

# is the i2c oled attached to the board?
oled_attached = True

# is the ADC attached to the board?
adc_attached = True

# setup the 'mode button', enables wifi if held during bootup
mode_button = Pin(33, Pin.IN) # mode button, GPIO33

# timers
sys_led_timer = Timer(-1)
batt_1_charging_indicator_timer = Timer(-2)
batt_2_charging_indicator_timer = Timer(-3)
oled_update_timer = Timer(-4)

station = None
local_ap = None

sys_ok_led = None
batt_1_led = None
batt_2_led = None
batt_1_enabled = None
batt_2_enabled = None

def display_boot_state():
	print("BOOTING")
	sys_led_timer.init(period=250, mode=Timer.PERIODIC, callback=lambda t:sys_ok_led.value(not sys_ok_led.value()))

def store_data_to_rtc_ram(data):
	rtc.memory(str(data))

def retrieve_data_from_rtc_ram():
    return rtc.memory()

if reset_cause() == DEEPSLEEP_RESET:
	data = int(retrieve_data_from_rtc_ram())
	data = data + 1
	store_data_to_rtc_ram(data)
	print("WOKEN FROM DEEPSLEEP ON LOOP: ", data)
	sleep(1)

	sys_ok_led = Pin(27) # system LED, GPIO27
	if sys_ok_led.value():
		sys_ok_led = Pin(27, Pin.OUT, Pin.PULL_UP)
		sys_ok_led.value(1)

	batt_1_led = Pin(25) # batt 1 LED
	if batt_1_led.value():
		batt_1_led = Pin(25, Pin.OUT, Pin.PULL_UP)
		batt_1_led.value(1)

	batt_2_led = Pin(18) # batt 2 LED
	if batt_2_led.value():
		batt_2_led = Pin(18, Pin.OUT, Pin.PULL_UP)
		batt_2_led.value(1)

	batt_1_enabled = Pin(32) # batt 1 enabled
	if batt_1_enabled.value():
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_UP)
		batt_1_enabled.value(1)

	batt_2_enabled = Pin(4) # batt 2 enabled
	if batt_2_enabled.value():
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_UP)
		batt_2_enabled.value(1)
else:
	print("storing data for the first time")
	store_data_to_rtc_ram('1')
	sleep(1)

	# initialise LEDs
	sys_ok_led = Pin(27, Pin.OUT, Pin.PULL_DOWN) # system LED, GPIO27
	batt_1_led = Pin(25, Pin.OUT, Pin.PULL_DOWN)  # battery 1 LED, GPIO25
	batt_2_led = Pin(18, Pin.OUT, Pin.PULL_DOWN)  # battery 2 LED, GPIO18

	# battery relays or MOSFETs
	batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_DOWN)  # batt_1_enabled battery fet, GPIO32
	batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_DOWN)  # batt_2_enabled battery fet, GPIO4

# setup the ADC
battery_voltage_divider = ((105000+20000)/20000)
error = 0.985


#ACS781LLRTR100B = .0132 # 13.2mV/A
#CC6903SO-30A = .067 # 67mV/A
#TODO: get the curtrent sensors working

# set some limits for what we accept for voltages
max_battery_voltage = 14.1  # Lead acid, max charge voltage, ~14.1
min_batery_voltage = 11.8   # Lead acid, 0% SOC voltage, ~11.8V

batt_1_cuttoff_voltage = 12.90
batt_2_cuttoff_voltage = 11.5

battery_voltage_range = max_battery_voltage - min_batery_voltage
measured_batt_1_vdrop = 0.0 # measured voltage drop between batt_1 and board (cable loss)
measured_batt_2_vdrop = 0.05 # measured voltage drop between batt_2 and board (cable loss)

# setup some stats
max_batt_1_voltage = 0.0  # Min/Max stats creation
min_batt_1_voltage = 15.0
max_batt_2_voltage = 0.0
min_batt_2_voltage = 15.0

# setup a counter to see how long we have been running for
minutes_since_counter_reset = 0 # allows us to reset daily averages
day_counter = 0

# set the charging state
charger_state = None

# setup the I2C bus
i2c = I2C(scl=Pin(22), sda=Pin(21))

# setup the OLED display
if oled_attached:
	oled = ssd1306.SSD1306_I2C(128, 32, i2c)
	oled.rotate180(180) # rotate the output 180 degrees as the screen is mounted upside down

# if mode button is pressed during bootup, and no SSIDs are visible, enable the internal AP
USE_AP = False

# define some networks we would like to connect to, for webrepl or debugging, used with mode button
NETWORKS = [ # SSID, PWD, [MAC] (Optional)
	['ShelveNET24', 'buttpiratry'],
	['EXETEL 3CAF5F 2.4G', 'dEQTFuJn'],
	['TP-Link_3EC0', '12039340']
]

def watchdog_ticker():
	wdt.feed()

# get board temp from LM75 temp sensor
def get_board_temp():
	output = i2c.readfrom(0x48, 2)
	temp_array = int(output[0]), floor(int(output[1]) / 23)
	temp = "%s.%s" % (temp_array[0], temp_array[0])
	watchdog_ticker()
	return temp


# get some user facing data visible ASAP
def oled_update(line_1, line_2, line_3, show_duration):
	oled.fill(0)
	oled.text(line_1, 0, 0)
	oled.text(line_2, 0, 10)
	oled.text(line_3, 0, 20)
	oled.show()
	sleep(show_duration)

# if the mode button is pressed at boot or reset, connect to WiFi station, else, create AP
def connectWiFi():
	# setup wifi interfaces
	global station
	global local_ap
	station = WLAN(STA_IF)
	local_ap = WLAN(AP_IF)

	if not station.active():
		station.active(True)
		if oled_attached:
			oled_update("LOOKING FOR", "KNOWN SSIDS...", "", 0)

	if waitForConnection():
		return True

	aps = station.scan()
	aps.sort(key=lambda ap:ap[3], reverse=True)

	for ap in aps:
		for net in NETWORKS:
			found = False
			if ap[0].decode('UTF-8') == net[0]:
				found = True
				if oled_attached:
					oled_update("WIFI CONNECTED", "TO STATION!", "", 0)

			elif len(net) == 3:
				for mac in net[2]:
					if hexlify(ap[1]).decode('UTF-8') == mac:
						found = True
						break

			if found:
				station.connect(net[0], net[1])
				if waitForConnection():
					if USE_AP and local_ap.active():
						local_ap.active(False)
					if oled_attached:
						oled_update("WIFI CONNECTED", "TO STATION!", "", 0)
					return True

	if USE_AP and not local_ap.active():
		local_ap.active(True)
		#oled_update("WIFI AP", "STARTED!", "", 0)
	oled_update("NO SSIDS", "FOUND!", "CONTINUING...", 0)
	return False


# need to wait for some time to ensure the connection is setup correctly
def waitForConnection():
	global station 
	while station.status() == STAT_CONNECTING:
		sleep(0.25)

	return station.isconnected()


def adc_setup():
	i2c.writeto_mem(0x1d, 0x07, b'\x01')
	i2c.writeto_mem(0x1d, 0x00, b'\x01')


def i2c_adc_temp():
	data = i2c.readfrom_mem(0x1d, 0x27, 2)

	high_byte = int(data[0])
	low_byte = int(data[1])

	value = (high_byte << 1 | low_byte >> 7) / 2

	return value


def i2c_adc_voltage_check(register):
	data = i2c.readfrom_mem(0x1d, register, 2)

	high_byte = int(data[0])
	low_byte = int(data[1])

	value = (high_byte << 4 | low_byte >> 1)

	return 2.56 / 4096 * value


def i2c_adc_current_check():
	data = i2c.readfrom_mem(0x1d, 0x22, 2)

	high_byte = int(data[0])
	low_byte = int(data[1])

	value = (high_byte << 4 | low_byte >> 1)
	adc_voltage = 2.56 / 4096 * value
	crossover_point = 1.675
	current = (adc_voltage - crossover_point) / 0.044
    
	return current


def charge_state(battery, state):
	global charger_state
	global batt_1_enabled
	global batt_2_enabled

	if not batt_1_enabled and not batt_2_enabled:
		charger_state = None

	if charger_state is not None:
		return
	else:
		if battery == 1:
			if state:
				charger_state = "1>2"
		elif battery == 2:
			if state:
				charger_state = "2>1"

# TODO: add a function to deal with voltage drop due to current draw
# Can't do this on the lite version as there are now current sensors

def check_b1vd_voltage():
	global max_batt_1_voltage
	global min_batt_1_voltage
	global batt_1_enabled
	global batt_2_enabled
	global batt_1_led

	batt_1_adc_voltage = i2c_adc_voltage_check(0x20)
	batt_1_voltage = battery_voltage_divider * batt_1_adc_voltage * error
	batt_1_led = Pin(25, Pin.OUT, Pin.PULL_DOWN)
	batt_2_led = Pin(18, Pin.OUT, Pin.PULL_DOWN)

	if batt_1_voltage < min_batt_1_voltage:
		min_batt_1_voltage = batt_1_voltage
	elif batt_1_voltage > max_batt_1_voltage:
		max_batt_1_voltage = batt_1_voltage

	if batt_1_voltage > 13.2:
		state = 'CHG'
		batt_1_charging_indicator_timer.init(period=250, mode=Timer.PERIODIC, callback=lambda t:batt_1_led.value(not batt_1_led.value()))
		#if int(minutes_since_counter_reset) % 2 == 0: # slow the rate of change down to 1 by every 2 mins
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_UP)
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_UP)
		batt_1_enabled.value(1)
		batt_2_enabled.value(1)
		charge_state(1, 1)
	elif batt_1_voltage > batt_1_cuttoff_voltage:
		batt_1_charging_indicator_timer.deinit()
		batt_1_led.value(1)
		state = 'ON'
		charge_state(1, 0)
		#if int(minutes_since_counter_reset) % 2 == 0: # slow the rate of change down to 1 by every 2 mins
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_UP)
		batt_1_enabled.value(1)
	else:
		batt_1_charging_indicator_timer.deinit()
		batt_1_led.value(0)
		state = 'OFF'
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_DOWN)
		batt_1_enabled.value(0)
		charge_state(1, 0)


	return state, charger_state, str(batt_1_voltage)[:5], str(min_batt_1_voltage)[:5], str(max_batt_1_voltage)[:5]


def check_b2vd_voltage():
	global max_batt_2_voltage
	global min_batt_2_voltage
	global batt_1_enabled
	global batt_2_enabled
	global batt_2_led

	batt_2_adc_voltage = i2c_adc_voltage_check(0x21)
	batt_2_voltage = battery_voltage_divider * batt_2_adc_voltage * error
	batt_1_led = Pin(25, Pin.OUT, Pin.PULL_DOWN)
	batt_2_led = Pin(18, Pin.OUT, Pin.PULL_DOWN)

	if batt_2_voltage < min_batt_2_voltage:
		min_batt_2_voltage = batt_2_voltage
	elif batt_2_voltage > max_batt_2_voltage:
		max_batt_2_voltage = batt_2_voltage

	if batt_2_voltage > 13.0:
		batt_2_charging_indicator_timer.init(period=250, mode=Timer.PERIODIC, callback=lambda t:batt_2_led.value(not batt_2_led.value()))
		state = 'CHG'
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_UP)
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_UP)
		batt_1_enabled.value(1)
		batt_2_enabled.value(1)
		charge_state(2, 1)

	elif batt_2_voltage > batt_2_cuttoff_voltage:
		batt_2_charging_indicator_timer.deinit()
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_UP)
		batt_2_led.value(1)
		state = 'ON'
		charge_state(2, 0)
		batt_2_enabled.value(1)

	else:
		batt_2_charging_indicator_timer.deinit()
		batt_2_led.value(0)
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_DOWN)
		state = 'OFF'
		charge_state(2, 0)
		batt_2_enabled.value(0)

	return state, charger_state, str(batt_2_voltage)[:5], str(min_batt_1_voltage)[:5], str(max_batt_1_voltage)[:5]


def set_pins_held():
	global sys_ok_led
	if sys_ok_led.value():
		sys_ok_led = Pin(27, Pin.OUT, Pin.PULL_UP)
		sys_ok_led.value(1)
		sys_ok_led.PULL_HOLD

	#global batt_1_led
	#if batt_1_led.value():
	#	batt_1_led = Pin(25, Pin.OUT, Pin.PULL_UP)
	#	batt_1_led.value(0)
	#	batt_1_led.PULL_HOLD

	#global batt_2_led
	#if batt_2_led.value():
	#	batt_2_led = Pin(18, Pin.OUT, Pin.PULL_UP)
	#	batt_2_led.value(1)
	#	batt_2_led.PULL_HOLD

	global batt_1_enabled
	if batt_1_enabled.value():
		batt_1_enabled = Pin(32, Pin.OUT, Pin.PULL_UP)
		batt_1_enabled.value(1)
		batt_1_enabled.PULL_HOLD

	global batt_2_enabled
	if batt_2_enabled.value():
		batt_2_enabled = Pin(4, Pin.OUT, Pin.PULL_UP)
		batt_2_enabled.value(1)
		batt_2_enabled.PULL_HOLD


def go_to_sleep():
	set_pins_held()
	deepsleep(10000) # 10 seconds
	
	#TODO: do something with board temperature for safety