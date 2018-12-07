// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem(
  input       [7:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
  always_comb case(PC)
0: instr = 9'b100_000000;
1: instr = 9'b000_011_001; //r3 = 0
2: instr = 9'b100_100000;
3: instr = 9'b001_011_001; //r3 = 32
4: instr = 9'b0110_011_01; //r3 = 128
5: instr = 9'b101_000_011; //r0 = MSW
6: instr = 9'b100_000001;
7: instr = 9'b001_011_001; //r3 = 129
8: instr = 9'b101_010_011; //r2 = LSW
9: instr = 9'b100_000000;
10: instr = 9'b000_011_001; //r3 = 0
11: instr = 9'b100_011101;
12: instr = 9'b001_011_001; //r3 = 29
13: instr = 9'b100_000000;
14: instr = 9'b000_100_001; //r4 = 0
15: instr = 9'b100_100000;
16: instr = 9'b0110_001_01; //r1 = 0b10000000
17: instr = 9'b001_100_001; //r4 = 0b10000000
18: instr = 9'b000_100_000; //r4 = 0b10000000 & MSW = signbit
19: instr = 9'b100_000000;
20: instr = 9'b000_101_001; //r5 = 0
21: instr = 9'b100_100000;
22: instr = 9'b0110_001_00; //r1 = 0b1000000
23: instr = 9'b001_101_001; //r5 = 0b1000000 = mask
24: instr = 9'b100_000000;
25: instr = 9'b000_110_001; //r6 = 0
26: instr = 9'b001_110_000; //r6 = MSW
27: instr = 9'b000_110_101; //r6 = mask & MSW
28: instr = 9'b100_000000;
29: instr = 9'b000_111_001; //r7 = 0
30: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
31: instr = 9'b000_101_001;
32: instr = 9'b100_010000;
33: instr = 9'b001_101_001;
34: instr = 9'b0110_101_01;
35: instr = 9'b100_000010;
36: instr = 9'b001_001_101;
37: instr = 9'b111_110_111;
38: instr = 9'b0110_000_00;
39: instr = 9'b100_000000;
40: instr = 9'b000_110_001; //r6 = 0
41: instr = 9'b100_100000;
42: instr = 9'b0110_001_01; //r1 = 0b10000000
43: instr = 9'b001_110_001; //r6 = 0b10000000
44: instr = 9'b000_110_010; //r6 = 0b10000000 & LSW
45: instr = 9'b100_000000;
46: instr = 9'b000_111_001; //r7 = 0
47: instr = 9'b100_100000;
48: instr = 9'b0110_001_01;
49: instr = 9'b001_111_001;
50: instr = 9'b100_000000; //ASSUMED r5 IS GARGABE VALUE
51: instr = 9'b000_101_001;
52: instr = 9'b100_001111;
53: instr = 9'b001_101_001;
54: instr = 9'b0110_101_01;
55: instr = 9'b100_000000;
56: instr = 9'b001_001_101;
57: instr = 9'b111_110_111;
58: instr = 9'b100_000001;
59: instr = 9'b001_000_001;
60: instr = 9'b0110_010_00;
61: instr = 9'b100_111111;
62: instr = 9'b0110_001_01;
63: instr = 9'b001_011_001;
64: instr = 9'b100_000011;
65: instr = 9'b001_011_001; //Decrement E
66: instr = 9'b100_000000;
67: instr = 9'b000_101_001; //r5 = 0
68: instr = 9'b100_100000;
69: instr = 9'b0110_001_00; //r1 = 0b1000000
70: instr = 9'b001_101_001; //r5 = 0b1000000 = mask
71: instr = 9'b100_000000;
72: instr = 9'b000_110_001; //r6 = 0
73: instr = 9'b001_110_000; //r6 = MSW
74: instr = 9'b000_110_101; //r6 = mask & MSW
75: instr = 9'b100_000000; //ASSUMED r7 IS GARBAGE VALUE loop again if mask & MSW != 0
76: instr = 9'b000_111_001;
77: instr = 9'b100_000100;
78: instr = 9'b001_111_001;
79: instr = 9'b0110_111_01;
80: instr = 9'b100_000011;
81: instr = 9'b001_001_111;
82: instr = 9'b111_110_101; //r6 = mask & MSW & mask
83: instr = 9'b100_000000;
84: instr = 9'b000_110_001;
85: instr = 9'b100_010000;
86: instr = 9'b001_110_001; // r6 = 0b10000
87: instr = 9'b000_110_010; // r6 = 0b10000 & LSW
88: instr = 9'b100_000000;
89: instr = 9'b000_111_001;
90: instr = 9'b100_001000;
91: instr = 9'b001_111_001; // r7 = 0b1000
92: instr = 9'b000_111_010; // r7 = 0b1000 & LSW
93: instr = 9'b001_110_111; // r7 = (0b10000 & LSW) & (0b1000 & LSW)
94: instr = 9'b100_000000;
95: instr = 9'b000_111_001;
96: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
97: instr = 9'b000_101_001;
98: instr = 9'b100_011111;
99: instr = 9'b001_101_001;
100: instr = 9'b0110_101_01;
101: instr = 9'b100_000011;
102: instr = 9'b001_001_101;
103: instr = 9'b111_110_111;
104: instr = 9'b100_000000;
105: instr = 9'b000_110_001;
106: instr = 9'b100_011111;
107: instr = 9'b001_110_001;
108: instr = 9'b0110_110_10; //r6 = 0b11111000
109: instr = 9'b000_110_010; //r6 = 0b11111000 & LSW
110: instr = 9'b100_000000;
111: instr = 9'b000_111_001;
112: instr = 9'b100_011111;
113: instr = 9'b001_111_001;
114: instr = 9'b0110_111_10; //r7 = 0b11111000
115: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
116: instr = 9'b000_101_001;
117: instr = 9'b100_011111;
118: instr = 9'b001_101_001;
119: instr = 9'b0110_101_01;
120: instr = 9'b100_000001;
121: instr = 9'b001_001_101;
122: instr = 9'b111_110_111;
123: instr = 9'b100_000001;
124: instr = 9'b001_000_001;
125: instr = 9'b100_001000;
126: instr = 9'b001_010_001;
127: instr = 9'b100_000000;
128: instr = 9'b000_110_001;
129: instr = 9'b100_010000;
130: instr = 9'b001_110_001; // r6 = 0b10000
131: instr = 9'b000_110_010; // r6 = 0b10000 & LSW
132: instr = 9'b100_000000;
133: instr = 9'b000_111_001;
134: instr = 9'b100_010000;
135: instr = 9'b001_111_001; // r6 = 0b10000
136: instr = 9'b010_110_111;
137: instr = 9'b100_000000;
138: instr = 9'b000_111_001;
139: instr = 9'b100_001000;
140: instr = 9'b001_111_001; // r7 = 0b1000
141: instr = 9'b000_111_010; // r7 = 0b1000 & LSW
142: instr = 9'b001_110_111;
143: instr = 9'b100_000000;
144: instr = 9'b000_111_001;
145: instr = 9'b100_000111;
146: instr = 9'b001_111_001; // r7 = 0b111
147: instr = 9'b000_111_010; // r7 = 0b111 & LSW
148: instr = 9'b001_110_111;
149: instr = 9'b100_000000;
150: instr = 9'b000_111_001;
151: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
152: instr = 9'b000_101_001;
153: instr = 9'b100_101101;
154: instr = 9'b001_101_001;
155: instr = 9'b0110_101_01;
156: instr = 9'b100_000010;
157: instr = 9'b001_001_101;
158: instr = 9'b111_110_111;
159: instr = 9'b100_000000;
160: instr = 9'b000_110_001;
161: instr = 9'b100_011111;
162: instr = 9'b001_110_001;
163: instr = 9'b0110_110_10; //r6 = 0b11111000
164: instr = 9'b000_110_010; //r6 = 0b11111000 & LSW
165: instr = 9'b100_000000;
166: instr = 9'b000_111_001;
167: instr = 9'b100_011111;
168: instr = 9'b001_111_001;
169: instr = 9'b0110_111_10; //r7 = 0b11111000
170: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
171: instr = 9'b000_101_001;
172: instr = 9'b100_101101;
173: instr = 9'b001_101_001;
174: instr = 9'b0110_101_01;
175: instr = 9'b100_000000;
176: instr = 9'b001_001_101;
177: instr = 9'b111_110_111;
178: instr = 9'b100_000001;
179: instr = 9'b001_000_001;
180: instr = 9'b100_001000;
181: instr = 9'b001_010_001;
182: instr = 9'b100_100000;
183: instr = 9'b0110_001_01; //r1 = 0b10000000
184: instr = 9'b001_110_001; //r6 = 0b10000000
185: instr = 9'b000_110_000;
186: instr = 9'b100_000000;
187: instr = 9'b000_111_001;
188: instr = 9'b100_000000; //ASSUMED r5 IS GARBAGE VALUE
189: instr = 9'b000_101_001;
190: instr = 9'b100_110111;
191: instr = 9'b001_101_001;
192: instr = 9'b0110_101_01;
193: instr = 9'b100_000000;
194: instr = 9'b001_001_101;
195: instr = 9'b111_110_111;
196: instr = 9'b0111_010_00; //shift LSW right 1
197: instr = 9'b100_000000;
198: instr = 9'b000_110_001;
199: instr = 9'b100_000001;
200: instr = 9'b001_110_001;
201: instr = 9'b000_110_000;
202: instr = 9'b100_000000;
203: instr = 9'b000_111_001;
204: instr = 9'b100_000001;
205: instr = 9'b001_111_001;
206: instr = 9'b100_000000;
207: instr = 9'b000_101_001;
208: instr = 9'b100_110110;
209: instr = 9'b001_101_001;
210: instr = 9'b0110_101_01;
211: instr = 9'b100_000001;
212: instr = 9'b001_001_101;
213: instr = 9'b111_110_111; //save right shift out from MSW
214: instr = 9'b100_100000;
215: instr = 9'b0110_001_01; //r1 = 0b10000000
216: instr = 9'b001_010_001;
217: instr = 9'b0111_000_00;
218: instr = 9'b100_000001;
219: instr = 9'b001_011_001; //increment E
220: instr = 9'b0110_011_01;
221: instr = 9'b001_100_011; //{signbit,e,'b00}
222: instr = 9'b100_110000;
223: instr = 9'b000_001_010;
224: instr = 9'b0111_001_11;
225: instr = 9'b001_100_001; //r4 = {signbit,E,MSW[5:4]}
226: instr = 9'b0110_000_11;
227: instr = 9'b0111_010_11;
228: instr = 9'b001_000_010; //r0 = {MSW[3:0],LSW[7:4]}
229: instr = 9'b100_000000;
230: instr = 9'b000_010_001;
231: instr = 9'b100_100000;
232: instr = 9'b0110_001_01;
233: instr = 9'b001_010_001;
234: instr = 9'b100_000011;
235: instr = 9'b001_010_001; // r2 = 131
236: instr = 9'b110_100_010;
237: instr = 9'b100_000001;
238: instr = 9'b001_010_001; //r2 = 132
239: instr = 9'b110_000_010;
240: instr = 9'b111_111_111; //"halt" instruction




	default: inst = 'b111_111_111; // covers all cases not included in the above list
  endcase
endmodule