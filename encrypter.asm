encrypt:
ldi 62
ldm r4, lr // r4 = [62]  = lfsr_pattern
ldi 63
ldm r5, lr // r5 = [63] = lfsr_state = x
ldz r6 // r6 = curr_mem = 0
prepend_spaces:
	ldr r7, 0x20
	xor r7, r5 // r7 = space ^ x
	mov r0, r6
	addi r0, 64 // r0 = curr_mem + 64
	str r7, r0 // [r0] = space ^ x
	// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
	ldz r0 // r0 = parity = 0000 0000
	ldi 1 // lr = 0000 0001
	and lr, r4 // lr = lfsr & 0000 0001
	and lr, r5 // lr = lfsr & 0000 0001 & x
	xor r0, lr // r0 = parity ^ (lfsr & 0000 0001 & x)
	ldi 2 // lr = 0000 0010
	and lr, r5 // lr = 0000 0010 & x
	and lr, r4 // lr = 0000 0010 & x & lfsr
	lsr lr, 1 // lr = (0000 0010 & x & lfsr) >> 1
	xor r0, lr // r0 = parity ^ ((0000 0010 & x & lfsr) >> 1)
	ldi 4 // lr = 0000 0100
	and lr, r5 // lr = 0000 0100 & x
	and lr, r4 // lr = 0000 0100 & x & lfsr
	lsr lr, 2 // lr = (0000 0100 & x & lfsr) >> 2
	xor r0, lr // r0 = parity ^ ((0000 0100 & x & lfsr) >> 2)
ldi 8 // lr = 0000 100
	and lr, r5 // lr = 0000 1000 & x
	and lr, r4 // lr = 0000 1000 & x & lfsr
	lsr lr, 3 // lr = (0000 1000 & x & lfsr) >> 3
	xor r0, lr // r0 = parity ^ ((0000 1000 & x & lfsr) >> 3)
ldi 16 // lr = 0001 0000
	and lr, r5 // lr = 0001 0000 & x
	and lr, r4 // lr = 0001 0000 & x & lfsr
	lsr lr, 4 // lr = (0001 0000 & x & lfsr) >> 4
	xor r0, lr // r0 = parity ^ ((0000 0100 & x & lfsr) >> 4)
ldi 32 // lr = 0010 0000
	and lr, r5 // lr = 0010 0000 & x
	and lr, r4 // lr = 0010 0000 & x & lfsr
	lsr lr, 4 // lr = (0010 0000 & x & lfsr) >> 5
	lsr lr, 1
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
ldi 32 // lr = 0010 0000
lsl lr, 1 // lr = 0100 0000
	and lr, r5 // lr = 0100 0000 & x
	and lr, r4 // lr = 0100 0000 & x & lfsr
	lsr lr, 4 // lr = (0100 0000 & x & lfsr) >> 6
	lsr lr, 2
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
ldi 32 // lr = 0010 0000
lsl lr, 2 // lr = 1000 0000
	and lr, r5 // lr = 1000 0000 & x
	and lr, r4 // lr = 1000 0000 & x & lfsr
	lsr lr, 4 // lr = (1000 0000 & x & lfsr) >> 7
	lsr lr, 3
	xor r0, lr // r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
	// r0 = getLSB(lfsr=r4, state=r5)
	lsl r5, 1 // r5 = x << 1
	add r5, r0 // r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
	addi r6, 1 // curr_mem = curr_mem + 1
	ldr r3, 61
	ldm r3, r3 // r3 = [61] = num_spaces
	ldr r2, prepend_spaces // lr = prepend_spaces
	bne r6, r3 // while(curr_mem < num_spaces) prepend_spaces
	ldz r6 // r6 = curr_mem = 0(start reading from 0)
encrypt_char:
	ldm r7, r6 // r7 = [curr_mem] = char
	xor r7, r5 // r7 = char ^ x
	mov r2, r6 // r2 = curr_mem
	add r2, r3 // r2 = curr_mem + num_spaces
	addi r2, 64 // r2 = curr_mem num_spaces + 64
	str r7, r2 // [curr_mem + num_spaces + 64] = char ^ x
// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
	ldz r0 // r0 = parity = 0000 0000
	ldi 1 // lr = 0000 0001
	and lr, r4 // lr = lfsr & 0000 0001
	and lr, r5 // lr = lfsr & 0000 0001 & x
	xor r0, lr // r0 = parity ^ (lfsr & 0000 0001 & x)
	ldi 2 // lr = 0000 0010
	and lr, r5 // lr = 0000 0010 & x
	and lr, r4 // lr = 0000 0010 & x & lfsr
	lsr lr, 1 // lr = (0000 0010 & x & lfsr) >> 1
	xor r0, lr // r0 = parity ^ ((0000 0010 & x & lfsr) >> 1)
	ldi 4 // lr = 0000 0100
	and lr, r5 // lr = 0000 0100 & x
	and lr, r4 // lr = 0000 0100 & x & lfsr
	lsr lr, 2 // lr = (0000 0100 & x & lfsr) >> 2
	xor r0, lr // r0 = parity ^ ((0000 0100 & x & lfsr) >> 2)
ldi 8 // lr = 0000 100
	and lr, r5 // lr = 0000 1000 & x
	and lr, r4 // lr = 0000 1000 & x & lfsr
	lsr lr, 3 // lr = (0000 1000 & x & lfsr) >> 3
	xor r0, lr // r0 = parity ^ ((0000 1000 & x & lfsr) >> 3)
ldi 16 // lr = 0001 0000
	and lr, r5 // lr = 0001 0000 & x
	and lr, r4 // lr = 0001 0000 & x & lfsr
	lsr lr, 4 // lr = (0001 0000 & x & lfsr) >> 4
	xor r0, lr // r0 = parity ^ ((0000 0100 & x & lfsr) >> 4)
ldi 32 // lr = 0010 0000
	and lr, r5 // lr = 0010 0000 & x
	and lr, r4 // lr = 0010 0000 & x & lfsr
	lsr lr, 4 // lr = (0010 0000 & x & lfsr) >> 5
	lsr lr, 1
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
ldi 32 // lr = 0010 0000
lsl lr, 1 // lr = 0100 0000
	and lr, r5 // lr = 0100 0000 & x
	and lr, r4 // lr = 0100 0000 & x & lfsr
	lsr lr, 4 // lr = (0100 0000 & x & lfsr) >> 6
	lsr lr, 2
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
ldi 32 // lr = 0010 0000
lsl lr, 2 // lr = 1000 0000
	and lr, r5 // lr = 1000 0000 & x
	and lr, r4 // lr = 1000 0000 & x & lfsr
	lsr lr, 4 // lr = (1000 0000 & x & lfsr) >> 7
	lsr lr, 3
	xor r0, lr // r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
	// r0 = getLSB(lfsr=r4, state=r5)
	lsl r5, 1 // r5 = x << 1
	add r5, r0 // r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
	addi r6, 1 // curr_mem = curr_mem + 1
	ldr r7, 64 // r7 = 64
	ldr r2, encrypt_char // lr = encrypt_char
	bne r6, r7 // while(curr_mem < 40) encrypt_char
	bne r7, r7 // halt