// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem(
  input       [8:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
always_comb case(PC)
0: inst = 9'b100_000000; //ldi 0
1: inst = 9'b000_010_001; //and r2, r1	r2 = 0
2: inst = 9'b000_011_001; //and r3, r1	r3 = 0
3: inst = 9'b000_100_001; //and r4, r1	r4 = 0
4: inst = 9'b000_101_001; //and r5, r1	r5 = 0
5: inst = 9'b000_110_001; //and r6, r1	r6 = 0
6: inst = 9'b000_111_001; //and r7, r1	r7 = 0
7: inst = 9'b100_000000; //ldr r0, done
8: inst = 9'b000_000_001;
9: inst = 9'b100_111101;
10: inst = 9'b001_000_001;
11: inst = 9'b0110_000_01;
12: inst = 9'b100_000001;
13: inst = 9'b001_001_000;
14: inst = 9'b110_001_110; //str r1, r6 	store branch addr for done in [0]
15: inst = 9'b100_100001; //ldi 0b100001
16: inst = 9'b001_010_001; //add r2, r1	r2 = 33
17: inst = 9'b0110_010_01; //lsl r2, 2	r2 = 132
18: inst = 9'b100_000001; //ldi 1
19: inst = 9'b001_010_001; //add r2, r1	r2 = 133
20: inst = 9'b101_011_010; //ldm r3, r2	r3 = MSW = [133]
21: inst = 9'b001_010_001; //add r2, r1	r2 = 134
22: inst = 9'b101_100_010; //ldm r4, r2	r4 = LSW = [134]
23: inst = 9'b000_010_101; //and r2, r5	r2 = 0
24: inst = 9'b001_010_011; //add r2, r3	r2 = MSW
25: inst = 9'b0110_010_00; //lsl r2, 1
26: inst = 9'b0111_010_10; //lsr r2, 3	r2 = MSW[6:2] = E
27: inst = 9'b100_100000; //ldi 0b100000
28: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
29: inst = 9'b001_101_001; //add r5, r1	r5 = 0b10000000
30: inst = 9'b000_101_011; //and r5, r3	r5 = 0b10000000 & MSW = signbit
31: inst = 9'b100_000011; //ldi 0b11
32: inst = 9'b000_011_001; //and r3, r1	clear top 6 bits of MSW
33: inst = 9'b100_000100; //ldi 0b100
34: inst = 9'b001_011_001; //add r3, r1 	prepdend H	PC = 27
35: inst = 9'b100_100111; //ldi 39
36: inst = 9'b111_010_111; //bne r2, r7	dont append H if E == 0
37: inst = 9'b100_000011; //ldi 0b11
38: inst = 9'b000_011_001; //and r3, r1	clear top 6 bits of MSW	PC = 38
39: inst = 9'b100_011110; //ldi 30
40: inst = 9'b001_110_001; //add r6, r1 	r6 = 30
41: inst = 9'b001_111_001; //add r7, r1	r7 = 30
42: inst = 9'b000_110_010; //and r6, r2	r6 = 30 & E
43: inst = 9'b100_111011; //ldi 59		regime 2
44: inst = 9'b111_110_111; //bne r6, r7	r6 is 30 if E is 30 or 31
45: inst = 9'b100_000000; //ldi 0
46: inst = 9'b000_011_001; //and r3, r1
47: inst = 9'b000_100_001; //and r4, r1
48: inst = 9'b000_110_001; //and r6, r1
49: inst = 9'b100_111111; //ldi 0b111111
50: inst = 9'b001_100_001; //add r4, r1
51: inst = 9'b0110_100_01; //lsl r4, 2
52: inst = 9'b100_000011; //ldi 0b11
53: inst = 9'b001_100_001; //add r4, r1
54: inst = 9'b001_011_100; //add r3, r4
55: inst = 9'b0111_011_00; //lsr r3, 1
56: inst = 9'b100_000000; //ldi 0
57: inst = 9'b101_001_001; //ldm r1, r1
58: inst = 9'b111_011_100; //bne r3, r4	force branch (pseudo jump instr)
59: inst = 9'b100_000000; //ldi 0		PC = 59
60: inst = 9'b000_110_001; //and r6, r1
61: inst = 9'b000_111_001; //and r7, r1
62: inst = 9'b100_111100; //ldi 0b111100	
63: inst = 9'b001_110_001; //add r6, r1
64: inst = 9'b0110_110_01; //lsl r6, 2
65: inst = 9'b100_000010; //ldi 0b10
66: inst = 9'b001_110_001; //add r6, r1
67: inst = 9'b000_110_010; //and r6, r2
68: inst = 9'b100_001100; //ldi 0b1100
69: inst = 9'b000_110_001; //and r6, r1
70: inst = 9'b001_111_001; //add r7, r1
71: inst = 9'b100_000000; //ldr r0, regime3
72: inst = 9'b000_000_001;
73: inst = 9'b100_011100;
74: inst = 9'b001_000_001;
75: inst = 9'b0110_000_01;
76: inst = 9'b100_000001;
77: inst = 9'b001_001_000;
78: inst = 9'b111_110_111; //bne r6, r7
79: inst = 9'b100_000000; //ldi 0
80: inst = 9'b000_110_001; //and r6, r1
81: inst = 9'b000_111_001; //and r7, r1
82: inst = 9'b0110_011_00; //lsl r3, 1
83: inst = 9'b100_100000; //ldi 0b100000
84: inst = 9'b0110_001_01; //lsl	 r1, 2	r1 = 0b10000000
85: inst = 9'b001_110_001; //add r6, r1	r6 = 0b10000000
86: inst = 9'b001_111_001; //add r7, r1	r7 = 0b10000000
87: inst = 9'b000_110_010; //and r6, r2	r6 = 0b10000000 & LSW
88: inst = 9'b100_000000; //ldr r0, shiftLSW ASSUMED r5 IS GARGABE VALUE
89: inst = 9'b000_000_001;
90: inst = 9'b100_011000;
91: inst = 9'b001_000_001;
92: inst = 9'b0110_000_01;
93: inst = 9'b100_000010;
94: inst = 9'b001_001_000;
95: inst = 9'b111_110_111; //bne r6, r7
96: inst = 9'b100_000001; //ldi 1
97: inst = 9'b001_011_001; //add r3, r1
98: inst = 9'b0110_110_11; //lsl r6, 4	clear r6
99: inst = 9'b0110_111_11; //lsl r7, 4	clear r7
100: inst = 9'b0110_100_00; //lsl r4, 1
101: inst = 9'b100_111111; //ldi 0b111111
102: inst = 9'b0110_001_01; //lsl r1, 2
103: inst = 9'b001_010_001; //add r2, r1
104: inst = 9'b100_000011; //ldi 0b11
105: inst = 9'b001_010_001; //add r2, r1	Decrement E
106: inst = 9'b100_011001; //ldi 25
107: inst = 9'b001_110_001; //add r6, r1
108: inst = 9'b100_111111; //ldi 63
109: inst = 9'b001_111_001; //add r7, r1
110: inst = 9'b100_010000; //ldi 16
111: inst = 9'b001_001_111; //add r1, r7
112: inst = 9'b111_010_110; //bne r2, r6
113: inst = 9'b0111_110_11; //lsr r6, 4	clear r6
114: inst = 9'b0111_111_11; //lsr r7, 4	clear r7
115: inst = 9'b100_011001; //ldi 25
116: inst = 9'b001_110_001; //add r6, r1
117: inst = 9'b100_000000; //ldr r0, regime4
118: inst = 9'b000_000_001;
119: inst = 9'b100_100000;
120: inst = 9'b001_000_001;
121: inst = 9'b0110_000_01;
122: inst = 9'b100_000000;
123: inst = 9'b001_001_000;
124: inst = 9'b111_010_110; //bne r2, r6
125: inst = 9'b100_000000; //ldi 0
126: inst = 9'b101_001_001; //ldm r1, r1
127: inst = 9'b111_110_111; //bne r6, r7
128: inst = 9'b100_000000; //ldi 0
129: inst = 9'b000_110_001; //and r6, r1
130: inst = 9'b000_111_001; //and r7, r1
131: inst = 9'b100_000010; //ldi 2
132: inst = 9'b001_110_001; //add r6, r1
133: inst = 9'b001_110_010; //add r6, r2 	E + 2
134: inst = 9'b0111_110_11; //lsr	r6, 4	r6 == 1 if E > 13
135: inst = 9'b100_000001; //ldi 1
136: inst = 9'b001_111_001; //add r7, r1
137: inst = 9'b100_000000; //ldr r0, regime5
138: inst = 9'b000_000_001;
139: inst = 9'b100_110100;
140: inst = 9'b001_000_001;
141: inst = 9'b0110_000_01;
142: inst = 9'b100_000011;
143: inst = 9'b001_001_000;
144: inst = 9'b111_110_111; //bne r6, r7
145: inst = 9'b0111_110_11; //lsr r6, 4	clear r6
146: inst = 9'b0111_111_11; //lsr r7, 4	clear r7
147: inst = 9'b100_000011; //ldi 3
148: inst = 9'b110_101_001; //str r5, r1	store [3] = r5 = signbit, need free regs
149: inst = 9'b0110_001_00; //lsl r1, 1
150: inst = 9'b110_010_001; //str r2, r1	store [6] = r2 = E.	r0,r2,r5,r6,r7 free
151: inst = 9'b100_000000; //ldi 0
152: inst = 9'b000_000_001; //and r0, r1
153: inst = 9'b000_010_001; //and r2, r1	R = 0
154: inst = 9'b000_101_001; //and r5, r1	S = 0
155: inst = 9'b100_000000; //ldi 0
156: inst = 9'b000_110_001; //and r6, r1	clear r6
157: inst = 9'b000_111_001; //and r7, r1	clear r7
158: inst = 9'b100_000001; //ldi 1
159: inst = 9'b001_111_001; //add r7, r1	r6 = 1
160: inst = 9'b001_110_001; //add r6, r1	r7 = 1
161: inst = 9'b000_001_100; //and r1, r4	old G = LSW & 1
162: inst = 9'b001_000_001; //add r0, r1	shift out in r0
163: inst = 9'b0111_100_00; //lsr r4, 1	shift LSW right 1
164: inst = 9'b100_000001; //ldi 1
165: inst = 9'b010_101_001; //xor r5, r1
166: inst = 9'b010_001_010; //xor r1, r2
167: inst = 9'b000_101_001; //and r5, r1
168: inst = 9'b100_000001; //ldi 1
169: inst = 9'b010_101_001; //xor r5, r1
170: inst = 9'b0111_010_11; //lsr r2, 4
171: inst = 9'b001_010_000; //add r2, r0	R = old G
172: inst = 9'b000_110_011; //and r6, r3	MSW & 1
173: inst = 9'b100_000000; //ldr r0, if8
174: inst = 9'b000_000_001;
175: inst = 9'b100_101110;
176: inst = 9'b001_000_001;
177: inst = 9'b0110_000_01;
178: inst = 9'b100_000000;
179: inst = 9'b001_001_000;
180: inst = 9'b111_110_111; //bne r6, r7 	save right shift out from MSW
181: inst = 9'b100_100000; //ldi 0b100000
182: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
183: inst = 9'b001_100_001; //add r4, r1
184: inst = 9'b0111_011_00; //lsr r3, 1	shift MSW right 1
185: inst = 9'b100_000110; //ldi 6		[6] holds E
186: inst = 9'b101_111_001; //ldm r7, r1	r7 = E
187: inst = 9'b100_011001; //ldi 25
188: inst = 9'b0111_110_11; //lsr r6, 4	clear r6
189: inst = 9'b001_110_001; //add r6, r1	r6 = 25
190: inst = 9'b100_000001; //ldi 1
191: inst = 9'b001_111_001; //add r7, r1
192: inst = 9'b100_000110; //ldi 6
193: inst = 9'b110_111_001; //str r7, r1
194: inst = 9'b100_000000; //ldr r0, shiftright
195: inst = 9'b000_000_001;
196: inst = 9'b100_100110;
197: inst = 9'b001_000_001;
198: inst = 9'b0110_000_01;
199: inst = 9'b100_000011;
200: inst = 9'b001_001_000;
201: inst = 9'b111_110_111; //bne r6, r7
202: inst = 9'b0111_110_11; //lsr r6, 4
203: inst = 9'b100_000000; //ldr r0, round
204: inst = 9'b000_000_001;
205: inst = 9'b100_110110;
206: inst = 9'b001_000_001;
207: inst = 9'b0110_000_01;
208: inst = 9'b100_000011;
209: inst = 9'b001_001_000;
210: inst = 9'b111_110_111; //bne r6, r7
211: inst = 9'b100_000000; //ldi 0
212: inst = 9'b000_011_001; //and r3, r1
213: inst = 9'b000_100_001; //and r4, r1
214: inst = 9'b100_000001; //ldi 1
215: inst = 9'b001_110_001; //add r6, r1
216: inst = 9'b100_000000; //ldi 0
217: inst = 9'b101_001_001; //ldm r1, r1
218: inst = 9'b111_011_110; //bne r3, r6
219: inst = 9'b100_000000; //ldi 0
220: inst = 9'b000_110_001; //and r6, r1
221: inst = 9'b000_111_001; //and r7, r1
222: inst = 9'b100_000001; //ldi 1
223: inst = 9'b001_110_001; //add r6, r1
224: inst = 9'b001_111_001; //add r7, r1
225: inst = 9'b000_110_100; //and r6, r4	r6 = G
226: inst = 9'b000_110_010; //and r6, r2 	r6  = G & R
227: inst = 9'b000_111_101; //and r7, r5	r7 = S
228: inst = 9'b000_010_101; //and r2, r5	r2 = R & S
229: inst = 9'b010_110_001; //xor r6, r1 	 ~r6
230: inst = 9'b010_010_001; //xor r2, r1	 ~r7
231: inst = 9'b000_110_010; //and r6, r2 	 (~r6 & ~r7)
232: inst = 9'b010_110_001; //xor r6, r1		r6 | r7
233: inst = 9'b0111_111_11; //lsr r7, 4
234: inst = 9'b001_111_001; //add r7, r1
235: inst = 9'b100_000000; //ldi 0
236: inst = 9'b101_001_001; //ldm r1, r1
237: inst = 9'b111_110_111; //bne r6, r7
238: inst = 9'b001_100_110; //add r4, r6
239: inst = 9'b0111_110_11; //lsr r6, 4	clear r6
240: inst = 9'b100_000000; //ldi 0
241: inst = 9'b101_001_001; //ldm r1, r1	load done label
242: inst = 9'b111_110_100; //bne r6, r4
243: inst = 9'b100_000001; //ldi 1
244: inst = 9'b001_011_001; //add r3, r1
245: inst = 9'b100_000000; //ldi 0
246: inst = 9'b000_111_001; //and r7, r1
247: inst = 9'b100_000011; //ldi 3
248: inst = 9'b101_110_001; //ldm r6, r1  r6 = sign bit
249: inst = 9'b001_110_011; //add r6, r3  S + MSW
250: inst = 9'b100_010001; //ldi 17
251: inst = 9'b001_111_001; //add r7, r1
252: inst = 9'b0110_111_10; //lsl r7, 3
253: inst = 9'b110_110_111; //str r6, r7
254: inst = 9'b100_000001; //ldi 1
255: inst = 9'b001_111_001; //add r7, r1
256: inst = 9'b110_100_111; //str r4, r7
default: inst = 'b111_111_111; // covers all cases not included in the above list
  endcase
endmodule