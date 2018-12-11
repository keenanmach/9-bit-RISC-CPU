ldr r3, 54 // r3 = idx = 54
// loop to check each lfsr pattern
find_lfsr:
	addi r3, 1 // idx = idx + 1 (starts at 55), check next lfsr state
	ldr r6, 64 // r6 = encrypted_char = 64
	ldm r4, r3 // r4 = [idx] = lfsr
	ldm r5, r6 // r5 = [encrypted_char] = state
	ldi 0x20 // lr = space
	xor r5, lr // r5 = state ^ space
	addi r6, 1 // r6 = encrypted_char + 1
// loop to check the state nine times
check_spaces:
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
	ldm r7, r6 // r7 = [encrypted_char] = mem_state
	ldi 0x20 // lr = space
	xor r7, lr // r7 = mem_state ^ space
	ldr r2, find_lfsr
	bne r5, r7 // if states are not the same check next lfsr state
	// else continue
	addi r6, 1 // r6 = encrypted_char + 1
	ldr r0, 73 // r0 = 73
	ldr r2, check_spaces
	bne r6, r0 // while(encrypted_char < 73) check_spaces
	// if reach here state found, r5=state, r4=lfsr
	ldz r3 // idx = 0
decrypt_rest:
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
	ldm r7, r6 // r7 = [encrypted_char]
	xor r7, r5 // r7 = [encrypted_char] ^ state
str r7, r3 // [idx] = [encrypted_char] ^ state = decrypted_char
	addi r3, 1 // idx = idx + 1
	addi r6, 1 // encrypted_char = encrypted_char + 1
	ldr r7, 128
	ldr r2, decrypt_rest
	bne r7, r6 // while(encrypted_char < 128) decrypt_rest
	// non_space init
	ldz r3 // r3 = idx = 0
non_space:
ldm r4, r3 // r4 = [idx] = char
ldr r5, 0x20 // r5 = space
ldr r2, shift
bne r4, r5 // if char != space go to shift
addi r3, 1 // else idx = idx + 1
ldr r5, 55
ldr r2, non_space
bne r3, r5 // while(idx < 55) non_space
// r3 = index of first non space character
shift:
	ldz r4 // r4 = idx = 0
	ldr r7, 63  // r7 = 0011 1111
	lsl r7, 2 // r7 = 1111 1100
	addi r7, 3 // r7 = 1111 1111
	xor r7, r3 // r7 = -offset
	addi r7, 1
ldr r6, 55 // r7 = 55 - offset
add r7, r6
// r3 = offset, r4 = idx, r7 = 55 - offset
shift_loop:
	mov r5, r3 // r5 = offset
	add r5, r4 // r5 = idx + offset
	ldm r2, r5 // r2 = [idx+offset] = char
	str r2, r4 // [idx] = [idx+offset]
	addi r4, 1 //idx = idx + 1
	ldr r2, shift_loop
	bne r4, r7 // while(idx < 55 - offset) shift_loop
//pad_spaces:
//	ldr r5, 0x20 // r5 = space
//	str r5, r4 // [idx] = space
//	addi r4, 1
//	ldr r6, 55 // r6 = 55
//	ldr r2, pad_spaces
//	bne r4, r6 // while(idx < 55) pad_spaces
bne r7, r7 // halt