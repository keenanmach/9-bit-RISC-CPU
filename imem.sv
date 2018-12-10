// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem(
  input       [7:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
always @* begin
  $display("%d",PC);
end
always_comb case(PC)
0: inst = 9'b100_111110; //ldi 62
1: inst = 9'b101_100_001; //ldm r4, lr  r4 = [62]  = lfsr_pattern
2: inst = 9'b100_111111; //ldi 63
3: inst = 9'b101_101_001; //ldm r5, lr  r5 = [63] = lfsr_state = x
4: inst = 9'b100_000000; //ldz r6  r6 = curr_mem = 0
5: inst = 9'b000_110_001;
6: inst = 9'b100_000000; //ldr r7, 0x20
7: inst = 9'b000_111_001;
8: inst = 9'b100_100000;
9: inst = 9'b001_111_001;
10: inst = 9'b010_111_100; //xor r7, r4  r7 = space ^ x
11: inst = 9'b100_000000; //mov r0, r6
12: inst = 9'b000_000_001;
13: inst = 9'b001_000_110;
14: inst = 9'b100_111111; //addi r0, 64  r0 = curr_mem + 64
15: inst = 9'b001_000_001;
16: inst = 9'b001_000_001;
17: inst = 9'b100_000001;
18: inst = 9'b001_000_001;
19: inst = 9'b110_111_000; //str r7, r0  [r0] = space ^ x
// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
20: inst = 9'b100_000000; //ldr r0, 1  r0 = parity = 0000 0001
21: inst = 9'b000_000_001;
22: inst = 9'b100_000001;
23: inst = 9'b001_000_001;
24: inst = 9'b100_000001; //ldi 1  lr = 0000 0001
25: inst = 9'b000_001_100; //and lr, r4  lr = lfsr & 0000 0001
26: inst = 9'b000_001_101; //and lr, r5  lr = lfsr & 0000 0001 & x
27: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ (lfsr & 0000 0001 & x)
28: inst = 9'b100_000010; //ldi 2  lr = 0000 0010
29: inst = 9'b000_001_101; //and lr, r5  lr = 0000 0010 & x
30: inst = 9'b000_001_100; //and lr, r4  lr = 0000 0010 & x & lfsr
31: inst = 9'b0111_001_00; //lsr lr, 1  lr = (0000 0010 & x & lfsr) >> 1
32: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0010 & x & lfsr) >> 1)
33: inst = 9'b100_000100; //ldi 4  lr = 0000 0100
34: inst = 9'b000_001_101; //and lr, r5  lr = 0000 0100 & x
35: inst = 9'b000_001_100; //and lr, r4  lr = 0000 0100 & x & lfsr
36: inst = 9'b0111_001_01; //lsr lr, 2  lr = (0000 0100 & x & lfsr) >> 2
37: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0100 & x & lfsr) >> 2)
38: inst = 9'b100_001000; //ldi 8  lr = 0000 100
39: inst = 9'b000_001_101; //and lr, r5  lr = 0000 1000 & x
40: inst = 9'b000_001_100; //and lr, r4  lr = 0000 1000 & x & lfsr
41: inst = 9'b0111_001_10; //lsr lr, 3  lr = (0000 1000 & x & lfsr) >> 3
42: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 1000 & x & lfsr) >> 3)
43: inst = 9'b100_010000; //ldi 16  lr = 0001 0000
44: inst = 9'b000_001_101; //and lr, r5  lr = 0001 0000 & x
45: inst = 9'b000_001_100; //and lr, r4  lr = 0001 0000 & x & lfsr
46: inst = 9'b0111_001_11; //lsr lr, 4  lr = (0001 0000 & x & lfsr) >> 4
47: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0100 & x & lfsr) >> 4)
48: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
49: inst = 9'b000_001_101; //and lr, r5  lr = 0010 0000 & x
50: inst = 9'b000_001_100; //and lr, r4  lr = 0010 0000 & x & lfsr
51: inst = 9'b0111_001_100; //lsr lr, 5  lr = (0010 0000 & x & lfsr) >> 5
52: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
53: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
54: inst = 9'b0110_001_00; //lsl lr, 1  lr = 0100 0000
55: inst = 9'b000_001_101; //and lr, r5  lr = 0100 0000 & x
56: inst = 9'b000_001_100; //and lr, r4  lr = 0100 0000 & x & lfsr
57: inst = 9'b0111_001_100; //lsr lr, 5  lr = (0100 0000 & x & lfsr) >> 6
58: inst = 9'b0111_001_00; //lsr lr, 1
59: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
60: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
61: inst = 9'b0110_001_01; //lsl lr, 2  lr = 1000 0000
62: inst = 9'b000_001_101; //and lr, r5  lr = 1000 0000 & x
63: inst = 9'b000_001_100; //and lr, r4  lr = 1000 0000 & x & lfsr
64: inst = 9'b0111_001_100; //lsr lr, 5  lr = (1000 0000 & x & lfsr) >> 7
65: inst = 9'b0111_001_01; //lsr lr, 2
66: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
// r0 = getLSB(lfsr=r4, state=r5)
67: inst = 9'b0110_101_00; //lsl r5, 1  r5 = x << 1
68: inst = 9'b001_101_000; //add r5, r0  r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
69: inst = 9'b100_000001; //addi r6, 1  curr_mem = curr_mem + 1
70: inst = 9'b001_110_001;
71: inst = 9'b100_000000; //ldr r3, 61
72: inst = 9'b000_011_001;
73: inst = 9'b100_111101;
74: inst = 9'b001_011_001;
75: inst = 9'b101_011_011; //ldm r3, r3  r3 = [61] = num_spaces
76: inst = 9'b100_000000; //ldr r2, prepend_spaces  lr = prepend_spaces
77: inst = 9'b000_010_001;
78: inst = 9'b100_000001;
79: inst = 9'b001_010_001;
80: inst = 9'b0110_010_01;
81: inst = 9'b100_000010;
82: inst = 9'b001_001_010;
83: inst = 9'b111_110_011; //bne r6, r3  while(curr_mem < num_spaces) prepend_spaces
84: inst = 9'b101_111_110; //ldm r7, r6  r7 = [curr_mem] = char
85: inst = 9'b010_111_101; //xor r7, r5  r7 = char ^ x
86: inst = 9'b100_000000; //mov r2, r6  r2 = curr_mem
87: inst = 9'b000_010_001;
88: inst = 9'b001_010_110;
89: inst = 9'b100_111111; //addi r2, 64  r2 = curr_mem + 64
90: inst = 9'b001_010_001;
91: inst = 9'b001_010_001;
92: inst = 9'b100_000001;
93: inst = 9'b001_010_001;
94: inst = 9'b110_111_010; //str r7, r2  [curr_mem + 64] = char ^ x
// getLSB - stores in r0, lr, assumes r4 = lfsr, r5 = state
95: inst = 9'b100_000000; //ldr r0, 1  r0 = parity = 0000 0001
96: inst = 9'b000_000_001;
97: inst = 9'b100_000001;
98: inst = 9'b001_000_001;
99: inst = 9'b100_000001; //ldi 1  lr = 0000 0001
100: inst = 9'b000_001_100; //and lr, r4  lr = lfsr & 0000 0001
101: inst = 9'b000_001_101; //and lr, r5  lr = lfsr & 0000 0001 & x
102: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ (lfsr & 0000 0001 & x)
103: inst = 9'b100_000010; //ldi 2  lr = 0000 0010
104: inst = 9'b000_001_101; //and lr, r5  lr = 0000 0010 & x
105: inst = 9'b000_001_100; //and lr, r4  lr = 0000 0010 & x & lfsr
106: inst = 9'b0111_001_00; //lsr lr, 1  lr = (0000 0010 & x & lfsr) >> 1
107: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0010 & x & lfsr) >> 1)
108: inst = 9'b100_000100; //ldi 4  lr = 0000 0100
109: inst = 9'b000_001_101; //and lr, r5  lr = 0000 0100 & x
110: inst = 9'b000_001_100; //and lr, r4  lr = 0000 0100 & x & lfsr
111: inst = 9'b0111_001_01; //lsr lr, 2  lr = (0000 0100 & x & lfsr) >> 2
112: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0100 & x & lfsr) >> 2)
113: inst = 9'b100_001000; //ldi 8  lr = 0000 100
114: inst = 9'b000_001_101; //and lr, r5  lr = 0000 1000 & x
115: inst = 9'b000_001_100; //and lr, r4  lr = 0000 1000 & x & lfsr
116: inst = 9'b0111_001_10; //lsr lr, 3  lr = (0000 1000 & x & lfsr) >> 3
117: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 1000 & x & lfsr) >> 3)
118: inst = 9'b100_010000; //ldi 16  lr = 0001 0000
119: inst = 9'b000_001_101; //and lr, r5  lr = 0001 0000 & x
120: inst = 9'b000_001_100; //and lr, r4  lr = 0001 0000 & x & lfsr
121: inst = 9'b0111_001_11; //lsr lr, 4  lr = (0001 0000 & x & lfsr) >> 4
122: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0000 0100 & x & lfsr) >> 4)
123: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
124: inst = 9'b000_001_101; //and lr, r5  lr = 0010 0000 & x
125: inst = 9'b000_001_100; //and lr, r4  lr = 0010 0000 & x & lfsr
126: inst = 9'b0111_001_100; //lsr lr, 5  lr = (0010 0000 & x & lfsr) >> 5
127: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0010 0000 x & lfsr) >> 5)
128: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
129: inst = 9'b0110_001_00; //lsl lr, 1  lr = 0100 0000
130: inst = 9'b000_001_101; //and lr, r5  lr = 0100 0000 & x
131: inst = 9'b000_001_100; //and lr, r4  lr = 0100 0000 & x & lfsr
132: inst = 9'b0111_001_100; //lsr lr, 5  lr = (0100 0000 & x & lfsr) >> 6
133: inst = 9'b0111_001_00; //lsr lr, 1
134: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((0010 0000 x & lfsr) >> 6)
135: inst = 9'b100_100000; //ldi 32  lr = 0010 0000
136: inst = 9'b0110_001_01; //lsl lr, 2  lr = 1000 0000
137: inst = 9'b000_001_101; //and lr, r5  lr = 1000 0000 & x
138: inst = 9'b000_001_100; //and lr, r4  lr = 1000 0000 & x & lfsr
139: inst = 9'b0111_001_100; //lsr lr, 5  lr = (1000 0000 & x & lfsr) >> 7
140: inst = 9'b0111_001_01; //lsr lr, 2
141: inst = 9'b010_000_001; //xor r0, lr  r0 = parity ^ ((1000 0000 x & lfsr) >> 7)
// r0 = getLSB(lfsr=r4, state=r5)
142: inst = 9'b0110_101_00; //lsl r5, 1  r5 = x << 1
143: inst = 9'b001_101_000; //add r5, r0  r5 = (x << 1) + getLSB(lfsr=r4, state=r5)
144: inst = 9'b100_000001; //addi r6, 1  curr_mem = curr_mem + 1
145: inst = 9'b001_110_001;
146: inst = 9'b100_000000; //ldr r7, 64  r7 = 64
147: inst = 9'b000_111_001;
148: inst = 9'b100_111111;
149: inst = 9'b001_111_001;
150: inst = 9'b001_111_001;
151: inst = 9'b100_000001;
152: inst = 9'b001_111_001;
153: inst = 9'b100_000000; //ldr r2, encrypt_char  lr = encrypt_char
154: inst = 9'b000_010_001;
155: inst = 9'b100_010101;
156: inst = 9'b001_010_001;
157: inst = 9'b0110_010_01;
158: inst = 9'b100_000010;
159: inst = 9'b001_001_010;
160: inst = 9'b111_110_111; //bne r6, r7  while(curr_mem < 64) encrypt_char
161: inst = 9'b111_111_111; //bne r7, r7  halt
default: inst = 'b111_111_111; // covers all cases not included in the above list
  endcase
endmodule