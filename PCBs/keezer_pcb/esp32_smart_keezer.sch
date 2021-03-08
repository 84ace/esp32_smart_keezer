EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "ESP32 Smart Keezer"
Date "2021-03-08"
Rev "0"
Comp "Acea Quigg"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR08
U 1 1 5EFCF275
P 7655 2106
F 0 "#PWR08" H 7655 1856 50  0001 C CNN
F 1 "GND" V 7655 1906 50  0000 C CNN
F 2 "" H 7655 2106 50  0001 C CNN
F 3 "" H 7655 2106 50  0001 C CNN
	1    7655 2106
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5EFCFB7F
P 6855 4106
F 0 "#PWR04" H 6855 3856 50  0001 C CNN
F 1 "GND" H 6860 3933 50  0000 C CNN
F 2 "" H 6855 4106 50  0001 C CNN
F 3 "" H 6855 4106 50  0001 C CNN
	1    6855 4106
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR02
U 1 1 5F01533D
P 6355 1016
F 0 "#PWR02" H 6355 866 50  0001 C CNN
F 1 "+3V3" H 6370 1189 50  0000 C CNN
F 2 "" H 6355 1016 50  0001 C CNN
F 3 "" H 6355 1016 50  0001 C CNN
	1    6355 1016
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5F08B08D
P 5965 3241
F 0 "#PWR013" H 5965 2991 50  0001 C CNN
F 1 "GND" H 5970 3068 50  0000 C CNN
F 2 "" H 5965 3241 50  0001 C CNN
F 3 "" H 5965 3241 50  0001 C CNN
	1    5965 3241
	1    0    0    -1  
$EndComp
Text GLabel 7455 1606 2    50   Output ~ 0
TXD
Text GLabel 7455 1806 2    50   Input ~ 0
RXD
Text GLabel 10438 1480 2    50   Input ~ 0
TXD
Text GLabel 10438 1380 2    50   Input ~ 0
RXD
$Comp
L Device:LED D1
U 1 1 5F05CC6B
P 10684 3870
F 0 "D1" V 10723 3753 50  0000 R CNN
F 1 "MAIN LED" V 10632 3753 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 10684 3870 50  0001 C CNN
F 3 "" H 10684 3870 50  0001 C CNN
F 4 "C2286" H 10684 3870 50  0001 C CNN "lcsc_part_number"
F 5 "https://jlcpcb.com/parts/componentSearch?secondSortUuid=ac4c3bf204dc486cb0c9c3fc16ef0c61&name=Light%20Emitting%20Diodes%20(LED)&firstSortUuid=f972da204e9147268b09e5e9b0c6292d" H 10684 3870 50  0001 C CNN "lcsc_url"
F 6 "0603" H 10684 3870 50  0001 C CNN "package"
	1    10684 3870
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5F06058B
P 10684 4220
F 0 "#PWR03" H 10684 3970 50  0001 C CNN
F 1 "GND" H 10824 4086 50  0000 C CNN
F 2 "" H 10684 4220 50  0001 C CNN
F 3 "" H 10684 4220 50  0001 C CNN
	1    10684 4220
	1    0    0    -1  
$EndComp
Text GLabel 10684 3720 1    50   Input ~ 0
SYS_OK_LED
$Comp
L power:GND #PWR06
U 1 1 5F061708
P 10018 4211
F 0 "#PWR06" H 10018 3961 50  0001 C CNN
F 1 "GND" H 10158 4077 50  0000 C CNN
F 2 "" H 10018 4211 50  0001 C CNN
F 3 "" H 10018 4211 50  0001 C CNN
	1    10018 4211
	1    0    0    -1  
$EndComp
Text Notes 10110 2886 0    50   ~ 0
Status LEDS\n
Text Notes 6713 671  0    50   ~ 0
ESP-32
Wire Notes Line
	10724 1149 10724 1145
Text GLabel 7455 2906 2    50   BiDi ~ 0
SDA
Text GLabel 7455 3006 2    50   Output ~ 0
SCL
$Comp
L power:GND #PWR012
U 1 1 5F553B72
P 5965 2791
F 0 "#PWR012" H 5965 2541 50  0001 C CNN
F 1 "GND" H 5970 2618 50  0000 C CNN
F 2 "" H 5965 2791 50  0001 C CNN
F 3 "" H 5965 2791 50  0001 C CNN
	1    5965 2791
	1    0    0    -1  
$EndComp
Text GLabel 5365 2791 0    50   Input ~ 0
RST
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5F1D7B08
P 3196 962
F 0 "#FLG01" H 3196 1037 50  0001 C CNN
F 1 "PWR_FLAG" H 3196 1135 50  0000 C CNN
F 2 "" H 3196 962 50  0001 C CNN
F 3 "~" H 3196 962 50  0001 C CNN
	1    3196 962 
	1    0    0    -1  
$EndComp
Text Notes 3046 662  0    50   ~ 0
DC-DC Buck (30V, 3.3V, 1.5A)
Wire Notes Line
	3569 917  3567 917 
Text GLabel 7805 1506 2    50   Input ~ 0
BOOT
Text GLabel 5365 3241 0    50   Input ~ 0
BOOT
NoConn ~ 7455 1706
NoConn ~ 7455 2006
NoConn ~ 6255 2706
NoConn ~ 6255 2806
NoConn ~ 6255 2906
NoConn ~ 6255 3006
NoConn ~ 6255 3106
NoConn ~ 6255 3206
$Comp
L RF_Module:ESP32-WROOM-32D U1
U 1 1 5EFC6F57
P 6855 2706
F 0 "U1" H 6855 4287 50  0000 C CNN
F 1 "ESP32-WROOM-32D" H 6855 4196 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 6855 1206 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32d_esp32-wroom-32u_datasheet_en.pdf" H 6555 2756 50  0001 C CNN
F 4 "C473012" H 6855 2706 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/RF-Transceiver-ICs_Espressif-Systems-ESP32-WROOM-32D_C473012.html" H 6855 2706 50  0001 C CNN "lcsc_url"
F 6 "1" H 6855 2706 50  0001 C CNN "lcsc_min_qty"
F 7 "ESP32-WROOM-32D" H 6855 2706 50  0001 C CNN "mfr_part_number"
F 8 "SMD-38" H 6855 2706 50  0001 C CNN "package"
	1    6855 2706
	1    0    0    -1  
$EndComp
Wire Wire Line
	6855 1306 6355 1306
$Comp
L Interface_USB:CH330N U5
U 1 1 5F737302
P 10038 1480
F 0 "U5" H 9683 1980 50  0000 C CNN
F 1 "CH330N" H 9788 1885 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 9888 2230 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/1811151442_WCH-Jiangsu-Qin-Heng-CH330N_C108996.pdf" H 9938 1680 50  0001 C CNN
F 4 "C108996" H 10038 1480 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/USB-ICs_WCH-Jiangsu-Qin-Heng-CH330N_C108996.html" H 10038 1480 50  0001 C CNN "lcsc_url"
F 6 "1" H 10038 1480 50  0001 C CNN "lcsc_min_qty"
F 7 "CH330N" H 10038 1480 50  0001 C CNN "mfr_part_number"
F 8 "SOP-8" H 10038 1480 50  0001 C CNN "package"
	1    10038 1480
	1    0    0    -1  
$EndComp
$Comp
L MAX17260:GND #PWR035
U 1 1 5F737308
P 10038 1880
F 0 "#PWR035" H 10038 1880 30  0001 C CNN
F 1 "GND" H 10038 1810 30  0001 C CNN
F 2 "" H 10038 1880 60  0000 C CNN
F 3 "" H 10038 1880 60  0000 C CNN
	1    10038 1880
	1    0    0    -1  
$EndComp
$Comp
L MAX17260:GND #PWR033
U 1 1 5F73730F
P 9238 1580
F 0 "#PWR033" H 9238 1580 30  0001 C CNN
F 1 "GND" H 9238 1510 30  0001 C CNN
F 2 "" H 9238 1580 60  0000 C CNN
F 3 "" H 9238 1580 60  0000 C CNN
	1    9238 1580
	1    0    0    -1  
$EndComp
Text GLabel 9638 1580 0    50   Input ~ 0
D+
Text GLabel 9638 1680 0    50   Input ~ 0
D-
$Comp
L MAX17260:GND #PWR038
U 1 1 5F737323
P 10338 1180
F 0 "#PWR038" H 10338 1180 30  0001 C CNN
F 1 "GND" H 10338 1110 30  0001 C CNN
F 2 "" H 10338 1180 60  0000 C CNN
F 3 "" H 10338 1180 60  0000 C CNN
	1    10338 1180
	1    0    0    -1  
$EndComp
Wire Wire Line
	9238 1380 9638 1380
$Comp
L power:+3V3 #PWR039
U 1 1 5F77B761
P 10038 930
F 0 "#PWR039" H 10038 780 50  0001 C CNN
F 1 "+3V3" H 10053 1103 50  0000 C CNN
F 2 "" H 10038 930 50  0001 C CNN
F 3 "" H 10038 930 50  0001 C CNN
	1    10038 930 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10038 1180 10038 980 
NoConn ~ 10438 1680
$Comp
L MAX17260:GND #PWR026
U 1 1 5F7D6D14
P 1268 1741
F 0 "#PWR026" H 1268 1741 30  0001 C CNN
F 1 "GND" H 1268 1671 30  0001 C CNN
F 2 "" H 1268 1741 60  0000 C CNN
F 3 "" H 1268 1741 60  0000 C CNN
	1    1268 1741
	1    0    0    -1  
$EndComp
Text GLabel 1568 1341 2    50   Input ~ 0
D+
Text GLabel 1568 1441 2    50   Input ~ 0
D-
Text GLabel 1568 1141 2    50   Input ~ 0
5V
NoConn ~ 1568 1541
NoConn ~ 1168 1741
$Comp
L Connector:USB_B_Micro J11
U 1 1 5F7D6D24
P 1268 1341
F 0 "J11" H 1325 1808 50  0000 C CNN
F 1 "USB_B_Micro" H 1325 1717 50  0000 C CNN
F 2 "Acea:USB_Micro_SHOU-HAN-MicroXNJ_C404969_Horizontal" H 1418 1291 50  0001 C CNN
F 3 "" H 1418 1291 50  0001 C CNN
F 4 "C404969" H 1268 1341 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/USB-Connectors_SHOU-HAN-MicroXNJ_C404969.html/?href=jlc-SMT" H 1268 1341 50  0001 C CNN "lcsc_url"
F 6 "micro_usb" H 1268 1341 50  0001 C CNN "package"
	1    1268 1341
	1    0    0    -1  
$EndComp
Text Notes 1207 668  0    50   ~ 0
USB
Text Notes 9838 680  0    50   ~ 0
UART-USB
$Comp
L Device:C_Small C2
U 1 1 5F921787
P 3096 1262
F 0 "C2" H 2896 1312 50  0000 L CNN
F 1 "100n" H 2796 1220 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3096 1262 50  0001 C CNN
F 3 "" H 3096 1262 50  0001 C CNN
F 4 "C14663" H 3096 1262 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Multilayer-Ceramic-Capacitors-MLCC-SMD-SMT_100nF-104-10-50V_C14663.html/?href=jlc-SMT" H 3096 1262 50  0001 C CNN "lcsc_url"
F 6 "0603" H 3096 1262 50  0001 C CNN "package"
	1    3096 1262
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C3
U 1 1 5F922B54
P 4446 1262
F 0 "C3" H 4534 1308 50  0000 L CNN
F 1 "1uF" H 4534 1217 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-21_Kemet-B" H 4446 1262 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Honor-Elec-RVT1V220M0505_C23289.pdf" H 4446 1262 50  0001 C CNN
F 4 "C169224" H 4446 1262 50  0001 C CNN "lcsc_part_number"
F 5 "CASE-B_3528" H 4446 1262 50  0001 C CNN "package"
	1    4446 1262
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5F925604
P 3646 1662
F 0 "#PWR07" H 3646 1412 50  0001 C CNN
F 1 "GND" H 3651 1489 50  0000 C CNN
F 2 "" H 3646 1662 50  0001 C CNN
F 3 "" H 3646 1662 50  0001 C CNN
	1    3646 1662
	1    0    0    -1  
$EndComp
Wire Wire Line
	3096 1162 3196 1162
$Comp
L power:GND #PWR011
U 1 1 5F9298A2
P 4446 1362
F 0 "#PWR011" H 4446 1112 50  0001 C CNN
F 1 "GND" H 4451 1189 50  0000 C CNN
F 2 "" H 4446 1362 50  0001 C CNN
F 3 "" H 4446 1362 50  0001 C CNN
	1    4446 1362
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5F929D37
P 3096 1362
F 0 "#PWR05" H 3096 1112 50  0001 C CNN
F 1 "GND" H 3101 1189 50  0000 C CNN
F 2 "" H 3096 1362 50  0001 C CNN
F 3 "" H 3096 1362 50  0001 C CNN
	1    3096 1362
	1    0    0    -1  
$EndComp
Connection ~ 3096 1162
$Comp
L power:+3V3 #PWR010
U 1 1 5F92C138
P 4446 1012
F 0 "#PWR010" H 4446 862 50  0001 C CNN
F 1 "+3V3" H 4461 1185 50  0000 C CNN
F 2 "" H 4446 1012 50  0001 C CNN
F 3 "" H 4446 1012 50  0001 C CNN
	1    4446 1012
	1    0    0    -1  
$EndComp
Wire Wire Line
	4446 1012 4446 1162
Connection ~ 4446 1162
NoConn ~ 6255 1706
NoConn ~ 6255 1806
NoConn ~ 7455 2806
NoConn ~ 7455 3106
Text GLabel 7455 3406 2    50   Input ~ 0
P7
Text GLabel 7455 2306 2    50   Input ~ 0
P3
Text GLabel 7455 3206 2    50   Input ~ 0
P5
Text GLabel 7455 3506 2    50   Input ~ 0
P8
Text GLabel 7455 3306 2    50   Input ~ 0
P6
Text GLabel 2696 1162 0    50   Input ~ 0
5V
Wire Wire Line
	3196 962  3196 1162
Connection ~ 3196 1162
Wire Wire Line
	2696 1162 3096 1162
$Comp
L MAX17260:TACT-SWITCH SW1
U 1 1 5FA6E558
P 5665 2791
F 0 "SW1" H 5665 3046 50  0000 C CNN
F 1 "C492887" H 5665 2955 50  0000 C CNN
F 2 "Acea:TS4550TP" H 5665 3068 60  0001 C CNN
F 3 "" H 5665 2962 60  0001 C CNN
F 4 "C492887" H 5665 2791 50  0001 C CNN "lcsc_part_number"
F 5 "TS-1091S-A5B3-C1D2" H 5665 2791 50  0001 C CNN "mfr_part_number"
F 6 "4.5mm,4.5mm SMD" H 5665 2791 50  0001 C CNN "package"
	1    5665 2791
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5FB48816
P 8305 4156
F 0 "#PWR0101" H 8305 3906 50  0001 C CNN
F 1 "GND" H 8310 3983 50  0000 C CNN
F 2 "" H 8305 4156 50  0001 C CNN
F 3 "" H 8305 4156 50  0001 C CNN
	1    8305 4156
	1    0    0    -1  
$EndComp
Text GLabel 7705 4156 0    50   Input ~ 0
MODE
Text GLabel 8155 3606 2    50   Input ~ 0
MODE
Wire Wire Line
	5605 1156 5605 1206
$Comp
L power:GND #PWR037
U 1 1 5F9329D9
P 5605 1406
F 0 "#PWR037" H 5605 1156 50  0001 C CNN
F 1 "GND" H 5610 1233 50  0000 C CNN
F 2 "" H 5605 1406 50  0001 C CNN
F 3 "" H 5605 1406 50  0001 C CNN
	1    5605 1406
	1    0    0    -1  
$EndComp
Wire Wire Line
	5305 1156 5305 1206
$Comp
L power:GND #PWR036
U 1 1 5F941D3A
P 5305 1406
F 0 "#PWR036" H 5305 1156 50  0001 C CNN
F 1 "GND" H 5310 1233 50  0000 C CNN
F 2 "" H 5305 1406 50  0001 C CNN
F 3 "" H 5305 1406 50  0001 C CNN
	1    5305 1406
	1    0    0    -1  
$EndComp
Wire Wire Line
	6855 1306 7555 1306
Connection ~ 6855 1306
Wire Wire Line
	8155 3606 8105 3606
Wire Wire Line
	8105 3606 8105 3506
$Comp
L power:+3V3 #PWR042
U 1 1 5F95F2CA
P 8105 3306
F 0 "#PWR042" H 8105 3156 50  0001 C CNN
F 1 "+3V3" H 8120 3479 50  0000 C CNN
F 2 "" H 8105 3306 50  0001 C CNN
F 3 "" H 8105 3306 50  0001 C CNN
	1    8105 3306
	1    0    0    -1  
$EndComp
Wire Wire Line
	8105 3606 7455 3606
Connection ~ 8105 3606
Wire Notes Line
	10752 3751 10750 3751
Text Notes 5305 4256 0    50   ~ 0
pins with pullups:\n14, 16, 17, 18, 19, 21, 22, 23
Text Notes 7755 1956 0    50   ~ 0
RTC_GPIO10
Text Notes 7750 2350 0    50   ~ 0
RTC_GPIO16
Text Notes 7750 3250 0    50   ~ 0
RTC_6
Text Notes 7755 3556 0    50   ~ 0
RTC_9
Text GLabel 7455 2406 2    50   Input ~ 0
P4
Text Notes 7750 2450 0    50   ~ 0
RTC_GPIO13
Text GLabel 7455 2206 2    50   Input ~ 0
P2
Text GLabel 7455 1906 2    50   Input ~ 0
P1
Text Notes 7750 3350 0    50   ~ 0
RTC_7
Text Notes 7750 3450 0    50   ~ 0
RTC_17
Wire Wire Line
	6355 1306 6355 1156
Wire Wire Line
	6355 1156 5955 1156
Text GLabel 5905 1506 0    50   Input ~ 0
RST
Wire Wire Line
	5955 1156 5955 1206
Connection ~ 5955 1506
Wire Wire Line
	5955 1506 5955 1406
$Comp
L power:GND #PWR01
U 1 1 5F088CED
P 5955 1706
F 0 "#PWR01" H 5955 1456 50  0001 C CNN
F 1 "GND" H 5960 1533 50  0000 C CNN
F 2 "" H 5955 1706 50  0001 C CNN
F 3 "" H 5955 1706 50  0001 C CNN
	1    5955 1706
	1    0    0    -1  
$EndComp
Wire Wire Line
	5955 1156 5605 1156
Connection ~ 5955 1156
Wire Wire Line
	5605 1156 5305 1156
Connection ~ 5605 1156
Connection ~ 6355 1156
Wire Wire Line
	5955 1506 6255 1506
Wire Wire Line
	5955 1506 5905 1506
Wire Wire Line
	10338 980  10038 980 
Connection ~ 10038 980 
Wire Wire Line
	10038 980  10038 930 
$Comp
L Device:LED D3
U 1 1 601D72B1
P 10018 3861
F 0 "D3" V 10057 3744 50  0000 R CNN
F 1 "POWER LED" V 9966 3744 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 10018 3861 50  0001 C CNN
F 3 "" H 10018 3861 50  0001 C CNN
F 4 "C2286" H 10018 3861 50  0001 C CNN "lcsc_part_number"
F 5 "https://jlcpcb.com/parts/componentSearch?secondSortUuid=ac4c3bf204dc486cb0c9c3fc16ef0c61&name=Light%20Emitting%20Diodes%20(LED)&firstSortUuid=f972da204e9147268b09e5e9b0c6292d" H 10018 3861 50  0001 C CNN "lcsc_url"
F 6 "0603" H 10018 3861 50  0001 C CNN "package"
	1    10018 3861
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R2
U 1 1 60200AF2
P 10684 4120
F 0 "R2" H 10804 4172 50  0000 C CNN
F 1 "3.6k" H 10834 4070 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 10684 4120 50  0001 C CNN
F 3 "" H 10684 4120 50  0001 C CNN
F 4 "C22980" H 10684 4120 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF3601T5E_C22980.html/?href=jlc-SMT" H 10684 4120 50  0001 C CNN "lcsc_url"
F 6 "0603" H 10684 4120 50  0001 C CNN "package"
	1    10684 4120
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R3
U 1 1 6020A43C
P 10018 4111
F 0 "R3" H 10138 4163 50  0000 C CNN
F 1 "3.6k" H 10168 4061 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 10018 4111 50  0001 C CNN
F 3 "" H 10018 4111 50  0001 C CNN
F 4 "C22980" H 10018 4111 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF3601T5E_C22980.html/?href=jlc-SMT" H 10018 4111 50  0001 C CNN "lcsc_url"
F 6 "0603" H 10018 4111 50  0001 C CNN "package"
	1    10018 4111
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM317_TO-252 U2
U 1 1 60258F21
P 3646 1162
F 0 "U2" H 3646 1404 50  0000 C CNN
F 1 "LM317AG-TN3-R" H 3646 1313 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-252-2" H 3646 1412 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/snvs774n/snvs774n.pdf" H 3646 1162 50  0001 C CNN
F 4 "C75510" H 3646 1162 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Linear-Voltage-Regulators_LM317AL-TN3-R_C75510.html/?href=jlc-SMT" H 3646 1162 50  0001 C CNN "lcsc_url"
F 6 "TO-252-2" H 3646 1162 50  0001 C CNN "package"
	1    3646 1162
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R25
U 1 1 602631DD
P 4146 1262
F 0 "R25" H 3932 1281 50  0000 L CNN
F 1 "200R" H 3896 1212 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 4146 1262 50  0001 C CNN
F 3 "" H 4146 1262 50  0001 C CNN
F 4 "C8218" H 4146 1262 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF2000T5E_C8218.html/?href=jlc-SMT" H 4146 1262 50  0001 C CNN "lcsc_url"
F 6 "0603" H 4146 1262 50  0001 C CNN "package"
	1    4146 1262
	1    0    0    -1  
$EndComp
Wire Wire Line
	3946 1162 4146 1162
Wire Wire Line
	4146 1162 4446 1162
Connection ~ 4146 1162
Wire Wire Line
	3196 1162 3346 1162
$Comp
L Device:CP_Small C11
U 1 1 6028CBD1
P 5305 1306
F 0 "C11" H 5355 1406 50  0000 L CNN
F 1 "1uF" H 5405 1306 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-3528-21_Kemet-B" H 5305 1306 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Honor-Elec-RVT1V220M0505_C23289.pdf" H 5305 1306 50  0001 C CNN
F 4 "C169224" H 5305 1306 50  0001 C CNN "lcsc_part_number"
F 5 "CASE-B_3528" H 5305 1306 50  0001 C CNN "package"
	1    5305 1306
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 6028D96A
P 5605 1306
F 0 "C12" H 5655 1406 50  0000 L CNN
F 1 "100n" H 5705 1306 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 5605 1306 50  0001 C CNN
F 3 "" H 5605 1306 50  0001 C CNN
F 4 "C14663" H 5605 1306 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Multilayer-Ceramic-Capacitors-MLCC-SMD-SMT_100nF-104-10-50V_C14663.html/?href=jlc-SMT" H 5605 1306 50  0001 C CNN "lcsc_url"
F 6 "0603" H 5605 1306 50  0001 C CNN "package"
	1    5605 1306
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 60294ADE
P 5955 1306
F 0 "R1" H 6075 1358 50  0000 C CNN
F 1 "11k" H 6105 1256 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 5955 1306 50  0001 C CNN
F 3 "" H 5955 1306 50  0001 C CNN
F 4 "C25950" H 5955 1306 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF1102T5E_C25950.html/?href=jlc-SMT" H 5955 1306 50  0001 C CNN "lcsc_url"
F 6 "0603" H 5955 1306 50  0001 C CNN "package"
	1    5955 1306
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 6029E8F3
P 5955 1606
F 0 "C1" H 6055 1656 50  0000 L CNN
F 1 "100n" H 6055 1556 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 5955 1606 50  0001 C CNN
F 3 "" H 5955 1606 50  0001 C CNN
F 4 "C14663" H 5955 1606 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Multilayer-Ceramic-Capacitors-MLCC-SMD-SMT_100nF-104-10-50V_C14663.html/?href=jlc-SMT" H 5955 1606 50  0001 C CNN "lcsc_url"
F 6 "0603" H 5955 1606 50  0001 C CNN "package"
	1    5955 1606
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R8
U 1 1 6029FA67
P 7555 1406
F 0 "R8" H 7675 1458 50  0000 C CNN
F 1 "11k" H 7705 1356 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 7555 1406 50  0001 C CNN
F 3 "" H 7555 1406 50  0001 C CNN
F 4 "C25950" H 7555 1406 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF1102T5E_C25950.html/?href=jlc-SMT" H 7555 1406 50  0001 C CNN "lcsc_url"
F 6 "0603" H 7555 1406 50  0001 C CNN "package"
	1    7555 1406
	1    0    0    -1  
$EndComp
Wire Wire Line
	7455 1506 7555 1506
Connection ~ 7555 1506
Wire Wire Line
	7555 1506 7805 1506
$Comp
L Device:R_Small R4
U 1 1 602AFB4C
P 7555 2106
F 0 "R4" V 7455 2106 50  0000 C CNN
F 1 "11k" V 7555 2106 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 7555 2106 50  0001 C CNN
F 3 "" H 7555 2106 50  0001 C CNN
F 4 "C25950" H 7555 2106 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF1102T5E_C25950.html/?href=jlc-SMT" H 7555 2106 50  0001 C CNN "lcsc_url"
F 6 "0603" H 7555 2106 50  0001 C CNN "package"
	1    7555 2106
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R9
U 1 1 602C0380
P 8105 3406
F 0 "R9" V 8005 3406 50  0000 C CNN
F 1 "11k" V 8105 3406 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 8105 3406 50  0001 C CNN
F 3 "" H 8105 3406 50  0001 C CNN
F 4 "C25950" H 8105 3406 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF1102T5E_C25950.html/?href=jlc-SMT" H 8105 3406 50  0001 C CNN "lcsc_url"
F 6 "0603" H 8105 3406 50  0001 C CNN "package"
	1    8105 3406
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C10
U 1 1 602F00D0
P 10338 1080
F 0 "C10" H 10388 1180 50  0000 L CNN
F 1 "100n" H 10438 1080 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10338 1080 50  0001 C CNN
F 3 "" H 10338 1080 50  0001 C CNN
F 4 "C14663" H 10338 1080 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Multilayer-Ceramic-Capacitors-MLCC-SMD-SMT_100nF-104-10-50V_C14663.html/?href=jlc-SMT" H 10338 1080 50  0001 C CNN "lcsc_url"
F 6 "0603" H 10338 1080 50  0001 C CNN "package"
	1    10338 1080
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C9
U 1 1 602F963B
P 9238 1480
F 0 "C9" H 9288 1580 50  0000 L CNN
F 1 "100n" H 9338 1480 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 9238 1480 50  0001 C CNN
F 3 "" H 9238 1480 50  0001 C CNN
F 4 "C14663" H 9238 1480 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Multilayer-Ceramic-Capacitors-MLCC-SMD-SMT_100nF-104-10-50V_C14663.html/?href=jlc-SMT" H 9238 1480 50  0001 C CNN "lcsc_url"
F 6 "0603" H 9238 1480 50  0001 C CNN "package"
	1    9238 1480
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R26
U 1 1 60268CD5
P 3646 1562
F 0 "R26" H 3446 1612 50  0000 L CNN
F 1 "330R" H 3396 1512 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 3646 1562 50  0001 C CNN
F 3 "" H 3646 1562 50  0001 C CNN
F 4 "C23138" H 3646 1562 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Chip-Resistor-Surface-Mount_Uniroyal-Elec-0603WAF3300T5E_C23138.html/?href=jlc-SMT" H 3646 1562 50  0001 C CNN "lcsc_url"
F 6 "0603" H 3646 1562 50  0001 C CNN "package"
	1    3646 1562
	1    0    0    -1  
$EndComp
Wire Wire Line
	3646 1462 4146 1462
Wire Wire Line
	4146 1462 4146 1362
Connection ~ 3646 1462
$Comp
L MAX17260:TACT-SWITCH SW2
U 1 1 601FAFC2
P 5665 3241
F 0 "SW2" H 5665 3496 50  0000 C CNN
F 1 "C492887" H 5665 3405 50  0000 C CNN
F 2 "Acea:TS4550TP" H 5665 3518 60  0001 C CNN
F 3 "" H 5665 3412 60  0001 C CNN
F 4 "C492887" H 5665 3241 50  0001 C CNN "lcsc_part_number"
F 5 "TS-1091S-A5B3-C1D2" H 5665 3241 50  0001 C CNN "mfr_part_number"
F 6 "4.5mm,4.5mm SMD" H 5665 3241 50  0001 C CNN "package"
	1    5665 3241
	1    0    0    -1  
$EndComp
$Comp
L MAX17260:TACT-SWITCH SW3
U 1 1 602008AF
P 8005 4156
F 0 "SW3" H 8005 4411 50  0000 C CNN
F 1 "C492887" H 8005 4320 50  0000 C CNN
F 2 "Acea:TS4550TP" H 8005 4433 60  0001 C CNN
F 3 "" H 8005 4327 60  0001 C CNN
F 4 "C492887" H 8005 4156 50  0001 C CNN "lcsc_part_number"
F 5 "TS-1091S-A5B3-C1D2" H 8005 4156 50  0001 C CNN "mfr_part_number"
F 6 "4.5mm,4.5mm SMD" H 8005 4156 50  0001 C CNN "package"
	1    8005 4156
	1    0    0    -1  
$EndComp
Wire Wire Line
	6355 1156 6355 1016
Text GLabel 4146 1092 1    50   Output ~ 0
3v3VD
Wire Wire Line
	4146 1092 4146 1162
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 60554F44
P 1150 4550
F 0 "J1" H 992 4915 50  0000 L CNN
F 1 "Conn_01x03_Male" H 758 4816 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 1150 4550 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 1150 4550 50  0001 C CNN
F 4 "C780061" H 1150 4550 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 1150 4550 50  0001 C CNN "lcsc_url"
F 6 "5" H 1150 4550 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 1150 4550 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 1150 4550 50  0001 C CNN "package"
	1    1150 4550
	1    0    0    -1  
$EndComp
Text Notes 900  4650 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR09
U 1 1 60554F67
P 1350 4450
F 0 "#PWR09" H 1350 4200 50  0001 C CNN
F 1 "GND" V 1351 4231 50  0000 C CNN
F 2 "" H 1350 4450 50  0001 C CNN
F 3 "" H 1350 4450 50  0001 C CNN
	1    1350 4450
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR014
U 1 1 60554F79
P 1350 4650
F 0 "#PWR014" H 1350 4500 50  0001 C CNN
F 1 "+3V3" V 1350 4900 50  0000 C CNN
F 2 "" H 1350 4650 50  0001 C CNN
F 3 "" H 1350 4650 50  0001 C CNN
	1    1350 4650
	0    1    1    0   
$EndComp
Text GLabel 1350 4550 2    50   Input ~ 0
P1
$Comp
L power:+3V3 #PWR040
U 1 1 6055DCB3
P 10018 3711
F 0 "#PWR040" H 10018 3561 50  0001 C CNN
F 1 "+3V3" H 10033 3884 50  0000 C CNN
F 2 "" H 10018 3711 50  0001 C CNN
F 3 "" H 10018 3711 50  0001 C CNN
	1    10018 3711
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J4
U 1 1 604F686E
P 1100 6700
F 0 "J4" H 942 7065 50  0000 L CNN
F 1 "Conn_01x03_Male" H 708 6966 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 1100 6700 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 1100 6700 50  0001 C CNN
F 4 "C780061" H 1100 6700 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 1100 6700 50  0001 C CNN "lcsc_url"
F 6 "5" H 1100 6700 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 1100 6700 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 1100 6700 50  0001 C CNN "package"
	1    1100 6700
	1    0    0    -1  
$EndComp
Text Notes 850  6800 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR019
U 1 1 604F6891
P 1300 6600
F 0 "#PWR019" H 1300 6350 50  0001 C CNN
F 1 "GND" V 1301 6381 50  0000 C CNN
F 2 "" H 1300 6600 50  0001 C CNN
F 3 "" H 1300 6600 50  0001 C CNN
	1    1300 6600
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR020
U 1 1 604F68A3
P 1300 6800
F 0 "#PWR020" H 1300 6650 50  0001 C CNN
F 1 "+3V3" V 1300 7050 50  0000 C CNN
F 2 "" H 1300 6800 50  0001 C CNN
F 3 "" H 1300 6800 50  0001 C CNN
	1    1300 6800
	0    1    1    0   
$EndComp
Text GLabel 1300 6700 2    50   Input ~ 0
P4
$Comp
L Connector:Conn_01x03_Male J5
U 1 1 604FBCBD
P 1100 7450
F 0 "J5" H 942 7815 50  0000 L CNN
F 1 "Conn_01x03_Male" H 708 7716 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 1100 7450 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 1100 7450 50  0001 C CNN
F 4 "C780061" H 1100 7450 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 1100 7450 50  0001 C CNN "lcsc_url"
F 6 "5" H 1100 7450 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 1100 7450 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 1100 7450 50  0001 C CNN "package"
	1    1100 7450
	1    0    0    -1  
$EndComp
Text Notes 850  7550 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR021
U 1 1 604FBCE0
P 1300 7350
F 0 "#PWR021" H 1300 7100 50  0001 C CNN
F 1 "GND" V 1301 7131 50  0000 C CNN
F 2 "" H 1300 7350 50  0001 C CNN
F 3 "" H 1300 7350 50  0001 C CNN
	1    1300 7350
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR022
U 1 1 604FBCF2
P 1300 7550
F 0 "#PWR022" H 1300 7400 50  0001 C CNN
F 1 "+3V3" V 1300 7800 50  0000 C CNN
F 2 "" H 1300 7550 50  0001 C CNN
F 3 "" H 1300 7550 50  0001 C CNN
	1    1300 7550
	0    1    1    0   
$EndComp
Text GLabel 1300 7450 2    50   Input ~ 0
P5
$Comp
L Connector:Conn_01x03_Male J2
U 1 1 604FBD10
P 1100 5250
F 0 "J2" H 942 5615 50  0000 L CNN
F 1 "Conn_01x03_Male" H 708 5516 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 1100 5250 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 1100 5250 50  0001 C CNN
F 4 "C780061" H 1100 5250 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 1100 5250 50  0001 C CNN "lcsc_url"
F 6 "5" H 1100 5250 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 1100 5250 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 1100 5250 50  0001 C CNN "package"
	1    1100 5250
	1    0    0    -1  
$EndComp
Text Notes 850  5350 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR015
U 1 1 604FBD33
P 1300 5150
F 0 "#PWR015" H 1300 4900 50  0001 C CNN
F 1 "GND" V 1301 4931 50  0000 C CNN
F 2 "" H 1300 5150 50  0001 C CNN
F 3 "" H 1300 5150 50  0001 C CNN
	1    1300 5150
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR016
U 1 1 604FBD45
P 1300 5350
F 0 "#PWR016" H 1300 5200 50  0001 C CNN
F 1 "+3V3" V 1300 5600 50  0000 C CNN
F 2 "" H 1300 5350 50  0001 C CNN
F 3 "" H 1300 5350 50  0001 C CNN
	1    1300 5350
	0    1    1    0   
$EndComp
Text GLabel 1300 5250 2    50   Input ~ 0
P2
$Comp
L Connector:Conn_01x03_Male J3
U 1 1 6050547B
P 1100 6000
F 0 "J3" H 942 6365 50  0000 L CNN
F 1 "Conn_01x03_Male" H 708 6266 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 1100 6000 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 1100 6000 50  0001 C CNN
F 4 "C780061" H 1100 6000 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 1100 6000 50  0001 C CNN "lcsc_url"
F 6 "5" H 1100 6000 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 1100 6000 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 1100 6000 50  0001 C CNN "package"
	1    1100 6000
	1    0    0    -1  
$EndComp
Text Notes 850  6100 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR017
U 1 1 6050549E
P 1300 5900
F 0 "#PWR017" H 1300 5650 50  0001 C CNN
F 1 "GND" V 1301 5681 50  0000 C CNN
F 2 "" H 1300 5900 50  0001 C CNN
F 3 "" H 1300 5900 50  0001 C CNN
	1    1300 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR018
U 1 1 605054B0
P 1300 6100
F 0 "#PWR018" H 1300 5950 50  0001 C CNN
F 1 "+3V3" V 1300 6350 50  0000 C CNN
F 2 "" H 1300 6100 50  0001 C CNN
F 3 "" H 1300 6100 50  0001 C CNN
	1    1300 6100
	0    1    1    0   
$EndComp
Text GLabel 1300 6000 2    50   Input ~ 0
P3
$Comp
L Connector:Conn_01x03_Male J10
U 1 1 60507E5D
P 2350 4550
F 0 "J10" H 2192 4915 50  0000 L CNN
F 1 "Conn_01x03_Male" H 1958 4816 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 2350 4550 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 2350 4550 50  0001 C CNN
F 4 "C780061" H 2350 4550 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 2350 4550 50  0001 C CNN "lcsc_url"
F 6 "5" H 2350 4550 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 2350 4550 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 2350 4550 50  0001 C CNN "package"
	1    2350 4550
	1    0    0    -1  
$EndComp
Text Notes 2100 4650 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR032
U 1 1 60507E80
P 2550 4450
F 0 "#PWR032" H 2550 4200 50  0001 C CNN
F 1 "GND" V 2551 4231 50  0000 C CNN
F 2 "" H 2550 4450 50  0001 C CNN
F 3 "" H 2550 4450 50  0001 C CNN
	1    2550 4450
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR034
U 1 1 60507E92
P 2550 4650
F 0 "#PWR034" H 2550 4500 50  0001 C CNN
F 1 "+3V3" V 2550 4900 50  0000 C CNN
F 2 "" H 2550 4650 50  0001 C CNN
F 3 "" H 2550 4650 50  0001 C CNN
	1    2550 4650
	0    1    1    0   
$EndComp
Text GLabel 2550 4550 2    50   Input ~ 0
P6
$Comp
L Connector:Conn_01x03_Male J8
U 1 1 60507EB0
P 2300 5250
F 0 "J8" H 2142 5615 50  0000 L CNN
F 1 "Conn_01x03_Male" H 1908 5516 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 2300 5250 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 2300 5250 50  0001 C CNN
F 4 "C780061" H 2300 5250 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 2300 5250 50  0001 C CNN "lcsc_url"
F 6 "5" H 2300 5250 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 2300 5250 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 2300 5250 50  0001 C CNN "package"
	1    2300 5250
	1    0    0    -1  
$EndComp
Text Notes 2050 5350 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR028
U 1 1 60507ED3
P 2500 5150
F 0 "#PWR028" H 2500 4900 50  0001 C CNN
F 1 "GND" V 2501 4931 50  0000 C CNN
F 2 "" H 2500 5150 50  0001 C CNN
F 3 "" H 2500 5150 50  0001 C CNN
	1    2500 5150
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR029
U 1 1 60507EE5
P 2500 5350
F 0 "#PWR029" H 2500 5200 50  0001 C CNN
F 1 "+3V3" V 2500 5600 50  0000 C CNN
F 2 "" H 2500 5350 50  0001 C CNN
F 3 "" H 2500 5350 50  0001 C CNN
	1    2500 5350
	0    1    1    0   
$EndComp
Text GLabel 2500 5250 2    50   Input ~ 0
P7
$Comp
L Connector:Conn_01x03_Male J9
U 1 1 60507F03
P 2300 6000
F 0 "J9" H 2142 6365 50  0000 L CNN
F 1 "Conn_01x03_Male" H 1908 6266 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 2300 6000 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 2300 6000 50  0001 C CNN
F 4 "C780061" H 2300 6000 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 2300 6000 50  0001 C CNN "lcsc_url"
F 6 "5" H 2300 6000 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 2300 6000 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 2300 6000 50  0001 C CNN "package"
	1    2300 6000
	1    0    0    -1  
$EndComp
Text Notes 2050 6100 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR030
U 1 1 60507F26
P 2500 5900
F 0 "#PWR030" H 2500 5650 50  0001 C CNN
F 1 "GND" V 2501 5681 50  0000 C CNN
F 2 "" H 2500 5900 50  0001 C CNN
F 3 "" H 2500 5900 50  0001 C CNN
	1    2500 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR031
U 1 1 60507F38
P 2500 6100
F 0 "#PWR031" H 2500 5950 50  0001 C CNN
F 1 "+3V3" V 2500 6350 50  0000 C CNN
F 2 "" H 2500 6100 50  0001 C CNN
F 3 "" H 2500 6100 50  0001 C CNN
	1    2500 6100
	0    1    1    0   
$EndComp
Text GLabel 2500 6000 2    50   Input ~ 0
P8
$Comp
L Connector:Conn_01x03_Male J6
U 1 1 60507F56
P 2250 6700
F 0 "J6" H 2092 7065 50  0000 L CNN
F 1 "Conn_01x03_Male" H 1858 6966 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 2250 6700 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 2250 6700 50  0001 C CNN
F 4 "C780061" H 2250 6700 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 2250 6700 50  0001 C CNN "lcsc_url"
F 6 "5" H 2250 6700 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 2250 6700 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 2250 6700 50  0001 C CNN "package"
	1    2250 6700
	1    0    0    -1  
$EndComp
Text Notes 2000 6800 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR023
U 1 1 60507F79
P 2450 6600
F 0 "#PWR023" H 2450 6350 50  0001 C CNN
F 1 "GND" V 2451 6381 50  0000 C CNN
F 2 "" H 2450 6600 50  0001 C CNN
F 3 "" H 2450 6600 50  0001 C CNN
	1    2450 6600
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR024
U 1 1 60507F8B
P 2450 6800
F 0 "#PWR024" H 2450 6650 50  0001 C CNN
F 1 "+3V3" V 2450 7050 50  0000 C CNN
F 2 "" H 2450 6800 50  0001 C CNN
F 3 "" H 2450 6800 50  0001 C CNN
	1    2450 6800
	0    1    1    0   
$EndComp
Text GLabel 2450 6700 2    50   Input ~ 0
P9
$Comp
L Connector:Conn_01x03_Male J7
U 1 1 60507FA9
P 2250 7450
F 0 "J7" H 2092 7815 50  0000 L CNN
F 1 "Conn_01x03_Male" H 1858 7716 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical_SMD_Pin1Left" H 2250 7450 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/2009091935_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.pdf" H 2250 7450 50  0001 C CNN
F 4 "C780061" H 2250 7450 50  0001 C CNN "lcsc_part_number"
F 5 "https://lcsc.com/product-detail/Pin-Header-Female-Header_XKB-Connectivity-X6511WVS-03H-C60D48-R1_C780061.html" H 2250 7450 50  0001 C CNN "lcsc_url"
F 6 "5" H 2250 7450 50  0001 C CNN "lcsc_min_qty"
F 7 "X6511WVS-03H-C60D48-R1" H 2250 7450 50  0001 C CNN "mfr_part_number"
F 8 "SMD,P=2.5mm" H 2250 7450 50  0001 C CNN "package"
	1    2250 7450
	1    0    0    -1  
$EndComp
Text Notes 2000 7550 0    50   ~ 0
GND\nPulse\n3v3
$Comp
L power:GND #PWR025
U 1 1 60507FCC
P 2450 7350
F 0 "#PWR025" H 2450 7100 50  0001 C CNN
F 1 "GND" V 2451 7131 50  0000 C CNN
F 2 "" H 2450 7350 50  0001 C CNN
F 3 "" H 2450 7350 50  0001 C CNN
	1    2450 7350
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V3 #PWR027
U 1 1 60507FDE
P 2450 7550
F 0 "#PWR027" H 2450 7400 50  0001 C CNN
F 1 "+3V3" V 2450 7800 50  0000 C CNN
F 2 "" H 2450 7550 50  0001 C CNN
F 3 "" H 2450 7550 50  0001 C CNN
	1    2450 7550
	0    1    1    0   
$EndComp
Text GLabel 2450 7450 2    50   Input ~ 0
P10
Text Notes 7750 2250 0    50   ~ 0
RTC_GPIO14
Text Notes 7750 3700 0    50   ~ 0
RTC_4
Text GLabel 7455 2506 2    50   Input ~ 0
P9
Text GLabel 7455 2606 2    50   Input ~ 0
P10
Text Notes 7750 3800 0    50   ~ 0
RTC_5
NoConn ~ 7455 3706
NoConn ~ 7455 3806
NoConn ~ 12160 3919
NoConn ~ 12831 2647
Text GLabel 7455 2706 2    50   Input ~ 0
SYS_OK_LED
$EndSCHEMATC
