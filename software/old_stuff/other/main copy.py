
from machine import Pin, I2C, ADC, PWM, deepsleep
from math import floor
from time import sleep
import utime
import sys

import gc
gc.collect()

#import esp
#esp.osdebug(None)  # Turn off vendor O/S debugging messages
#esp.osdebug(0)  # Redirect vendor O/S debugging messages to UART(0)

debug = True

aux1 = Pin(32, Pin.OUT, Pin.PULL_DOWN)  # aux1 battery fet, GPIO32
aux2 = Pin(4, Pin.OUT, Pin.PULL_DOWN)  # aux2 battery fet, GPIO4   

i2c = I2C(scl=Pin(22), sda=Pin(21))

# testing relays
print("Switching off relays")
aux1.off() # turn off BATT 1
aux2.off() # turn off BATT 2

minutes_since_counter_reset = 0 # allows us to reset daily averages

max_battery_voltage = 14.1  # Lead acid, max charge voltage, ~14.1
min_batery_voltage = 11.8   # Lead acid, 0% SOC voltage, ~11.8V
battery_voltage_range = max_battery_voltage - min_batery_voltage

max_aux1_voltage = 0  # Min/Max stats creation
min_aux1_voltage = 15
max_aux2_voltage = 0
min_aux2_voltage = 15

battery_ADC_multiplier = ((105+20)/20)  # (k) battery ADC voltage divider ratio
max_ADC_value = 4095  # 12-bit ADC in the ESP-32
max_ADC_voltage = 3.6  # 3.6V when using ATTN_11DB

aux1_battery = ADC(Pin(34))  # AUX 1 battery voltage
aux1_battery.atten(ADC.ATTN_11DB)  #Full range: 3.3v

aux2_battery = ADC(Pin(35))  # AUX 2 battery voltage
aux2_battery.atten(ADC.ATTN_11DB)  #Full range: 3.3v

aux1 = Pin(32, Pin.OUT, Pin.PULL_DOWN)  # aux1 battery fet, GPIO32
aux2 = Pin(4, Pin.OUT, Pin.PULL_DOWN)  # aux2 battery fet, GPIO4   

sys_ok = Pin(27, Pin.OUT) # system LED

mode_button = Pin(33, Pin.IN, Pin.PULL_UP)

ACS781LLRTR100B = .0132 # 13.2mV/A

# TODO: 
esp32_supply_voltage = 3.28 # Need to actually measure this on the fly
adc_volts_per_devision = esp32_supply_voltage / max_ADC_value

class LM75(object):
    ADDRESS = 0x48  # LM75 bus address
    FREQUENCY = 100000  # I2C bus frequency

    def __init__(self):
        self.i2c = I2C(scl=Pin(22), sda=Pin(21), freq=self.FREQUENCY)

    
    def get_output(self):
        """Return raw output from the LM75 sensor."""
        output = self.i2c.readfrom(self.ADDRESS, 2)
        return output[0], output[1]

    
    def get_temp(self):
        """Return a tuple of (temp_c, point)."""
        temp = self.get_output()
        return int(temp[0]), floor(int(temp[1]) / 23)


def print_temp():
    sensor = LM75()
    temperature, point = sensor.get_temp()
    print("Board temp: %s.%s" % (temperature, point))
    

def adc_value_to_voltage(value):
    return round((max_ADC_voltage/max_ADC_value)*value*battery_ADC_multiplier, 2)
    

def get_ADC_value(pin):
    loop = 0
    adc_value = 0
    while loop < 250:
        loop +=1
        adc_value += pin.read()

    #DEBUG
    #print(adc_value/loop)

    return adc_value_to_voltage(adc_value/loop)
     

def get_aux1_voltage():
    return get_ADC_value(aux1_battery)


def get_aux2_voltage():
    return get_ADC_value(aux2_battery)


def status_led(state):
    if state == 2:
        sys_ok.value(0)
        sleep(1)
        sys_ok.value(not sys_ok.value())
    else:
        sys_ok.value(1)


def aux1_led_flasher(state):
    aux1_led = Pin(25, Pin.OUT)  # Battery 1 LED, GPIO25
    if state == 2:
        aux1_led.value(not aux1_led.value())
    elif state == 1:
        aux1_led.value(1)
    else:
        aux1_led.value(0)


def aux2_led_flasher(state):
    aux2_led = Pin(18, Pin.OUT)  # Battery 2 LED, GPIO18
    if state == 2:
        aux2_led.value(not aux2_led.value())
    elif state == 1:
        aux2_led.value(1)
    else:
        aux2_led.value(0)

def adc_setup():
    i2c.writeto_mem(0x1d, 0x07, b'\x01')
    i2c.writeto_mem(0x1d, 0x00, b'\x01')

def i2c_adc_temp():
    data = i2c.readfrom_mem(0x1d, 0x27, 2)

    high_byte = int(data[0])
    low_byte = int(data[1])

    value = (high_byte << 1 | low_byte >> 7) / 2

    return value

    # every 5 mins: pause everything, disconnect Batt 1 and check its voltage
first_counter = 999
def disconnect_check():
    global first_counter
    modulo_check = int(minutes_since_counter_reset) % 5
    if modulo_check == 0:
        if first_counter == 999:
            print("DISCONNECTING BATT 1 FOR VOLTAGE CHECK")
            aux1.value(0)
            sleep(5)
            aux1_voltage = get_aux1_voltage()
            first_counter = 0
        else:
            aux1_voltage = get_aux1_voltage()
            first_counter = 0
    else:
        aux1_voltage = get_aux1_voltage()
        first_counter = 999


charger_state = None
def charge_state(battery, state):
    global charger_state
    global batt1
    global batt2

    if not batt1 and not batt2:
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

batt1 = None
def check_b1vd_voltage():
    global min_aux1_voltage
    global max_aux1_voltage
    global batt1
    global charge_state
    
    clean_aux1_voltage = 0
    aux1_voltage = get_aux1_voltage()

    disconnect_check()

    if aux1_voltage < 10.02:
        clean_aux1_voltage = aux1_voltage * 1.03
    elif aux1_voltage < 10.44:
        clean_aux1_voltage = aux1_voltage * 1.0265
    elif aux1_voltage < 10.64:
        clean_aux1_voltage = aux1_voltage * 1.024
    elif aux1_voltage < 11.04:
        clean_aux1_voltage = aux1_voltage * 1.00
    elif aux1_voltage < 11.69:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 11.98:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 12.29:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 12.80:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 13.21:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 13.53:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 13.84:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 14.19:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 14.65:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 15.00:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 15.59:
        clean_aux1_voltage = aux1_voltage * 0.965
    elif aux1_voltage < 16.11:
        clean_aux1_voltage = aux1_voltage * 0.965

    if clean_aux1_voltage > 13.6:
        aux1_led_flasher(2)
        batt1 = True
        aux2.value(1)
        charge_state(1, 1)
        print("BATT 1 state: CHARGING ", charger_state)
    elif clean_aux1_voltage > 12.7:
        charge_state(1, 0)
        aux1_led_flasher(1)
        aux1.value(1)
        print("BATT 1 state: ON")
    else:
        aux1_led_flasher(0)
        aux1.value(0)
        charge_state(1, 0)
        batt1 = False
        print("BATT 1 state: OFF")


    # create some min/max stats
    # TODO: Wipe stats every day
    if clean_aux1_voltage > max_aux1_voltage:
        max_aux1_voltage = clean_aux1_voltage
    print("MAX BATT 1 voltage: ", max_aux1_voltage)

    if clean_aux1_voltage < min_aux1_voltage:
        min_aux1_voltage = clean_aux1_voltage
    print("MIN BATT 1 voltage: ", min_aux1_voltage)

    #DEBUG:
    if debug:
        print("RAW BATT 1 voltage: ", aux1_voltage)
    print("BATT 1 voltage: ", clean_aux1_voltage)
        
        
batt2 = None   
def check_b2vd_voltage():
    global min_aux2_voltage
    global max_aux2_voltage
    global batt2
    global charge_state

    clean_aux2_voltage = 0
    aux2_voltage = get_aux2_voltage()

    if aux2_voltage < 10.02:
        clean_aux2_voltage = aux2_voltage * 1.03
    elif aux2_voltage < 10.44:
        clean_aux2_voltage = aux2_voltage * 1.0265
    elif aux2_voltage < 10.64:
        clean_aux2_voltage = aux2_voltage * 1.024
    elif aux2_voltage < 11.04:
        clean_aux2_voltage = aux2_voltage * 1.00
    elif aux2_voltage < 11.69:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 11.98:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 12.29:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 12.80:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 13.21:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 13.53:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 13.84:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 14.19:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 14.65:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 14.99:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 15.59:
        clean_aux2_voltage = aux2_voltage * 0.965
    elif aux2_voltage < 16.11:
        clean_aux2_voltage = aux2_voltage * 0.965

    if clean_aux2_voltage > 13.8:
        aux2_led_flasher(2)
        aux1.value(1)
        charge_state(2, 1)
        batt2 = True
        print("BATT 2 state: CHARGING ", charger_state)
    elif clean_aux2_voltage > 11.5:
        charge_state(2, 0)
        aux2_led_flasher(1)
        aux2.value(1)
        print("BATT 2 state: ON")
    else:
        aux2_led_flasher(0)
        charge_state(2, 0)
        batt2 = False
        aux2.value(0)
        print("BATT 2 state: OFF")

    # create some min/max stats
    if clean_aux2_voltage > max_aux2_voltage:
        max_aux2_voltage = clean_aux2_voltage
    print("MAX BATT 2 voltage: ", max_aux2_voltage)

    if clean_aux2_voltage < min_aux2_voltage:
        min_aux2_voltage = clean_aux2_voltage
    print("MIN BATT 2 voltage: ", min_aux2_voltage)

    #DEBUG:
    if debug:
        print("RAW BATT 2 voltage: ", aux2_voltage)
    print("BATT 2 voltage: ", clean_aux2_voltage)
        

#TODO: do something with board temperature for safety


def looper():
    print("-----")
    status_led(1)
    check_b1vd_voltage()
    print("-----")
    check_b2vd_voltage()
    print("-----")
    print_temp(), "C from LM75"
    print("ADC temp: ", i2c_adc_temp())
    print("-----")

day_counter = 0
# Kick this thing off
try:
    adc_setup()
    while True:  
        #TODO turn on wifi with button press
        start = utime.ticks_ms()
        looper()
        #print(utime.ticks_ms()/1000)  # show the time since boot in seconds
        if not mode_button.value():
            print('Button pressed!')
        sleep(.2)
        print("\n")
        minutes_since_counter_reset += (utime.ticks_ms() - start) / 1000 / 60
        
        #  Reset counters / daily averages
        if minutes_since_counter_reset > 1440:
            day_counter += 1
            minutes_since_counter_reset = 0
            max_aux1_voltage = 0  # Min/Max stats creation
            min_aux1_voltage = 15
            max_aux2_voltage = 0
            min_aux2_voltage = 15

        print("\033c", end="")
        print("Minutes since counter reset: ", minutes_since_counter_reset)
        print("Days alive: ", day_counter)

except ValueError as ve:
    print(ve)
    status_led(2)
    aux1.off() # turn off BATT 1
    aux2.off() # turn off BATT 2
    aux1_led_flasher(0)
    aux2_led_flasher(0)

except:
    # handle all other exceptions
    status_led(2)
    aux1.off() # turn off BATT 1
    aux2.off() # turn off BATT 2
    aux1_led_flasher(0)
    aux2_led_flasher(0)