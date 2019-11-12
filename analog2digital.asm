ale equ	P3.4
oe equ P3.7
start equ P3.5
eoc equ P3.6
sel_a equ P3.1
sel_b equ P3.2
sel_c equ P3.3
adc_data equ P1

org 0H

;Data port to input
mov adc_data, #0FFH

;EOC as Input
setb eoc
;rest of output signals
clr ale
clr oe
clr start
 
main_loop:
	;Select Analog Channel 1
	setb sel_a
	clr sel_b
	clr sel_c
 
	;Latch channel select
	setb ale
 
	;Start conversion
	setb start
 
	clr ale
	clr start
 
	;Wait for end of conversion
	jb eoc, $ ; $ means jump to same location
	jnb eoc, $
 
	;Assert read signal
	setb oe
 
	; Read Data
	mov A, adc_data
 
	clr oe
 
	;ADC data is now in accumulator
	;Start over for next conversion

	sjmp main_loop 
end