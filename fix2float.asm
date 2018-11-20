fix2float:
	ldi 0
	and r3, r1	;r3 = 0
	ldi 0b100000
	add r3, r1	;r3 = 32
	lsl r3, 2	;r3 = 128
	ldm r0, r3	;r0 = MSW
	ldi 1
	add r1, r3	;r3 = 129
	ldm r2, r3	;r2 = LSW
	ldi 0
	and r3, r1	;r3 = 0
	ldi 29
	add r3, r1	;r3 = 29
	ldi 0
	and r4, r1	;r4 = 0
	ldi 0b100000
	lsl r1, 2	;r1 = 0b10000000
	add r4, r1	;r4 = 0b10000000
	and r4, r0	;r4 = 0b10000000 & MSW = signbit
	ldi 0
	and r5, r1	;r5 = 0
	ldi 0b100000
	lsl r1, 1	;r1 = 0b1000000
	add r5, r1	;r5 = 0b1000000 = mask
loop:
	ldi 0
	and r6, r1	;r6 = 0
	add r6, r0	;r6 = MSW
	and r6, r5	;r6 = mask & MSW
	ldi 0
	and r7, r1	;r7 = 0
	ldi if3
	bne	r6, r7
	lsl r0, 1
	ldi 0
	and r6, r1	;r6 = 0
	ldi 0b100000
	lsl r1, 2	;r1 = 0b10000000
	add r6, r1	;r5 = 0b10000000
	and r6, r2	;r6 = 0b10000000 & LSW
	ldi 0
	and r7, r1	;r7 = 0
	ldi 0b100000
	lsl r1, 2
	add r7, r1
	ldi if2
	bne r6, r7
	ldi 1
	add r0, r1
if2:
	lsl r1, 1
if3:	
	ldi 0
	and r6, r1	;r6 = 0
	add r6, r0	;r6 = MSW
	and r6, r5	;r6 = mask & MSW
	ldi loop	;loop again if mask & MSW != 0
	bne r6, r5	;r6 = mask & MSW & mask
	ldi 0
	and r6, r1
	ldi 0b10000	
	add r6, r1	; r6 = 0b10000
	and r6, r2	; r6 = 0b10000 & LSW
	ldi 0
	and r7, r1
	ldi 0b1000	
	add r7, r1	; r7 = 0b1000
	and r7, r2	; r7 = 0b1000 & LSW
	add r6, r7	; r7 = (0b10000 & LSW) & (0b1000 & LSW)
	ldi 0
	and r7, r1
	ldi if5
	bne r6, r7
	ldi 0
	and r6, r1
	ldi 0b11111
	add r6, r1
	lsl r6, 3	;r6 = 0b11111000
	and r6, r2	;r6 = 0b11111000 & LSW
	ldi 0
	and r7, r1
	ldi 0b11111
	add r7, r1
	lsl r7, 3	;r7 = 0b11111000
	ldi if4
	bne r6, r7
	ldi 1
	add r0, r1
if4:
	ldi 8
	add r2, r1	
if5:
	ldi 0
	and r6, r1
	ldi 0b10000	
	add r6, r1	; r6 = 0b10000
	and r6, r2	; r6 = 0b10000 & LSW
	ldi 0
	and r7, r1
	ldi 0b10000	
	add r7, r1	; r6 = 0b10000
	xor r6, r7
	ldi 0
	and r7, r1
	ldi 0b1000	
	add r7, r1	; r7 = 0b1000
	and r7, r2	; r7 = 0b1000 & LSW
	add r6, r7
	ldi 0
	and r7, r1
	ldi 0b111	
	add r7, r1	; r7 = 0b111
	and r7, r2	; r7 = 0b111 & LSW
	add r6, r7
	ldi 0
	and r7, r1
	ldi if7
	bne r6, r7
	ldi 0
	and r6, r1
	ldi 0b11111
	add r6, r1
	lsl r6, 3	;r6 = 0b11111000
	and r6, r2	;r6 = 0b11111000 & LSW
	ldi 0
	and r7, r1
	ldi 0b11111
	add r7, r1
	lsl r7, 3	;r7 = 0b11111000
	ldi if6
	bne r6, r7
	ldi 1
	add r0, r1
if6:
	ldi 8
	add r2, r1	
if7:
	ldi 0b100000
	lsl r1, 2	;r1 = 0b10000000
	add r6, r1	;r6 = 0b10000000
	and r6, r0
	ldi 0
	and r7, r1
	ldi done
	bne r6, r7
	lsr r0, 1
	lsr r2, 1
done:
	bne r7, r7	;"halt" instruction

;TODO: Check all BNE for correct arguments. Branch conditions. Store to memory
	
	