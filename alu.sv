// ALU for class demo
// CSE141L Win 2018
import definitions::*;              // declares ALU opcodes 
module alu (
  input 			rsh,			// Right shift is this bit is 1 left shift if 0
  input             ci,			    // carry in
  input       [2:0] op,			    // opcode
  input       [7:0] in_a,		    // operands in
                    in_b,
  input              clk,	
  output logic[7:0] rslt,		    // result out
  output logic      co,			    // carry out
  output logic      z); 		    // zero flag, like ARM Z flag
  op_mne op_mnemonic;			    // type enum: used for convenient waveform viewing

  always_comb begin
    co    = 1'b0;				    // defaults
	 rslt  = 8'b0;
	 z = 0;	
    case(op)						// selective override one or more defaults
     kAND: rslt = in_a & in_b;		   
	  kADD: {co,rslt} = in_a+in_b+ci;  // add w/ carry in and out
	  kXOR: rslt = in_a ^ in_b;
	  kLSH: begin
				if (rsh)
					rslt = in_a >> in_b;
				else
					rslt = in_a << in_b;
				end
	  kSTR: rslt = in_a;			// store in data_mem from reg_file
	  kLDM: rslt = in_a;
	  kLDI: rslt = in_b;
	  kBNE: rslt = in_a - in_b;
	  default: rslt = 0;
    endcase
  end
  
  assign  op_mnemonic = op_mne'(op);  // creates ALU opcode mnemonics in timing diagram

endmodule