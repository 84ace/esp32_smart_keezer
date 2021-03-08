# Scanner i2c en MicroPython | MicroPython i2c scanner
# Renvoi l'adresse en decimal et hexa de chaque device connecte sur le bus i2c
# Return decimal and hexa adress of each i2c device
# https://projetsdiy.fr - https://diyprojects.io (dec. 2017)

import machine
from time import sleep

i2c = machine.I2C(scl=machine.Pin(22), sda=machine.Pin(21))

print('Scan i2c bus...')
devices = i2c.scan()

if len(devices) == 0:
  print("No i2c device !")
else:
  print('i2c devices found:',len(devices))

  for device in devices:  
    print("Decimal address: ",device," | Hexa address: ",hex(device))

i2c = machine.I2C(scl=machine.Pin(22), sda=machine.Pin(21))

def adc_setup():
    i2c.writeto_mem(0x1d, 0x07, b'\x01')
    #i2c.writeto_mem(0x1d, 0x0B, b'\x00') # defaults to 0
    i2c.writeto_mem(0x1d, 0x00, b'\x01')

def i2c_adc_temp():
    data = i2c.readfrom_mem(0x1d, 0x27, 2)

    high_byte = int(data[0])
    low_byte = int(data[1])

    value = (high_byte << 1 | low_byte >> 7) / 2

    return value

def i2c_adc_voltage_in_x(channel):
    if channel == batt_1_voltage:
        register = 0x20
    elif channel == batt_2_voltage:
        register = 0x21
    elif channel == batt_2_current:
        register = 0x22


    data = i2c.readfrom_mem(0x1d, register, 2)
    #print(data)

    high_byte = int(data[0])
    low_byte = int(data[1])

    value = (high_byte << 4 | low_byte >> 1)

    adc_voltage = 2.56 / 4096 * value

    print("ADC Voltage: ", adc_voltage)

    battery_voltage_divider = ((105000+20000)/20000)

    battery_voltage = battery_voltage_divider * adc_voltage

    error = 0.9796905222

    print("Battery Voltage: ", battery_voltage * error)

    return value

registers = [0x20,0x21, 0x22, 0x23, 0x24, 0x25, 0x26]
i = 0
def i2c_adc_voltage_in1():
    global i 
    while True:
        if i < 2:
            
            data = i2c.readfrom_mem(0x1d, registers[i], 2)
            #print(data)

            high_byte = int(data[0])
            low_byte = int(data[1])

            value = (high_byte << 4 | low_byte >> 1)

            print(i, value)

            adc_voltage = 2.56 / 4096 * value

            print("ADC Voltage: ", adc_voltage)

            battery_voltage_divider = ((105000+20000)/20000)

            battery_voltage = battery_voltage_divider * adc_voltage

            error = 0.9796905222

            print("Battery Voltage: ", battery_voltage * error)

            i += 1
            sleep(1)
        else:
            i = 0
            False

def i2c_adc_current():
    data = i2c.readfrom_mem(0x1d, 0x22, 2)
    print(data)

    high_byte = int(data[0])
    low_byte = int(data[1])

    value = (high_byte << 4 | low_byte >> 1)

    print(i, value)

    adc_voltage = 2.56 / 4096 * value

    print("ADC Voltage: ", adc_voltage)

    crossover_point = 1.63

    current = (adc_voltage - crossover_point) / 0.044

    print("ADC Current: ", current)

        


adc_setup()
while True:
    print(i2c_adc_temp(), "C") 
    print("")
    #print("batt1")
    #print(i2c_adc_voltage_in0())
    #print("batt2")
    #print(i2c_adc_voltage_in1())
    i2c_adc_current()
    print("")
    sleep(1)
