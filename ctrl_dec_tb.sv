import definitions::*;
module ctrl_dec_tb();

logic [2:0] op;
logic str;
logic ldr; 
logic rf_we;

ctrl_dec ctrl_dec_test(op, str, ldr, rf_we);

initial begin
	// Test ADD
	#10ns
	op = kADD;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test AND
	#10ns
	op = kAND;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test XOR
	#10ns
	op = kXOR;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test LSH
	#10ns
	op = kLSH;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test LDI
	#10ns
	op = kLDI;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test STR
	#10ns
	op = kSTR;
	$display("str is %b should be 1, ldr is %b should be 0, rf_we is %b should be 0, str", str, ldr, rf_we);
	#10ns
	
	// Test LDM
	#10ns
	op = kLDM;
	$display("str is %b should be 0, ldr is %b should be 1, rf_we is %b should be 1, str", str, ldr, rf_we);
	#10ns
	
	// Test BNE
	#10ns
	op = kBNE;
	$display("str is %b should be 0, ldr is %b should be 0, rf_we is %b should be 0, str", str, ldr, rf_we);
	#10ns
	
	$stop;
end
endmodule 