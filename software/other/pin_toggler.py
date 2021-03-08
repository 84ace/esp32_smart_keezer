
from machine import Pin, I2C, ADC, PWM, deepsleep
from time import sleep

import gc
gc.collect()

#import esp
#esp.osdebug(None)  # Turn off vendor O/S debugging messages
#esp.osdebug(0)  # Redirect vendor O/S debugging messages to UART(0)

debug = True

aux1 = Pin(32, Pin.OUT, Pin.PULL_DOWN)  # aux1 battery fet, GPIO32
aux2 = Pin(4, Pin.OUT, Pin.PULL_DOWN)  # aux2 battery fet, GPIO4   

# testing relays

while True:
    print("Toggling...")
    aux1.value(not aux1.value())
    sleep(2)
    aux2.value(not aux1.value())
    sleep(2)
    