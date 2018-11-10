// CSE141L Winter 2018 in-class demo
// decoder block activates load and store instruction wires by
//  decoding them from opcode
import definitions::*;
module ctrl_dec(
  input[2:0] op,
  output logic str,
               ldr,
					rf_we
);

  always_comb str = op==kSTR;   // iff kSTR selected, str goes high
  always_comb ldr = op==kLDM;
  always_comb case (op)
    default: rf_we = 1;
    kBNE, kSTR: rf_we = 0;
  endcase
	
// all other opcode cases: str=ldr=0

endmodule
  
