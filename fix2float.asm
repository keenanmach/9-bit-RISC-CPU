fix2float:
	ldi 0
	and r3, r2	;r3 = 0
	ldi 63
	add r3, r2	;r3 = 63
	add r3, r2	;r3 = 126
	ldi 2
	add r3, r2	;r3 = 128
	ldm r0, r3	;r0 = MSW
	ldi 1
	add r2, r3	;r3 = 129
	ldm r1, r3	;r1 = LSW
	ldi 0
	and r3, r2	;r3 = 0
	ldi 29
	add r3, r2	;r3 = 29
	ldi 0
	and r4, r2	;r4 = 0
	ldi 0b100000
	lsl r2, 2	;r2 = 0b10000000
	add r4, r2	;r4 = 0b100000
	and r4, r0	;r4 = 0b100000 & MSW = signbit
	ldi 0
	and r5, r2	;r5 = 0
	ldi 0b100000
	lsl r2, 1	;r2 = 0b1000000
	add r5, r2	;r5 = 0b1000000 = mask
loop:
	ldi 0
	and r6, r2	;r6 = 0
	add r6, r0	;r6 = MSW
	and r6, r5	;r6 = mask & MSW
	ldi 0
	and r7, r2	;r7 = 0
	ldi if3
	bne	r6, r7
	lsl r0, 1
	ldi 0
	and r6, r2	;r6 = 0
	ldi 0b100000
	lsl r2, 2	;r2 = 0b10000000
	add r6, r2	;r5 = 0b10000000
	and r6, r1	;r6 = 0b10000000 & LSW
	ldi 0
	and r7, r2	;r7 = 0
	ldi 0b100000
	lsl r2, 2
	add r7, r2
	ldi if2
	bne r6, r7
	ldi 1
	add r0, r2
if2:
	lsl r1, 1
if3:	
	ldi 0
	and r6, r2	;r6 = 0
	add r6, r0	;r6 = MSW
	and r6, r5	;r6 = mask & MSW
	ldi loop	;loop again if mask & MSW != 0
	bne r6, r5	;r6 = mask & MSW & mask
	
	
	