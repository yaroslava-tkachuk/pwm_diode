# pwm_diode_assembly
A tiny assembly script making diode gradually increase and decrease its brightness using PWM.

Author: Yaroslava Tkachuk, BSc student of the University of Silesia, Katowice, Poland.

Files:
- diode_pwm.asm - main program file
- m328pdef.inc - standard include file for ATmega328p

This program helps to control the brightness of a diode:
- pressing button 1 increases brightness by 10%
- pressing button 2 decreases brightness by 10%

At the beginning of the program an interrupt vector is skipped (rjump). PB1 and PB2 (button 1 and button 2 respectively) ports are configured as inputs and their values are set as 1. PB0 port (the diode) is set as output (it is controlled by PWM).

Next, Timer0 PWM is configured to work in a fast mode. PB0 port (OC0A) is controlled by PWM.

![Alt text](./pwm_fast_mode.png?raw=true "Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf")
[Source 1]

Timer0 prescaler value is set for 1024.

![Alt text](./timer.png?raw=true "Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf")
[Source 1]

Then the timer is configured. Initially, the diode brightness is set as 100% - OCR0A register is set as 256.

In the main loop of the program PB1 and PB2 ports state is checked.
In case of PINB1:
- if the value is 0, the diode brightness is increased by approximately 10%: 26 is added to OCR01 register;
- if the value is 1, the diode brightness remains unchanged.
When the carry is 1 (value > 256), OCR01 is set as 256 (100% of brightness).
In case of PINB2:
- if the value is 0, the diode brightness is decreased by approximately 10%: 26 is subtracted from OCR01 register;
- if the value is 1, the diode brightness is not changed.
When register value is negative, OCR01 is set as 0 (0% of brightness).

This program has been tested using a homemade Arduino-like board with ATmega8 processor (ATmega328p can be used with the same success).

Here You can observe the beautiful blue shining controlled by PWM:
<br>https://youtu.be/nNTRR_2zkTk

Enjoy!

P.S. The program has been slightly modified for the filming purposes: diode shining is changed gradually in a loop, so that there is no need to use buttons.

Sources:
1. Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf
