// CSE141L Win2018    in-class demo
// top-level design connects all pieces together
import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

// list of interconnecting wires/buses w/ respective bit widths 
  wire signed[7:0] bamt;	    // PC jump
  wire[7:0] PC;				    // program counter
  wire[8:0] inst;			    // machine code
  wire[7:0] dm_out,			    // data memory
            dm_in,			   
            dm_adr;
  logic[7:0] in_a,			    // alu inputs
            in_b,			   
			rslt,               // alu output
            do_a,	            // reg_file outputs
			do_b;
  wire signed[7:0] br_out;      //branch register output
  wire[7:0] rf_din;	            // reg_file input
  wire[2:0] op;	                // opcode
  logic[2:0] ptr_a,			    // ref_file pointers
            ptr_b,			   
			ptr_w;
  wire      z;	                // alu zero flag
  logic     rf_we;              // reg_file write enable
  wire      ldr,			    // load mode (mem --> reg_file)
            str;			    // store (reg_file --> mem)
  assign    op    = inst[8:6];
  assign 	sh_d  = inst[5];
  assign 	ptr_w = op==kLSH ? inst[4:2] : (op==kLDI ? 3'b001 :inst[5:3]);
  assign 	ptr_a = op==kLSH ? inst[4:2] : inst[5:3];
  assign    ptr_b = inst[2:0];
  assign    dm_in = do_a;	    // rf ==> dm
  assign    in_a  = do_a; 		// rf ==> ALU
  
// load: rf data input from mem; else: from ALU out 
  assign    rf_din = ldr? dm_out : rslt;
  
// select immediate or rf for second ALU input
always_comb case (op)
    default: 
				in_b = do_b;
    kLSH: 
				in_b = inst[1:0]+1;						
	 kLDI: 
				in_b = inst[5:0];
endcase

	
  
  pc pc1(						 // program counter
    .clk (clk) ,
	.reset, 
	.op   ,					     // from inst_mem
	.bamt (bamt) ,		         // from reg file
	.z    ,					     // zero flag from ALU
	.PC );					     // to PC module

  imem im1(					     // instruction memory
     .PC   ,				     // pointer in = PC
	 .inst);				     // output = 7-bit (yours is 9) machine code

  assign done = inst == 'b111111111; // store result & hit done flag

  ctrl_dec  dc1(				     // "control" decode
   .op  ,
	.str ,					     // store turns on memory write enable
	.ldr,					     // load turns on reg_file write enable
   .rf_we
	);

  rf rf1(						 // reg file -- one write, two reads
    .clk             ,
	.di   (rf_din)   ,			 // data to be written in
	.we   (rf_we)      ,		 // write enable
	.ptr_w(ptr_w)   ,		 // write pointer = one of the read ptrs
	.ptr_a(ptr_a)   ,		 // read pointers 
	.ptr_b(ptr_b)   ,
	.do_a               ,        // to ALU
	.do_b  				,
	.bamt							// to ALU immediate input switch
  );

  alu au1(						 // execution (ALU) unit
   .rsh(sh_d),					 // shift direction
	.ci (1'b0),					 // not using carry-in in this program
	.op ,						    // ALU operation
	.in_a ,						 // alu inputs
	.in_b ,
	.rslt ,						 // alu output
	.co (),						 // carry out -- not connected, not used
	.z  );						 // zero flag   in_a=0

  dmem dm1(						 // data memory
    .clk         ,
	.we  (str)   ,				 // only time to write = store 
	.addr(do_b),				 // from LUT
	.di  (rslt) ,				 // data to store (from reg_file)
	.dout(dm_out)            // data out (for loads)
);				 

endmodule