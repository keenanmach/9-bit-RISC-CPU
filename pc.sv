// CSE141L Winter 2018
// program counter for in class demo
import definitions::*;
module pc (
  input        [2:0] op, 		 // opcodes
  input              z,		     // zero flag from ALU
  input			[7:0]	rslt,
  input signed [7:0] bamt,		 // how far/where to jump or branch
  input              clk,	     // clk -- PC advances and memory/reg_file writes are clocked 
  input              reset,		 // overrides all else, forces PC to 0 (start of program)
  output logic [7:0] PC);		 // program count

  //assign jump = z && op==kBNE;	 

  always_ff @(posedge clk) 
    if(reset)					 // resetting to start=0
	  PC <= 'b0;
	else if (rslt && op==kBNE)               // abs branching
	  PC <= bamt;
	else						 // normal/default operation
	  PC <= PC + 'b1;			 

endmodule