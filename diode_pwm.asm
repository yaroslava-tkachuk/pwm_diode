.include "m328pdef.inc"

.org 0 // Program start after reset
rjmp start

.org 0x28
start: // Program start
	// Configuring PB1 and PB2 as inputs
	cbi DDRB, 1
	cbi DDRB, 2

	// Setting PORTB1 and PORT2 values as 1
	sbi PORTB, 1
	sbi PORTB, 2

	sbi DDRB, 0 // Configuring OC0A (PB0) as PWM output
	
	// Timer0 in Fast PWM mode, OC0A in low state at the beginning of the cycle
	// Configuring timer and port to work with PWM
	ldi r16, 0b11000011 // 1=COM0A1, 1=COM0A0 - configuring OC0A as "compare match", 1=WGM01, 1=WGM00 - configuring OC0B as "compare match"
	out TCCR0A, r16 //Port OC0A is controlled by PWM  
	
	// Timer0 prescaler = 1024 (frequency / 1024)
	ldi r16, 0b00000101 // 1 = CS02, 1 = CS00 Prescaler = 1024
	out TCCR0B, r16 // Configuring Timer0 prescaler

	
	// Configurign Timer0 PWM
	ldi r16, 256 // 100% of brightness
	timer_config:
		out OCR0A, r16 // Stores r16 into OCR0A - Timer0 will compare its value with OCR0A

label:
	dont_decr:
		// If PINB1 is set as 0, brightness is increased by 10%
		sbic PINB, 1
		rjmp dont_incr
		in r16, OCR0A
		ldi r17, 26
		add r16, r17

		// If after operation carry is set as 0, 0CR0A is not set as 256
		brcc dont_set_256
		ldi r16, 256

		dont_set_256:
			rjmp timer_config
	
	dont_incr:
		// If PINB2 is set as 0, brightness is decreased by 10%
		sbic PINB, 2
		rjmp dont_decr
		in r16, OCR0A
		subi r16, 26

		// If output is negative, 0CR0A is reset
		brpl dont_load_zero
		ldi r16, 0

		dont_load_zero:
			rjmp timer_config

	rjmp label


