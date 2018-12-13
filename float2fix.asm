float2fix:	
	ldi 0
	and r2, r1	;r2 = 0
	and r3, r1	;r3 = 0
	and r4, r1	;r4 = 0
	and r5, r1	;r5 = 0
	and r6, r1	;r6 = 0
	and r7, r1	;r7 = 0
	ldr r0, done
	
	
	
	
	
	
	str r1, r6 	;store branch addr for done in [0]
	ldi 0b100001
	add r2, r1	;r2 = 33
	lsl r2, 2	;r2 = 132
	ldi 1
	add r2, r1	;r2 = 133
	ldm r3, r2	;r3 = MSW = [133]
	add r2, r1	;r2 = 134
	ldm r4, r2	;r4 = LSW = [134]
	and r2, r5	;r2 = 0
	add r2, r3	;r2 = MSW
	lsl r2, 1
	lsr r2, 3	;r2 = MSW[6:2] = E
	ldi 0b100000
	lsl r1, 2	;r1 = 0b10000000
	add r5, r1	;r5 = 0b10000000
	and r5, r3	;r5 = 0b10000000 & MSW = signbit
	ldi 0b11
	and r3, r1	;clear top 6 bits of MSW
	ldi 0b100
	add r3, r1 	;prepdend H	PC = 27
	ldi 39
	bne r2, r7	;dont append H if E == 0
	ldi 0b11
	and r3, r1	;clear top 6 bits of MSW	PC = 38
regime1:	
	ldi 30	
	add r6, r1 	;r6 = 30
	add r7, r1	;r7 = 30
	and r6, r2	;r6 = 30 & E
	ldi 59		;regime 2
	bne r6, r7	;r6 is 30 if E is 30 or 31
	ldi 0
	and r3, r1
	and r4, r1
	and r6, r1
	ldi 0b111111
	add r4, r1
	lsl r4, 2
	ldi 0b11
	add r4, r1
	add r3, r4
	lsr r3, 1
	ldi 0
	ldm r1, r1
	bne r3, r4	;force branch (pseudo jump instr)
regime2:
	ldi 0		;PC = 59
	and r6, r1
	and r7, r1
	ldi 0b111100	;
	add r6, r1
	lsl r6, 2
	ldi 0b10
	add r6, r1
	add r6, r2 
	ldi 0b1100
	and r6, r1 
	add r7, r1
	ldr r0, regime3
	
	
	
	
	
	
	bne r6, r7	
loop:
	ldi 0
	and r6, r1
	and r7, r1
	lsl r3, 1
	ldi 0b100000
	lsl	 r1, 2	;r1 = 0b10000000
	add r6, r1	;r6 = 0b10000000
	add r7, r1	;r7 = 0b10000000
	and r6, r4	;r6 = 0b10000000 & LSW		
	ldr r0, shiftLSW ;ASSUMED r5 IS GARGABE VALUE
	
	
	
	
	
	bne r6, r7
	ldi 1
	add r3, r1
shiftLSW:
	lsl r6, 4	;clear r6
	lsl r7, 4	;clear r7
	lsl r4, 1
	ldi 0b111111
	lsl r1, 2
	add r2, r1
	ldi 0b11
	add r2, r1	;Decrement E
	ldi 25
	add r6, r1
	ldi 63
	add r7, r1
	ldi 16
	add r1, r7
	bne r2, r6	
regime3:
	ldi 0
	and r6, r1	;clear r6
	and r7, r1	;clear r7
	ldi 25
	add r6, r1
	ldr r0, regime4
	
	
	
	
	
	
	bne r2, r6
	ldi 0
	ldm r1, r1
	bne r6, r7
	
regime4:
	ldi 0
	and r6, r1
	and r7, r1
	ldi 2
	add r6, r1
	add r6, r2 	;E + 2
	lsr	r6, 4	;r6 == 1 if E > 13
	ldi 1
	add r7, r1
	ldr r0, regime5
	
	
	
	
	
	
	bne r6, r7
	lsr r6, 4	;clear r6
	lsr r7, 4	;clear r7
	ldi 3
	str r5, r1	;store [3] = r5 = signbit, need free regs
	lsl r1, 1
	str r2, r1	;store [6] = r2 = E.	r0,r2,r5,r6,r7 free
	ldi 0
	and r0, r1	
	and r2, r1	;R = 0
	and r5, r1	;S = 0
shiftright:
	ldi 0
	and r6, r1	;clear r6
	and r7, r1	;clear r7
	ldi 1
	add r7, r1	;r6 = 1
	add r6, r1	;r7 = 1
	and r1, r4	;old G = LSW & 1
	add r0, r1	;shift out in r0
	lsr r4, 1	;shift LSW right 1
	ldi 1		
	xor r5, r1
	xor r1, r2
	and r5, r1
	ldi 1
	xor r5, r1
	lsr r2, 4
	add r2, r0	;R = old G	
	and r6, r3	;MSW & 1 
	ldr r0, if8
	
	
	
	
	
	
	bne r6, r7 	;save right shift out from MSW
	ldi 0b100000
	lsl r1, 2	;r1 = 0b10000000
	add r4, r1	
if8:
	lsr r3, 1	;shift MSW right 1
	ldi 6		;[6] holds E
	ldm r7, r1	;r7 = E
	ldi 25
	lsr r6, 4	;clear r6
	add r6, r1	;r6 = 25
	ldi 1
	add r7, r1
	ldi 6
	str r7, r1
	ldr r0, shiftright
	
	
	
	
	
	
	bne r6, r7
	lsr r6, 4
	ldr r0, round
	
	
	
	
	
	
	bne r6, r7 		
regime5:
	ldi 0
	and r3, r1
	and r4, r1
	ldi 1
	add r6, r1
	ldi 0
	ldm r1, r1
	bne r3, r6
round:
	ldi 0
	and r6, r1
	and r7, r1
	ldi 1
	add r6, r1
	add r7, r1
	and r6, r4	;r6 = G
	and r6, r2 	;r6  = G & R
	and r7, r5	;r7 = S
	and r2, r5	;r2 = R & S
	xor r6, r1 	; ~r6
	xor r2, r1	; ~r7
	and r6, r2 	; (~r6 & ~r7)
	xor r6, r1	;	r6 | r7
	lsr r7, 4
	add r7, r1
	ldi 0
	ldm r1, r1
	bne r6, r7
	add r4, r6
	lsr r6, 4	;clear r6
	ldi 0
	ldm r1, r1	;load done label
	bne r6, r4
	ldi 1
	add r3, r1
done:
	ldi 0		;done
	and r7, r1
	ldi 3
	ldm r6, r1 ; r6 = sign bit
	add r6, r3 ; S + MSW
	ldi 17
	add r7, r1
	lsl r7, 3
	str r6, r7
	ldi 1
	add r7, r1
	str r4, r7
	
	
	