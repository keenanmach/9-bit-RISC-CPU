// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem(
  input       [7:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
  always_comb case(PC)
    0: inst = 'b100_000110; //ldi 6
	 1: inst = 'b001_001_001; //add r1, r1
	 2: inst = 'b001_101_001; //add r5, r1
	 3: inst = 'b011_0_101_11; //lsh r5, 4
	 4: inst = 'b100_000111; //ldi 7
	 5: inst = 'b111_101_001; //bne r5, r1
	 6: inst = 'b001_001_001; //add r1, r1
	 7: inst = 'b100_001010;	//ldi 10
	 8: inst = 'b110_001_101;	//str r1, r5
	 9: inst = 'b001_001_001; //add r1, r1
	 10: inst = 'b101_001_101; //ldm r1, r5
	default: inst = 'b111_111_111; // covers all cases not included in the above list
  endcase
endmodule