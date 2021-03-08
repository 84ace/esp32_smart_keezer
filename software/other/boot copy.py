# This file is executed on every boot (including wake-boot from deepsleep)
import runner


# show the boot splash screen to get some info to the user
if runner.oled_attached:
	runner.oled_update("BI LITE V0.01", "ACEA QUIGG 11/20", "BOOTING...", 3)

# we need to do the following the first time after flashing micropython for webrepl setup:
if runner.first_boot_ever:
	import webrepl_setup
	if runner.oled_attached:
		runner.oled_update("WEBREPL SETUP...", "", "", 0)

# if debug True connect WiFi etc., elif, the mode button is pressed during boot, connect WiFi etc.
if not runner.mode_button.value() or runner.debug: # run if mode button not pressed at boot
	print("LOOKING FOR KNOWN SSIDs...")
	if runner.oled_attached:
		runner.oled_update("LOOKING FOR", "KNOWN SSIDS...", "", 2)
	runner.connectWiFi()
	import webrepl
	webrepl.start()

# over to main.py now

