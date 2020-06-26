# pwm_diode_assembler
A tiny script making diode gradually increase and decrease its brightness using PWM.

Author: Yaroslava Tkachuk, BSc student of the University of Silesia, Katowice, Poland.

Files:
- diode_pwm.asm - main program file
- m328pdef.inc - standard include file for ATmega328p

This program helps to control the brightness of a diode:
- pressing button 1 increases brightness by 10%
- pressing button 2 decreases brightness by 10%

At the beginning of the program an interrupt vector is skipped (rjump). PB1 and PB2 (button 1 and button 2 respectively) ports are configured as inputs and their values are set as 1. PB0 port (the diode) is set as ouput (is controlled by PWM).

Next Timer0 PWM mode is cofigured to work in a fast mode. PB0 port (OC0A) is controlled by PWM.

![Alt text]( yaroslava-tkachuk/pwm_diode_assembler/pwm_fast_mode.png?raw=true "Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf")

