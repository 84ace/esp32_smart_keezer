# This file is executed on every boot (including wake-boot from deepsleep)
from runner import oled_attached, oled_update, display_boot_state, first_boot_ever, mode_button, debug, connectWiFi

# make the system LED flash to show that the unit is booting
display_boot_state()

# show the boot splash screen to get some info to the user
if oled_attached:
	oled_update("BI LITE V0.01", "ACEA QUIGG 11/20", "BOOTING...", 3)

# we need to do the following the first time after flashing micropython for webrepl setup:
if first_boot_ever:
	import webrepl_setup
	if oled_attached:
		oled_update("WEBREPL SETUP...", "", "", 0)

# if debug True connect WiFi etc., elif, the mode button is pressed during boot, connect WiFi etc.
if not mode_button.value() or debug: # run if mode button not pressed at boot
	print("LOOKING FOR KNOWN SSIDs...")
	if oled_attached:
		oled_update("LOOKING FOR", "KNOWN SSIDS...", "", 2)
	connectWiFi()
	import webrepl
	webrepl.start()

# over to main.py now

