//This file defines the parameters used in the alu
// CSE141L Win 2018 in-class demo
package definitions;
    
// Instruction map
    const logic [2:0]kAND  = 3'b000;      // rs = rs & rt (bitwise)
    const logic [2:0]kADD  = 3'b001;	  // rs = rs + rt
    const logic [2:0]kXOR  = 3'b010;	  // rs = rs ^ rt
    const logic [2:0]kLSH  = 3'b011;	  // rs = rs << (imm + 1) or rs = rs >> (imm + 1)
    const logic [2:0]kLDI  = 3'b100;	  // ld = imm (0-64)
	const logic [2:0]kLDM  = 3'b101;	  // rs = [rt]
	const logic [2:0]kSTR  = 3'b110;	  // [rt] = rs
	const logic [2:0]kBNE  = 3'b111;	  // rs == rt ? pc += 4 : pc = 4 + br
// enum names will appear in timing diagram
    typedef enum logic[2:0] {			  // mnemonic equivs of the above
        AND, ADD, XOR, LSH, LDI, LDM, STR, BNE // strictly for user convnience in timing diagram
         } op_mne;
    
endpackage // definitions
