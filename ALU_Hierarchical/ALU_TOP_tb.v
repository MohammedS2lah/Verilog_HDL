//time_unit = 10us & time percision = 10ns
`timescale 10us/10ns

//Testbench has no inputs or outputs
module ALU_TOP_tb #(parameter in_width = 8, out_width = 16);
  
  //Declaring testbench signals
  reg [ in_width - 1 :0] A_tb, B_tb;
  reg [3:0] ALU_FUN_tb;
  reg RST_tb;
  reg clk_tb;
  wire [out_width - 1 : 0] Arith_OUT_tb, Logic_OUT_tb, CMP_OUT_tb, SHIFT_OUT_tb;
  wire Carry_OUT_tb, Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, SHIFT_Flag_tb; 
  
  //DUT instantiation
  ALU_TOP DUT(
  .A(A_tb),
  .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .RST(RST_tb),
  .CLK(clk_tb),
  .Arith_OUT(Arith_OUT_tb),
  .Logic_OUT(Logic_OUT_tb),
  .CMP_OUT(CMP_OUT_tb),
  .SHIFT_OUT(SHIFT_OUT_tb),
  .Carry_OUT(Carry_OUT_tb),
  .Arith_Flag(Arith_Flag_tb),
  .Logic_Flag(Logic_Flag_tb),
  .CMP_Flag(CMP_Flag_tb),
  .SHIFT_Flag(SHIFT_Flag_tb)
  );
  
  
  //Clock generator with duty cycle 40% low and 60% high
  
  parameter DUTY_CYCLE = 60.0; 
  parameter PERIOD_WIDTH = 10.0; 
  parameter PULSE_WIDTH = PERIOD_WIDTH*(DUTY_CYCLE/100.0); 
  parameter NON_ACTIVE_PERIOD_WIDTH = PERIOD_WIDTH - PULSE_WIDTH;
  
  always 
    begin 
	  //Set clock to logic zero 
        clk_tb = 1'b0; 
    //Delay for time computed from parameter below corresponding to when the clock is a logic zero 
        #(NON_ACTIVE_PERIOD_WIDTH); 
		//Set clock to logic one 
        clk_tb = 1'b1; 
		//Delay for time computed from parameter below corresponding to when the clock is a logic one 
        #(PULSE_WIDTH); 
    end


  //Initial block
  initial
  begin
    $dumpfile("ALU_TOP.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    RST_tb = 1'b0;
    ALU_FUN_tb = 4'b0000;
    A_tb = 15;
    B_tb = 30;
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    RST_tb = 1'b1;
    
    #8
    if(Arith_OUT_tb != 45  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    ALU_FUN_tb = 4'b0001;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 35  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    
    //TEST CASE 3
    $display ("TEST CASE 3");
    #3
    RST_tb = 1'b0;
    ALU_FUN_tb = 4'b0010;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 0  & Arith_Flag_tb != 0 & Carry_OUT_tb != 0 & Logic_OUT_tb != 0 & CMP_OUT_tb != 0 & SHIFT_OUT_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb != 0 & SHIFT_Flag_tb != 0)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
    
    
    //TEST CASE 4
    $display ("TEST CASE 4");
    #3
    RST_tb = 1'b1;
    ALU_FUN_tb = 4'b0010;
    A_tb = 50;
    B_tb = 15;
    
    #9
    if(Arith_OUT_tb != 750  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
    
    
    //TEST CASE 5
    $display ("TEST CASE 5");
    #3
    ALU_FUN_tb = 4'b0011;
    A_tb = 50;
    B_tb = 5;
    
    #8
    if(Arith_OUT_tb != 10  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
    
    
    //TEST CASE 6 Division by zero
    $display ("TEST CASE 6");
    #3
    ALU_FUN_tb = 4'b0011;
    A_tb = 50;
    B_tb = 0;
    
    #8
    if(Arith_OUT_tb != 65535  & Arith_Flag_tb != 1 & Carry_OUT_tb != 1 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
    
    
    //TEST CASE 7 
    $display ("TEST CASE 7");
    #3
    ALU_FUN_tb = 4'b0000;
    A_tb = 255;
    B_tb = 0;
    
    #8
    if(Arith_OUT_tb != 255  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
      
    
    //TEST CASE 8 
    $display ("TEST CASE 8");
    #3
    ALU_FUN_tb = 4'b0010;
    A_tb = 255;
    B_tb = 255;
    
    #8
    if(Arith_OUT_tb != 65025  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0 & Logic_Flag_tb !=0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 8 IS FAILED");
    
    else $display ("TEST CASE 8 IS PASSED"); 
    
    
    //TEST CASE 9
    $display ("TEST CASE 9");
    #3
    ALU_FUN_tb = 4'b0100;
    A_tb = 15;
    B_tb = 30;
    
    #8
    if(Logic_OUT_tb != 14  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 9 IS FAILED");
    
    else $display ("TEST CASE 9 IS PASSED");
    
    
    //TEST CASE 10
    $display ("TEST CASE 10");
    #3
    ALU_FUN_tb = 4'b0101;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Logic_OUT_tb != 63  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 10 IS FAILED");
    
    else $display ("TEST CASE 10 IS PASSED");
    
    
    //TEST CASE 11
    $display ("TEST CASE 11");
    #3
    RST_tb = 1'b0;
    ALU_FUN_tb = 4'b0110;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 0  & Arith_Flag_tb != 0 & Carry_OUT_tb != 0 & Logic_OUT_tb != 0 & CMP_OUT_tb != 0 & SHIFT_OUT_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb != 0 & SHIFT_Flag_tb != 0)
      $display ("TEST CASE 11 IS FAILED");
    
    else $display ("TEST CASE 11 IS PASSED");
    
    
    //TEST CASE 12
    $display ("TEST CASE 12");
    #3
    RST_tb = 1'b1;
    ALU_FUN_tb = 4'b0110;
    A_tb = 50;
    B_tb = 15;
    
    #12
    if(Logic_OUT_tb != -3  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 12 IS FAILED");
    
    else $display ("TEST CASE 12 IS PASSED");
    
    
    //TEST CASE 13
    $display ("TEST CASE 13");
    #3
    ALU_FUN_tb = 4'b0111;
    A_tb = 50;
    B_tb = 5;
    
    #8
    if(Logic_OUT_tb != -56  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 13 IS FAILED");
    
    else $display ("TEST CASE 13 IS PASSED");
    
    
    //TEST CASE 14 
    $display ("TEST CASE 14");
    #3
    ALU_FUN_tb = 4'b0111;
    A_tb = 50;
    B_tb = 0;
    
    #8
    if(Logic_OUT_tb != -51  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 14 IS FAILED");
    
    else $display ("TEST CASE 14 IS PASSED");
    
    
    //TEST CASE 15 
    $display ("TEST CASE 15");
    #3
    ALU_FUN_tb = 4'b0100;
    A_tb = 255;
    B_tb = 0;
    
    #8
    if(Logic_OUT_tb != 0  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 15 IS FAILED");
    
    else $display ("TEST CASE 15 IS PASSED");
      
    
    //TEST CASE 16 
    $display ("TEST CASE 16");
    #3
    ALU_FUN_tb = 4'b0110;
    A_tb = 255;
    B_tb = 255;
    
    #8
    if(Logic_OUT_tb != -256  & Logic_Flag_tb != 1 & Arith_Flag_tb != 0 & CMP_Flag_tb !=0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 16 IS FAILED");
    
    else $display ("TEST CASE 16 IS PASSED");  


    //TEST CASE 17
    $display ("TEST CASE 17");
    #3
    ALU_FUN_tb = 4'b1000;
    A_tb = 15;
    B_tb = 30;

    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 17 IS FAILED");
    
    else $display ("TEST CASE 17 IS PASSED");
    
    
    //TEST CASE 18
    $display ("TEST CASE 18");
    #3
    ALU_FUN_tb = 4'b1001;
    A_tb = 50;
    B_tb = 50;
    
    #8
    if(CMP_OUT_tb != 1  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 18 IS FAILED");
    
    else $display ("TEST CASE 18 IS PASSED");
    
    
    //TEST CASE 19
    $display ("TEST CASE 19");
    #3
    RST_tb = 1'b0;
    ALU_FUN_tb = 2'b10;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 0  & Arith_Flag_tb != 0 & Carry_OUT_tb != 0 & Logic_OUT_tb != 0 & CMP_OUT_tb != 0 & SHIFT_OUT_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb != 0 & SHIFT_Flag_tb != 0)
      $display ("TEST CASE 19 IS FAILED");
    
    else $display ("TEST CASE 19 IS PASSED");
    
    
    //TEST CASE 20
    $display ("TEST CASE 20");
    #3
    RST_tb = 1'b1;
    ALU_FUN_tb = 4'b1010;
    A_tb = 50;
    B_tb = 15;
    
    #12
    if(CMP_OUT_tb != 2  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 20 IS FAILED");
    
    else $display ("TEST CASE 20 IS PASSED");
    
    
    //TEST CASE 21
    $display ("TEST CASE 21");
    #3
    ALU_FUN_tb = 4'b1011;
    A_tb = 50;
    B_tb = 5;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 21 IS FAILED");
    
    else $display ("TEST CASE 21 IS PASSED");
    
    
    //TEST CASE 22 
    $display ("TEST CASE 22");
    #3
    ALU_FUN_tb = 4'b1011;
    A_tb = 10;
    B_tb = 50;
    
    #8
    if(CMP_OUT_tb != 3  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 22 IS FAILED");
    
    else $display ("TEST CASE 22 IS PASSED");
    
    
    //TEST CASE 23 
    $display ("TEST CASE 23");
    #3
    ALU_FUN_tb = 4'b1001;
    A_tb = 25;
    B_tb = 23;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 23 IS FAILED");
    
    else $display ("TEST CASE 23 IS PASSED");
      
    
    //TEST CASE 24 
    $display ("TEST CASE 24");
    #3
    ALU_FUN_tb = 4'b1010;
    A_tb = 240;
    B_tb = 245;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & SHIFT_Flag_tb !=0)
      $display ("TEST CASE 24 IS FAILED");
    
    else $display ("TEST CASE 24 IS PASSED");
    
    
    //TEST CASE 25
    $display ("TEST CASE 25");
    #3
    ALU_FUN_tb = 4'b1100;
    A_tb = 40;
    B_tb = 30;
    
    
    #12
    if(SHIFT_OUT_tb != 20  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 25 IS FAILED");
    
    else $display ("TEST CASE 25 IS PASSED");
    
    
    //TEST CASE 26
    $display ("TEST CASE 26");
    #3
    ALU_FUN_tb = 4'b1101;
    A_tb = 50;
    
    #8
    if(SHIFT_OUT_tb != 100  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 26 IS FAILED");
    
    else $display ("TEST CASE 26 IS PASSED");
    
    
    //TEST CASE 27
    $display ("TEST CASE 27");
    #3
    RST_tb = 1'b0;
    ALU_FUN_tb = 2'b10;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 0  & Arith_Flag_tb != 0 & Carry_OUT_tb != 0 & Logic_OUT_tb != 0 & CMP_OUT_tb != 0 & SHIFT_OUT_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb != 0 & SHIFT_Flag_tb != 0)
      $display ("TEST CASE 27 IS FAILED");
    
    else $display ("TEST CASE 27 IS PASSED");
    
    
    //TEST CASE 28
    $display ("TEST CASE 28");
    #3
    RST_tb = 1'b1;
    ALU_FUN_tb = 4'b1110;
    B_tb = 80;
    
    #9
    if(SHIFT_OUT_tb != 40  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 28 IS FAILED");
    
    else $display ("TEST CASE 28 IS PASSED");
    
    
    //TEST CASE 29
    $display ("TEST CASE 29");
    #3
    ALU_FUN_tb = 4'b1111;
    B_tb = 5;
    
    #8
    if(SHIFT_OUT_tb != 10  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 29 IS FAILED");
    
    else $display ("TEST CASE 29 IS PASSED");
    
    
    //TEST CASE 30 
    $display ("TEST CASE 30");
    #3
    ALU_FUN_tb = 4'b1111;
    B_tb = 255;
    
    #8
    if(SHIFT_OUT_tb != -2  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 30 IS FAILED");
    
    else $display ("TEST CASE 30 IS PASSED");
    
    
    //TEST CASE 31 
    $display ("TEST CASE 31");
    #3
    ALU_FUN_tb = 4'b1101;
    A_tb = 255;
    
    #8
    if(SHIFT_OUT_tb != -2  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 31 IS FAILED");
    
    else $display ("TEST CASE 31 IS PASSED");
      
    
    //TEST CASE 32 
    $display ("TEST CASE 32");
    #3
    ALU_FUN_tb = 4'b1100;
    A_tb = 255;
    
    #8
    if(SHIFT_OUT_tb != 127  & SHIFT_Flag_tb != 1 & Arith_Flag_tb != 0 & Logic_Flag_tb != 0 & CMP_Flag_tb !=0)
      $display ("TEST CASE 32 IS FAILED");
    
    else $display ("TEST CASE 32 IS PASSED");   
      
    #10
    $stop; //finished with simulation  
    
  end
  
endmodule