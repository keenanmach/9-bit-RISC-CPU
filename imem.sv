// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem(
  input       [7:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
  always_comb case(PC)
0: inst = 9'b100_000000; //ldi 0
1: inst = 9'b000_111_001; //and r7, r1
2: inst = 9'b000_110_001; //and r6, r1
3: inst = 9'b000_101_001; //and r5, r1
4: inst = 9'b000_100_001; //and r4, r1	r4 = 0
5: inst = 9'b000_011_001; //and r3, r1	r3 = 0
6: inst = 9'b100_100000; //ldi 0b100000
7: inst = 9'b001_011_001; //add r3, r1	r3 = 32
8: inst = 9'b0110_011_01; //lsl r3, 2	r3 = 128
9: inst = 9'b101_000_011; //ldm r0, r3	r0 = MSW
10: inst = 9'b100_000001; //ldi 1
11: inst = 9'b001_011_001; //add r3, r1	r3 = 129
12: inst = 9'b101_010_011; //ldm r2, r3	r2 = LSW
13: inst = 9'b100_000000; //ldi 0
14: inst = 9'b000_011_001; //and r3, r1	r3 = 0
15: inst = 9'b100_011101; //ldi 29
16: inst = 9'b001_011_001; //add r3, r1	r3 = 29
17: inst = 9'b100_100000; //ldi 0b100000
18: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
19: inst = 9'b001_100_001; //add r4, r1	r4 = 0b10000000
20: inst = 9'b000_100_000; //and r4, r0	r4 = 0b10000000 & MSW = signbit
21: inst = 9'b100_000000; //ldi 0
22: inst = 9'b000_101_001; //and r5, r1	r5 = 0
23: inst = 9'b000_110_001; //and r6, r1	r6 = 0
24: inst = 9'b000_111_001; //and r7, r1	r7 = 0
25: inst = 9'b100_100000; //ldi 0b100000
26: inst = 9'b0110_001_00; //lsl r1, 1	r1 = 0b1000000
27: inst = 9'b001_101_001; //add r5, r1	r5 = 0b1000000 = mask
28: inst = 9'b001_110_000; //add r6, r0	r6 = MSW
29: inst = 9'b000_110_101; //and r6, r5	r6 = mask & MSW
30: inst = 9'b100_000000; //ldr r5, if3 ASSUMED r5 IS GARBAGE VALUE
31: inst = 9'b000_101_001;
32: inst = 9'b100_010100;
33: inst = 9'b001_101_001;
34: inst = 9'b0110_101_01;
35: inst = 9'b100_000011;
36: inst = 9'b001_001_101;
37: inst = 9'b111_110_111; //bne	r6, r7
38: inst = 9'b0110_000_00; //lsl r0, 1
39: inst = 9'b0110_110_11; //lsl r6, 4	clear r6
40: inst = 9'b100_100000; //ldi 0b100000
41: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
42: inst = 9'b001_110_001; //add r6, r1	r6 = 0b10000000
43: inst = 9'b001_111_001; //add r7, r1	r7 = 0b10000000
44: inst = 9'b000_110_010; //and r6, r2	r6 = 0b10000000 & LSW
45: inst = 9'b100_000000; //ldr r5, if2 ASSUMED r5 IS GARGABE VALUE
46: inst = 9'b000_101_001;
47: inst = 9'b100_001101;
48: inst = 9'b001_101_001;
49: inst = 9'b0110_101_01;
50: inst = 9'b100_000011;
51: inst = 9'b001_001_101;
52: inst = 9'b111_110_111; //bne r6, r7
53: inst = 9'b100_000001; //ldi 1
54: inst = 9'b001_000_001; //add r0, r1
55: inst = 9'b100_000000; //ldi 0
56: inst = 9'b000_101_001; //and r5, r1	r5 = 0
57: inst = 9'b000_110_001; //and r6, r1	r6 = 0
58: inst = 9'b0110_010_00; //lsl r2, 1
59: inst = 9'b100_111111; //ldi 0b111111
60: inst = 9'b0110_001_01; //lsl r1, 2
61: inst = 9'b001_011_001; //add r3, r1
62: inst = 9'b100_000011; //ldi 0b11
63: inst = 9'b001_011_001; //add r3, r1	Decrement E
64: inst = 9'b100_001101; //ldi 13
65: inst = 9'b001_101_001; //add r5, r1
66: inst = 9'b100_000000; //ldr r6, if3
67: inst = 9'b000_110_001;
68: inst = 9'b100_010100;
69: inst = 9'b001_110_001;
70: inst = 9'b0110_110_01;
71: inst = 9'b100_000011;
72: inst = 9'b001_001_110;
73: inst = 9'b111_101_011; //bne	r5, r3
74: inst = 9'b0111_011_11; //lsr r3, 4
75: inst = 9'b100_000000; //ldr r6, done
76: inst = 9'b000_110_001;
77: inst = 9'b100_111010;
78: inst = 9'b001_110_001;
79: inst = 9'b0110_110_01;
80: inst = 9'b100_000010;
81: inst = 9'b001_001_110;
82: inst = 9'b111_011_101; //bne r3, r5
83: inst = 9'b100_000000; //ldi 0
84: inst = 9'b000_101_001; //and r5, r1	r5 = 0
85: inst = 9'b000_110_001; //and r6, r1	r6 = 0
86: inst = 9'b100_100000; //ldi 0b100000
87: inst = 9'b0110_001_00; //lsl r1, 1	r1 = 0b1000000
88: inst = 9'b001_101_001; //add r5, r1	r5 = 0b1000000 = mask
89: inst = 9'b001_110_000; //add r6, r0	r6 = MSW
90: inst = 9'b000_110_101; //and r6, r5	r6 = mask & MSW
91: inst = 9'b100_000000; //ldr r7, loop	ASSUMED r7 IS GARBAGE VALUE loop again if mask & MSW != 0
92: inst = 9'b000_111_001;
93: inst = 9'b100_000101;
94: inst = 9'b001_111_001;
95: inst = 9'b0110_111_01;
96: inst = 9'b100_000001;
97: inst = 9'b001_001_111;
98: inst = 9'b111_110_101; //bne r6, r5	r6 = mask & MSW & mask
99: inst = 9'b0110_110_11; //lsl r6, 4	clear r6
100: inst = 9'b100_010000; //ldi 0b10000
101: inst = 9'b001_110_001; //add r6, r1	 r6 = 0b10000
102: inst = 9'b000_110_010; //and r6, r2	 r6 = 0b10000 & LSW
103: inst = 9'b0111_110_11; //lsr r6, 4	 r6 = (bit) LSW[4]
104: inst = 9'b100_000000; //ldi 0
105: inst = 9'b000_111_001; //and r7, r1
106: inst = 9'b100_001000; //ldi 0b1000
107: inst = 9'b001_111_001; //add r7, r1	 r7 = 0b1000
108: inst = 9'b000_111_010; //and r7, r2	 r7 = 0b1000 & LSW
109: inst = 9'b0111_111_10; //lsr r7, 3	 r7 = (bit) LSW[3]
110: inst = 9'b000_110_111; //and r6, r7	 r6 = LSW[3] && LSW[4]
111: inst = 9'b0111_111_11; //lsr r7, 4	clear r7
112: inst = 9'b100_000001; //ldi 1
113: inst = 9'b001_111_001; //add r7, r1
114: inst = 9'b100_000000; //ldr r5, if5 ASSUMED r5 IS GARBAGE VALUE
115: inst = 9'b000_101_001;
116: inst = 9'b100_100011;
117: inst = 9'b001_101_001;
118: inst = 9'b0110_101_01;
119: inst = 9'b100_000001;
120: inst = 9'b001_001_101;
121: inst = 9'b111_110_111; //bne r6, r7
122: inst = 9'b0111_110_11; //lsr r6, 4
123: inst = 9'b0111_111_11; //lsr r7, 4
124: inst = 9'b100_011111; //ldi 0b11111
125: inst = 9'b001_110_001; //add r6, r1
126: inst = 9'b0110_110_10; //lsl r6, 3	r6 = 0b11111000
127: inst = 9'b001_111_110; //add r7, r6	r7 = 0b11111000
128: inst = 9'b000_110_010; //and r6, r2	r6 = 0b11111000 & LSW
129: inst = 9'b100_000000; //ldr r5, if4 ASSUMED r5 IS GARBAGE VALUE
130: inst = 9'b000_101_001;
131: inst = 9'b100_100010;
132: inst = 9'b001_101_001;
133: inst = 9'b0110_101_01;
134: inst = 9'b100_000011;
135: inst = 9'b001_001_101;
136: inst = 9'b111_110_111; //bne r6, r7
137: inst = 9'b100_000001; //ldi 1
138: inst = 9'b001_000_001; //add r0, r1
139: inst = 9'b100_001000; //ldi 8
140: inst = 9'b001_010_001; //add r2, r1
141: inst = 9'b100_000000; //ldi 0
142: inst = 9'b000_110_001; //and r6, r1
143: inst = 9'b000_111_001; //and r7, r1
144: inst = 9'b100_010000; //ldi 0b10000
145: inst = 9'b001_110_001; //add r6, r1	 r6 = 0b10000
146: inst = 9'b001_111_001; //add r7, r1	 r7 = 0b10000
147: inst = 9'b000_110_010; //and r6, r2	 r6 = 0b10000 & LSW
148: inst = 9'b010_110_111; //xor r6, r7
149: inst = 9'b0111_110_11; //lsr r6, 4	 r6 = (bit) !LSW[4]
150: inst = 9'b0110_111_11; //lsl r7, 4	clear r7
151: inst = 9'b100_001000; //ldi 0b1000
152: inst = 9'b001_111_001; //add r7, r1	 r7 = 0b1000
153: inst = 9'b000_111_010; //and r7, r2	 r7 = 0b1000 & LSW
154: inst = 9'b0111_111_10; //lsr r7, 3
155: inst = 9'b000_110_111; //and r6, r7	r6 = LSW[3] && !LSW[4]
156: inst = 9'b100_000000; //ldi 0
157: inst = 9'b000_111_001; //and r7, r1
158: inst = 9'b000_101_001; //and r5, r1
159: inst = 9'b100_000111; //ldi 0b111
160: inst = 9'b001_111_001; //add r7, r1	 r7 = 0b111
161: inst = 9'b001_101_001; //add r5, r1	 r5 = 0b111
162: inst = 9'b000_111_010; //and r7, r2	 r7 = 0b111 & LSW
163: inst = 9'b001_111_101; //add r7, r5
164: inst = 9'b0111_111_10; //lsr r7, 3
165: inst = 9'b000_110_111; //and r6, r7
166: inst = 9'b0111_111_11; //lsr r7, 4	clear r7
167: inst = 9'b100_000001; //ldi 1
168: inst = 9'b001_111_001; //add r7, r1
169: inst = 9'b100_000000; //ldr r5, if7 ASSUMED r5 IS GARBAGE VALUE
170: inst = 9'b000_101_001;
171: inst = 9'b100_110001;
172: inst = 9'b001_101_001;
173: inst = 9'b0110_101_01;
174: inst = 9'b100_000000;
175: inst = 9'b001_001_101;
176: inst = 9'b111_110_111; //bne r6, r7
177: inst = 9'b0111_110_11; //lsr r6, 4
178: inst = 9'b0111_111_11; //lsr r7, 4
179: inst = 9'b100_011111; //ldi 0b11111
180: inst = 9'b001_110_001; //add r6, r1
181: inst = 9'b0110_110_10; //lsl r6, 3	r6 = 0b11111000
182: inst = 9'b001_111_110; //add r7, r6	r7 = 0b11111000
183: inst = 9'b000_110_010; //and r6, r2	r6 = 0b11111000 & LSW
184: inst = 9'b100_000000; //ldr r5, if6 ASSUMED r5 IS GARBAGE VALUE
185: inst = 9'b000_101_001;
186: inst = 9'b100_110000;
187: inst = 9'b001_101_001;
188: inst = 9'b0110_101_01;
189: inst = 9'b100_000010;
190: inst = 9'b001_001_101;
191: inst = 9'b111_110_111; //bne r6, r7
192: inst = 9'b100_000001; //ldi 1
193: inst = 9'b001_000_001; //add r0, r1
194: inst = 9'b100_001000; //ldi 8
195: inst = 9'b001_010_001; //add r2, r1
196: inst = 9'b100_000000; //ldi 0
197: inst = 9'b000_111_001; //and r7, r1	r7 = 0
198: inst = 9'b000_110_001; //and r6, r1 	r6 = 0
199: inst = 9'b100_100000; //ldi 0b100000
200: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
201: inst = 9'b001_111_001; //add r7, r1	r7 = 0b10000000
202: inst = 9'b001_110_001; //add r6, r1	r6 = 0b10000000
203: inst = 9'b000_110_000; //and r6, r0	r6 = MSW & 0b10000000
204: inst = 9'b100_000000; //ldr r5, done	ASSUMED r5 IS GARBAGE VALUE
205: inst = 9'b000_101_001;
206: inst = 9'b100_111010;
207: inst = 9'b001_101_001;
208: inst = 9'b0110_101_01;
209: inst = 9'b100_000010;
210: inst = 9'b001_001_101;
211: inst = 9'b111_110_111; //bne r6, r7
212: inst = 9'b0111_010_00; //lsr r2, 1	shift LSW right 1
213: inst = 9'b0110_110_11; //lsl r6, 4
214: inst = 9'b100_000001; //ldi 1
215: inst = 9'b001_110_001; //add r6, r1
216: inst = 9'b000_110_000; //and r6, r0
217: inst = 9'b0110_111_11; //lsl r7, 4
218: inst = 9'b100_000001; //ldi 1
219: inst = 9'b001_111_001; //add r7, r1
220: inst = 9'b100_000000; //ldr r5, if8
221: inst = 9'b000_101_001;
222: inst = 9'b100_111001;
223: inst = 9'b001_101_001;
224: inst = 9'b0110_101_01;
225: inst = 9'b100_000011;
226: inst = 9'b001_001_101;
227: inst = 9'b111_110_111; //bne r6, r7 	save right shift out from MSW
228: inst = 9'b100_100000; //ldi 0b100000
229: inst = 9'b0110_001_01; //lsl r1, 2	r1 = 0b10000000
230: inst = 9'b001_010_001; //add r2, r1
231: inst = 9'b0111_000_00; //lsr r0, 1
232: inst = 9'b100_000001; //ldi 1
233: inst = 9'b001_011_001; //add r3, r1	increment E
234: inst = 9'b0110_011_01; //lsl r3, 2	beginning of done
235: inst = 9'b001_100_011; //add r4, r3 	{signbit,e,'b00}
236: inst = 9'b100_110000; //ldi 0b110000
237: inst = 9'b000_001_000; //and r1, r0
238: inst = 9'b0111_001_11; //lsr r1, 4
239: inst = 9'b001_100_001; //add r4, r1	r4 = {signbit,E,MSW[5:4]}
240: inst = 9'b0110_000_11; //lsl r0, 4
241: inst = 9'b0111_010_11; //lsr r2, 4
242: inst = 9'b001_000_010; //add r0, r2	r0 = {MSW[3:0],LSW[7:4]}
243: inst = 9'b100_000000; //ldi 0
244: inst = 9'b000_010_001; //and r2, r1
245: inst = 9'b100_100000; //ldi 0b100000
246: inst = 9'b0110_001_01; //lsl r1, 2
247: inst = 9'b001_010_001; //add r2, r1
248: inst = 9'b100_000011; //ldi 3
249: inst = 9'b001_010_001; //add r2, r1	r2 = 131
250: inst = 9'b110_100_010; //str r4, r2
251: inst = 9'b100_000001; //ldi 1
252: inst = 9'b001_010_001; //add r2, r1	r2 = 132
253: inst = 9'b110_000_010; //str r0, r2
254: inst = 9'b111_111_111; //bne r7, r7	"halt" instruction
default: inst = 'b111_111_111; // covers all cases not included in the above list
  endcase
endmodule