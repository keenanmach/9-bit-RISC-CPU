import definitions::*;
module alu_tb();

logic		  rsh;			// Right shift is this bit is 1 left shift if 0
logic      ci;			    // carry in
logic[2:0] op;			    // opcode
logic[7:0] in_a;		    // operands in
logic[7:0] in_b;
logic[7:0] rslt;		    // result out
logic      co;		    // carry out
logic      z; 		    // zero flag, like ARM Z flag
  
alu alu_test (rsh, ci, op, in_a, in_b,rslt,co,z);

reg [8*8-1:0] mytextsignal;
always@(op) begin 
    case(op) 
        kADD : mytextsignal = "ADD";
        kAND: mytextsignal = "AND";
        kXOR :  mytextsignal = "XOR";
        kLSH: mytextsignal = "LSH";
        kSTR : mytextsignal = "STR";
        kLDI : mytextsignal = "LDI"; 
        kBNE : mytextsignal = "BNE";
        default: mytextsignal = "NON_ALU ";
     endcase
 end

initial begin

	// Test ADD
    #10ns
	 op = kADD;
	 ci = 0;
    in_a = 8'd23;
	 in_b = 8'd22;
    #10ns
    $display("result is %d, should be 45", rslt);
	 
	 
	 // Test ADD
    #10ns
 	 op = kADD;
	 ci = 0;
    in_a = 8'd5;
	 in_b = -8'd2;
    #10ns
    $display("result is %d, should be 3", rslt);

	 
	 // Test ADD
    #10ns
	 op = kADD;
	 ci = 0;
    in_a = 8'd255;
	 in_b = 8'd4;
    #10ns
    $display("result is %d, should be 3", rslt);
	 
	
	// Test AND
	#10ns
    op = kAND;
    in_a = 8'd255;
	 in_b = 8'd0;
    #10ns
    $display("result is %b, should be 0", rslt);
	 
    // Test AND
	#10ns
    op = kAND;
    in_a = 8'b01010101;
	 in_b = 8'b10101010;
    #10ns
    $display("result is %b, should be 0b00000000", rslt);

	// Test AND
	#10ns
    op = kAND;
    in_a = 8'b01010101;
	 in_b = 8'b01010101;
    #10ns
    $display("result is %b, should be 0b01010101", rslt);
	 
	// Test XOR
	#10ns
    op = kXOR;
    in_a = 8'b01010101;
	 in_b = 8'b01010101;
    #10ns
    $display("result is %b, should be 0b00000000", rslt);
	 
	 
	 // Test XOR
	#10ns
    op = kXOR;
    in_a = 8'b01010101;
	 in_b = 8'b00000000;
    #10ns
    $display("result is %b, should be 0b01010101", rslt);


	 // Test LSH
	#10ns
	 rsh = 0;
    op = kLSH;
    in_a = 8'd16;
	 in_b = 8'd2;
	 
    #10ns
    $display("result is %d, should be 64", rslt);


	 // Test LSH
	#10ns
	 rsh = 1;
    op = kLSH;
    in_a = 8'd16;
	 in_b = 8'd2;
	 
    #10ns
    $display("result is %d, should be 4", rslt);
	 
	 
	// Test STR
	#10ns
    op = kSTR;
    in_a = 8'd16;
	 in_b = 8'd2;
	 
    #10ns
    $display("result is %d, should be 16", rslt);
	 
	 
	 
	 // Test LDI
	#10ns
    op = kLDI;
    in_a = 8'd16;
	 in_b = 8'd63;
	 
    #10ns
    $display("result is %d, should be 63", rslt);
	
	// Test BNE
	#10ns
	op = kBNE;
	in_a = 8'd56;
	in_b = 8'd56;
	#10ns
	$display("z is %b, should be 1", z);

	// Test BNE
	#10ns
   op = kBNE;
	in_a = 8'd58;
	in_b = 8'd56;
	#10ns
	$display("z is %b, should be 0", z);
	
	

	$stop;

end
endmodule // alu_tb
