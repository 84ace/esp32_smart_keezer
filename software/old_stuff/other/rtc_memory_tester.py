import machine
from time import sleep

rtc = machine.RTC()

def store_data_to_rtc_ram(data):
	rtc.memory(str(data))

def retrieve_data_from_rtc_ram():
    return int(rtc.memory())

if machine.reset_cause() == machine.DEEPSLEEP_RESET:
    data = int(retrieve_data_from_rtc_ram())
    print("data before", data)
    data = data + 1
    print("data: ", data)
    store_data_to_rtc_ram(data)
    print("storing data")
    

else:
    print("storing data for the first time")
    store_data_to_rtc_ram('1')

sleep(2)
machine.deepsleep(2000)

