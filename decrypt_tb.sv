// Lab4_tb	  
// testbench for programmable message encryption
// CSE141L  Fall 2018    
//  run program 2 (decrypt fourth message)
module Lab4_tb                  ;
  logic      clk                ;		  // advances simulation step-by-step
  logic      init               ;         // init (reset, start) command to DUT
  wire       done               ;         // done flag returned by DUT
  logic[7:0] message1[55]       ,		  // first program 1 original message, in binary
             message2[55]       ,		  // program 2 decrypted message
			 message3[55]       ,         // second program 1 original message
			 message4[55]       ,         // program 3 decrypted message
			 pre_length[4]      ,         // bytes before first character in message
			 lfsr_ptrn[4]       ,         // one of 8 maximal length 8-tap shift reg. ptrns
			 lfsr4[64]          ,         // states of program 4 decrypting LFSR         
             msg_padded4[64]    ,		  // original message, plus pre- and post-padding
             msg_crypto4[64]    ,         // encrypted message according to the DUT
			 LFSR_ptrn[8]       ,		  // 8 possible maximal-length 8-bit LFSR tap ptrns
			 LFSR_init[4]       ;		  // four of 255 possible NONZERO starting states		   
//  logic[15:0] i   = 0           ;		  // index counter -- increments on each clock cycle
// our original American Standard Code for Information Interchange message follows
// note in practice your design should be able to handle ANY ASCII string
//  string     str1  = "Mr. Watson, come here. I want to see you.";	// 1st program 1 input
  string     str4  = "Knowledge comes, but wisdom lingers.     ";	// program 2 output
//  string     str4  = "  01234546789abcdefghijklmnopqrstuvwxyz. ";	// 2nd program 1 input
//  string     str4  = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";//          A joke is a very serious thing.";	// program 3 output

// displayed encrypted string will go here:
  string     str_enc4[64]   ; 	 // program 3 input

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
  assign LFSR_init[3] = 8'h01;//$random | 8'h08;  // for program 3 run

// set preamble lengths for the four program runs (always > 8)
  assign pre_length[3] = 12         ; 	  // program 3 run

  int lk;								  // counts leading spaces for program 3
  top dut(
    .clk     (clk),	   // use your own port names, if different
    .reset    (init),   // some prefer to call this ".reset"
    .done    (done)
  );          // your top level design goes here 

  initial begin
    for(lk = 0; lk<55; lk++)
	  if(str4[lk]==8'h20) continue;
	  else break; 
//    lk = lk + pre_length[3];
    clk         = 0            ; 		 // initialize clock
    init        = 1            ;		 // activate reset

// put LFSR patterns into memory
  dut.data_mem1.my_memory[55] = LFSR_ptrn[0];
  dut.data_mem1.my_memory[56] = LFSR_ptrn[1];
  dut.data_mem1.my_memory[57] = LFSR_ptrn[2];
  dut.data_mem1.my_memory[58] = LFSR_ptrn[3];
  dut.data_mem1.my_memory[59] = LFSR_ptrn[4];
  dut.data_mem1.my_memory[60] = LFSR_ptrn[5];
  dut.data_mem1.my_memory[61] = LFSR_ptrn[6];
  dut.data_mem1.my_memory[62] = LFSR_ptrn[7];

// program 2 -- precompute encrypted message
	lfsr_ptrn[3] = LFSR_ptrn[0] ;         // select one of 8 permitted
	lfsr4[0]     = $random | 8'h08; // LFSR_init[3];         // any nonzero value (zero may be helpful for debug)
    $display("run program 2");
    $display("%s",str4)        ;         // print original message in transcript window
	$display("lead space count for program 2 = %d",lk);
    $display("LFSR_ptrn = %h, LFSR_init = %h",lfsr_ptrn[3],lfsr4[0]);
    for(int j=0; j<64; j++) 			 // pre-fill message_padded with ASCII space characters
      msg_padded4[j] = 8'h20;         
    for(int l=0; l<55; l++)  			 // overwrite up to 55 of these spaces w/ message itself
	  msg_padded4[pre_length[3]+l] = str4[l]; 
// compute the LFSR sequence
    for (int ii=0;ii<63;ii++) 
      lfsr4[ii+1] = (lfsr4[ii]<<1)+(^(lfsr4[ii]&lfsr_ptrn[3]));//{LFSR[6:0],(^LFSR[5:3]^LFSR[7])};		   // roll the rolling code
// encrypt the message
    for (int i=0; i<64; i++) begin				 // testbench will change on falling clocks
      msg_crypto4[i]        = msg_padded4[i] ^ lfsr4[i];  //{1'b0,LFSR[6:0]};	   // encrypt 7 LSBs
      str_enc4[i]           = string'(msg_crypto4[i]);
    end
// display encrypted message
	for(int jj=0; jj<64; jj++)
      $write("%s",str_enc4[jj]);
	$display();
    for(int jk=0; jk<64; jk++)
      $write("%h ",msg_crypto4[jk]);
	$display("\n");

// run program 2
    init        = 1            ;		 // activate reset
    for(int n=0; n<64; n++)
	  dut.data_mem1.my_memory[n+64] = msg_crypto4[n];
    #20ns init = 0             ;
    #60ns; 	                             // wait for 6 clock cycles of nominal 10ns each
    wait(done);                          // wait for DUT's done flag to go high
    #10ns $display();
    $display("program 2:"); 
    for(int n=0; n<55; n++)
      $display("%d bench msg: %h dut msg: %h",n, str4[n+lk], dut.data_mem1.my_memory[n]);   
    #20ns $stop;
  end

always begin							 // continuous loop
  #5ns clk = 1;							 // clock tick
  #5ns clk = 0;							 // clock tock
end										 // continue

endmodule