// Lab4_tb
// testbench for programmable message encryption
// CSE141L  Fall 2018
// runs program 1 (encrypt a message)
module encrypt_tb ()            ;
  logic      clk            ,  // advances simulation step-by-step
             init           ;  // init (reset, start) command to DUT
  wire       done           ;  // done flag returned by DUT
  logic[7:0] message1[55]   ,  // first program 1 original message, in binary
             pre_length[4]  ,  // space char. bytes before first character in message
             lfsr_ptrn[4]   ,  // one of 8 maximal length 8-tap shift reg. ptrns
             lfsr1[64]      ,  // states of program 1 encrypting LFSR
             msg_padded1[64],  // original message, plus pre- and post-padding w/ ASCII spaces
             msg_crypto1[64],  // encrypted message according to the DUT
             LFSR_ptrn[8]   ,  // 8 possible maximal-length 8-bit LFSR tap ptrns
             LFSR_init[4]   ,  // four of 255 possible NONZERO starting states
			 spaces = 0     ;  // counts leading spaces for Program 3
// our original American Standard Code for Information Interchange message follows
// note in practice your design should be able to handle ANY ASCII string
  string     str1  = "Mr. Watson, come here. I want to see you.";     // program 1 input
//  string     str1  = " Knowledge comes, but wisdom lingers.    ";   // alternative inputs
//  string     str1  = "  01234546789abcdefghijklmnopqrstuvwxyz. ";   //   (make up your own,
//  string     str1  = "  f       A joke is a very serious thing.";   // 	as well)
//  string     str1  = "                           Ajok          ";   // 
//  string     str1  = " Knowledge comes, but wisdom lingers.    ";   // 

// displayed encrypted string will go here:
  string     str_enc1[64];       // program 1 desired output
  int strlen; 
  // the 8 possible maximal-length feedback tap patterns from which to choose
  assign LFSR_ptrn[0] = 8'he1;
  assign LFSR_ptrn[1] = 8'hd4;
  assign LFSR_ptrn[2] = 8'hc6;
  assign LFSR_ptrn[3] = 8'hb8;
  assign LFSR_ptrn[4] = 8'hb4;
  assign LFSR_ptrn[5] = 8'hb2;
  assign LFSR_ptrn[6] = 8'hfa;
  assign LFSR_ptrn[7] = 8'hf3;

  // different starting LFSR state for each program -- logical OR guarantees nonzero
  assign LFSR_init[0] = $random | 8'h40;  // for program 1 run

  // set preamble lengths for the four program runs (always > 8)
  assign pre_length[0] = 9 ;  // program 1 run

// ***** instantiate your own top level design here *****
  top dut(
    .clk     (clk),	   // use your own port names, if different
    .reset    (init),   // some prefer to call this ".reset"
    .done    (done)
  );

  initial begin
//***** pre-load your instruction ROM here	*****
// you may also pre-load desired constants, etc. into
//   your data_mem here -- the upper half is reserved for your use
//    $readmemb("encoder.bin", dut.instr_rom.rom);
//    dut.data_mem1.my_memory[128]=8'hfe;   //whatever constants you want	
	strlen = str1.len();//str1);  // length of string 1 (# characters between " ")
    clk  = 0;            // initialize clock
    init = 1;            // activate reset

// program 1 -- precompute encrypted message
    lfsr_ptrn[0] = LFSR_ptrn[1];  // select one of 8 permitted
    lfsr1[0]     = LFSR_init[0];  // any nonzero value (zero may be helpful for debug)
    $display("run encryption program");
    $display("%s",str1);          // print original message in transcript window
    $display("LFSR_ptrn = %h, LFSR_init = %h",lfsr_ptrn[0],lfsr1[0]);

    for(int j=0; j<64; j++)       // pre-fill message_padded with ASCII space characters
      msg_padded1[j] = 8'h20;
    for(int l=0; l<strlen; l++)       // overwrite up to 55 of these spaces w/ message itself
      msg_padded1[pre_length[0]+l] = str1[l];

// compute the LFSR sequence
    for (int ii=0;ii<63;ii++)
      lfsr1[ii+1] = (lfsr1[ii]<<1)+(^(lfsr1[ii]&lfsr_ptrn[0]));

// encrypt the message, testbench will change on falling clocks
    for (int i=0; i<64; i++) begin
      msg_crypto1[i]        = msg_padded1[i] ^ lfsr1[i];
      str_enc1[i]           = string'(msg_crypto1[i]);
    end

    for(int jj=0; jj<64; jj++)
      $write("%s",str_enc1[jj]);
    $display("\n");

// run encryption program
// ***** load operands into your data memory *****
// ***** use your instance name for data memory and its internal core *****
    for(int m=0; m<61; m++)
	  dut.data_mem1.my_memory[m] = 8'h20;         // pad memory w/ ASCII space characters
    for(int m=0; m<strlen; m++)
      dut.data_mem1.my_memory[m] = str1[m];       // overwrite/copy original string into device's data memory[0:strlen-1]
    dut.data_mem1.my_memory[61] = pre_length[0];  // number of bytes preceding message
    dut.data_mem1.my_memory[62] = lfsr_ptrn[0];   // LFSR feedback tap positions (8 possible ptrns)
    dut.data_mem1.my_memory[63] = LFSR_init[0];   // LFSR starting state (nonzero)
// load constants, including LUTs, for program 1 here
    $display("lfsr_init[0]=%h,dut.data_mem1.my_memory[43]=%h",LFSR_init[0],dut.data_mem1.my_memory[43]);
    // $display("%d  %h  %h  %h  %s",i,message[i],msg_padded[i],msg_crypto[i],str[i]);
    #20ns init = 0;
    #60ns;                                // wait for 6 clock cycles of nominal 10ns each
    wait(done);                           // wait for DUT's done flag to go high
    #10ns $display();
    $display("program 1:");
// ***** reads your results and compares to test bench
// ***** use your instance name for data memory and its internal core *****
    for(int n=0; n<64; n++)
	  if(msg_crypto1[n]!=dut.data_mem1.my_memory[n+64])
        $display("%d bench msg: %s %h dut msg: %h  OOPS!",
          n, msg_crypto1[n], msg_crypto1[n], dut.data_mem1.my_memory[n+64]);
      else
        $display("%d bench msg: %s %h dut msg: %h",
          n, msg_crypto1[n], msg_crypto1[n], dut.data_mem1.my_memory[n+64]);

    #20ns $stop;
  end

always begin     // continuous loop
  #5ns clk = 1;  // clock tick
  #5ns clk = 0;  // clock tock
end

endmodule