encrypt:
ldi 62
ldm r4, lr // r4 = [62]  = lfsr
ldi 63
ldm r5, lr // r5 = [63] = lfsr_state = x
ldz r6 // r6 = curr_mem = 0
prepend_spaces:
ldr r7, 0x20
xor r7, r4 // r7 = space ^ x
mov r0, r6
addi r0, 64 // r0 = curr_mem + 64
str r7, r0 // [r0] = space ^ x
// getLSB stores in r0, r7, lr assumes r4 = lfsr, r5 = state
ldr r0, 1
lsl r0, 5
lsl r0, 2 // r0 = parity = 1000 0000
mov r7, r4
and r7, r0 // r7 = lfsr & 1000 0000
and r7, r5 // r7 = lfsr & 1000 0000 & x
xor r0, r7 // r0 = r0 ^ r7
ldi 1
lsl lr, 5
lsl lr, 1 // lr = 0100 0000
and lr, r5 // lr = x & 0100 0000
and lr, r4 // lr = lfsr & 0100 0000 & x
lsl lr, 1 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 5 // lr = 0010 0000
and lr, r5 // lr = x & 0010 0000
and lr, r4 // lr = lfsr & 0010 0000 & x
lsl lr, 2 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 4 // lr = 0001 0000
and lr, r5 // lr = x & 0001 0000
and lr, r4 // lr = lfsr & 0001 0000 & x
lsl lr, 3 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 3
and lr, r5
and lr, r4
lsl lr, 4
xor r0, lr
ldi 1
lsl lr, 2
and lr, r5
and lr, r4
lsl lr, 5
xor r0, lr
ldif 1
lsl lr, 1
and lr, r5
and lr, r4
lsl lr, 5
lsl lr, 1
xor r0, lr
ld 1 // lr = 0000 0001
and lr, r5 // lr = x & 0000 0001
and lr, r4 // lr = x & 0000 0001 & lfsr
lsl lr, 5 // lr = _000 0000
lsl lr, 2
xor r0, lr // r0 = 0 if odd parity, 1 if even parity
ldr r2, even1 // r2 = even
ldi 0
lsl r5, 1 // r5 = x << 1
bne r0, lr // branch if even parity
addi r5, 1 // add one if odd parity
even1:
// end of getLSB
addi r6, 1 // curr_mem = curr_mem + 1
ldr r2, prepend_spaces
ldi 62
ldm lr, lr // lr = [62] = num_spaces
bne r6, lr // while(curr_mem < num_spaces)
// get LSB for rest of string (not spaces)
encrypt_char:
ldr r0, 1
lsl r0, 5
lsl r0, 2 // r0 = parity = 1000 0000
mov r7, r4
and r7, r0 // r7 = lfsr & 1000 0000
and r7, r5 // r7 = lfsr & 1000 0000 & x
xor r0, r7 // r0 = r0 ^ r7
ldi 1
lsl lr, 5
lsl lr, 1 // lr = 0100 0000
and lr, r5 // lr = x & 0100 0000
and lr, r4 // lr = lfsr & 0100 0000 & x
lsl lr, 1 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 5 // lr = 0010 0000
and lr, r5 // lr = x & 0010 0000
and lr, r4 // lr = lfsr & 0010 0000 & x
lsl lr, 2 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 4 // lr = 0001 0000
and lr, r5 // lr = x & 0001 0000
and lr, r4 // lr = lfsr & 0001 0000 & x
lsl lr, 3 // lr = _000 0000
xor r0, lr // r0 = parity ^ _000 0000
ldi 1
lsl lr, 3
and lr, r5
and lr, r4
lsl lr, 4
xor r0, lr
ldi 1
lsl lr, 2
and lr, r5
and lr, r4
lsl lr, 5
xor r0, lr
ldi 1
lsl lr, 1
and lr, r5
and lr, r4
lsl lr, 5
lsl lr, 1
xor r0, lr
ldi 1 // lr = 0000 0001
and lr, r5 // lr = x & 0000 0001
and lr, r4 // lr = x & 0000 0001 & lfsr
lsl lr, 5
lsl lr, 2 // lr = _000 0000
xor r0, lr // r0 = 0 if odd parity, 1 if even parity
ldr r2, even2 // r2 = even
ldi 0
lsl r5, 1 // r5 = x << 1
bne r0, lr // branch if even parity
addi r5, 1 // add one if odd parity
even2:
// end of getLSB for rest of string
addi r6, 1 // curr_mem = curr_mem + 1
ldr r2, encrypt_char
ldi 64
bne r6, lr // while(curr_mem < 64)
bne r7, r7 // halt