// store the eight lfsr patterns into  memory positions 55-62
store_lsfr:
ldr r3, 55 // r3 = mem = 55
ldr r4, 44 // r4 = 0010 1100
lsl r4, 2 // r4 = 1011 0000 = 176
addi r4, 2 // r4 = 1011 0010 = 178 = 0xb2
str r4, r3 // [55] = 0xb2
addi r4, 2 // r4 = 1011 0100 = 180 = 0xb4 (could optimize with lr)
addi r3, 1 // r3 = 56
str r4, r3 // [56] = 0xb4
addi r4, 4 // r4 = 1011 1000 = 184 = 0xb8
addi r3, 1 // r3 = 57
str r4, r3 // [57] = 0xb8
addi r4, 14 // r4 = 1100 0110 = 198 = 0xc6
addi r3, 1 // r3 = 58
str r4, r3 // [58] = 0xc6
addi r4, 14 // r4 = 1101 0100 = 212 = 0xd4 (could optimize with lr)
addi r3, 1 // r3 = 59
str r4, r3 // [59] = 0xd4
addi r4, 13 // r4 = 1110 0001 = 225 = 0xe1
addi r3, 1 // r3 = 60
str r4, r3 // [60] = 0xe1
addi r4, 18 // r4 = 1111 0011 = 243 = 0xf3
addi r3, 1 // r3 = 61
str r4, r3 // [60] = 0xf3
addi r4, 7 // r4 = 1111 1010 ==250 = 0xfa
addi r3, 1 // r3 = 62
str r4, r3 // [62] = 0xfa
// done storing lfsr patterns into memory
// now find the lfsr pattern
ldr r3, 55 // r3 = idx = 54
// loop to check each lfsr pattern
find_lfsr:
	addi r3, 1 // idx = idx + 1 (starts at 55), check next lfsr state
	ldr r6, 64 // r6 = encrypted_char = 64
	ldm r4, r3 // r4 = [idx] = lfsr
	ldm r5, r6 // r5 = [encrypted_char] = state
	ldi 0x20 // lr = space
	xor r5, lr // r5 = state ^ space
	addi r6, 1 // r6 = encrypted_char + 1
// loop to check the state eight times
check_spaces:
	// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
	ldr r0, 1 // r0 = parity = 0000 0001
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
	lsr lr, 5 // lr = (0010 0000 & x & lfsr) >> 5
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
ldi 32 // lr = 0010 0000
lsl lr, 1 // lr = 0100 0000
	and lr, r5 // lr = 0100 0000 & x
	and lr, r4 // lr = 0100 0000 & x & lfsr
	lsr lr, 5 // lr = (0100 0000 & x & lfsr) >> 6
	lsr lr, 1
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
ldi 32 // lr = 0010 0000
lsl lr, 2 // lr = 1000 0000
	and lr, r5 // lr = 1000 0000 & x
	and lr, r4 // lr = 1000 0000 & x & lfsr
	lsr lr, 5 // lr = (1000 0000 & x & lfsr) >> 7
	lsr lr, 2
	xor r0, lr // r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
	// r0 = getLSB(lfsr=r4, state=r5)
	lsl r5, 1 // r5 = x << 1
	add r5, r0 // r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
	ldm r7, r6 // r7 = [encrypted_char] = mem_state
	ldi 0x20 // lr = space
	xor r7, lr // r7 = mem_state ^ space
	ldi 1 // lr = 0000 0001
	mov r0, r5 // r0 = state
	and r0, lr // r0 = state lsb
	and r7, lr // r7 = mem_state lsb
	ldr r2, find_lfsr
	bne r0, r7 // if lsbs are not the same check next lfsr state
	// else continue
	addi r6, 1 // r6 = encrypted_char + 1
	ldr r0, 73 // r0 = 73
	ldr r2, check_spaces
	bne r6, r0 // while(encrypted_char < 73) check_spaces
	// if reach here state found, r5=state, r4=lfsr
	ldz r3 // idx = 0
decrypt_rest:
	// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
	ldr r0, 1 // r0 = parity = 0000 0001
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
	lsr lr, 5 // lr = (0010 0000 & x & lfsr) >> 5
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
ldi 32 // lr = 0010 0000
lsl lr, 1 // lr = 0100 0000
	and lr, r5 // lr = 0100 0000 & x
	and lr, r4 // lr = 0100 0000 & x & lfsr
	lsr lr, 5 // lr = (0100 0000 & x & lfsr) >> 6
	lsr lr, 1
	xor r0, lr // r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
ldi 32 // lr = 0010 0000
lsl lr, 2 // lr = 1000 0000
	and lr, r5 // lr = 1000 0000 & x
	and lr, r4 // lr = 1000 0000 & x & lfsr
	lsr lr, 5 // lr = (1000 0000 & x & lfsr) >> 7
	lsr lr, 2
	xor r0, lr // r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
	// r0 = getLSB(lfsr=r4, state=r5)
	lsl r5, 1 // r5 = x << 1
	add r5, r0 // r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
	ldm r7, r6 // r7 = [encrypted_char]
	xor r7, r5 // r7 = [encrypted_char] ^ state
	str r7, r3 // [idx] = [encrypted_char] ^ state = decrypted_char
	addi r3, 1 // idx = idx + 1
	addi r6, 1 // encrypted_char = encrypted_char + 1
	ldr r7, 128
	ldr r2, decrypt_rest
	bne r7, r6 // while(encrypted_char < 128) decrypt_rest
	bne r7, r7 // halt