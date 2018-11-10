// CSE141L Winter 2018 in class demo
// lookup table for data memory addressing
// lets us access dm_adr pointer values 3, 4, and 5
//   (could be ANY desired others, including 64, 65, 128, etc.)
//   using only a 2-bit selector
module lut_m(
   input       [2:0] op,			    // opcode
   input       [7:0] in_a,		    // operands in
					 in_b,
   output		[7:0] dm_adr
);
					 

always_comb case (op)
  kLDM: dm_adr = in_b;	        // demo will load from mem_adr 3 and 4
  kSTR: dm_adr = in_a;
  default: dm_adr = 255;
endcase

endmodule