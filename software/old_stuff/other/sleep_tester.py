from machine import Pin, deepsleep, reset_cause, DEEPSLEEP_RESET
from time import sleep

print("running")
sys_ok_led = Pin(25, Pin.OUT, Pin.PULL_UP)
sys_ok_led.value(1)
sys_ok_led.PULL_HOLD
sleep(2)
sys_ok_led = Pin(25, Pin.OUT)
sys_ok_led.PULL_UP
sys_ok_led.value(1)
sys_ok_led.PULL_HOLD
print("sleeping")
deepsleep(5000)
