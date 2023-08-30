//time_unit = 1ns & time percision = 1ps
`timescale 10us/10ns

//Testbench has no inputs or outputs
module ALU_16bit_tb;
  
  //Declaring testbench signals
  reg [15:0] A_tb,B_tb;
  reg [3:0] ALU_FUN_tb;
  reg clk_tb;
  wire [15:0] ALU_OUT_tb;
  wire Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb;
  
  //DUT instantiation
  ALU_16bit DUT(
  .A(A_tb),
  .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .clk(clk_tb),
  .ALU_OUT(ALU_OUT_tb),
  .Arith_flag(Arith_flag_tb),
  .Logic_flag(Logic_flag_tb),
  .CMP_flag(CMP_flag_tb),
  .Shift_flag(Shift_flag_tb)
  );
  
  //Clock generator
  always #5 clk_tb = !clk_tb;
  
  //Initial block
  initial
  begin
    $dumpfile("ALU_16bit.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    
    //TEST CASE 1 for addition
    $display ("TEST CASE 1");
    #3
    A_tb = 20; 
    B_tb = 30;
    ALU_FUN_tb = 4'b0000;
    
    #8
    if(ALU_OUT_tb != 50 & Arith_flag_tb != 1'b1)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    //TEST CASE 2 for subtraction
    $display ("TEST CASE 2");
    #3
    A_tb = 40; 
    B_tb = 20;
    ALU_FUN_tb = 4'b0001;
    
    #8
    if(ALU_OUT_tb != 20 & Arith_flag_tb != 1'b1)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    //TEST CASE 3 for multiplication
    $display ("TEST CASE 3");
    #3
    A_tb = 0; 
    B_tb = 20;
    ALU_FUN_tb = 4'b0010;
    
    #8
    if(ALU_OUT_tb != 0 & Arith_flag_tb != 1'b1)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
    
    //TEST CASE 4 for multiplication
    $display ("TEST CASE 4");
    #3
    A_tb = 3; 
    B_tb = 20;
    ALU_FUN_tb = 4'b0010;
    
    #8
    if(ALU_OUT_tb != 60 & Arith_flag_tb != 1'b1)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
    
    //TEST CASE 5 for division
    $display ("TEST CASE 5");
    #3
    A_tb = 80; 
    B_tb = 4;
    ALU_FUN_tb = 4'b0011;
    
    #8
    if(ALU_OUT_tb != 20 & Arith_flag_tb != 1'b1)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
    
    //TEST CASE 6 for AND
    $display ("TEST CASE 6");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b0100;
    
    #8
    if(ALU_OUT_tb != 32 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
    
    //TEST CASE 7 for OR
    $display ("TEST CASE 7");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b0101;
    
    #8
    if(ALU_OUT_tb != 118 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
      
    //TEST CASE 8 for NAND
    $display ("TEST CASE 8");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b0110;
    
    #8
    if(ALU_OUT_tb != 65503 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 8 IS FAILED");
    
    else $display ("TEST CASE 8 IS PASSED");
    
    //TEST CASE 9 for NOR
    $display ("TEST CASE 9");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b0111;
    
    #8
    if(ALU_OUT_tb != 65417 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 9 IS FAILED");
    
    else $display ("TEST CASE 9 IS PASSED");
      
    //TEST CASE 10 for XOR
    $display ("TEST CASE 10");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1000;
    
    #8
    if(ALU_OUT_tb != 86 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 10 IS FAILED");
    
    else $display ("TEST CASE 10 IS PASSED");  
    
    //TEST CASE 11 for XNOR
    $display ("TEST CASE 11");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1001;
    
    #8
    if(ALU_OUT_tb != 65449 & Logic_flag_tb != 1'b1)
      $display ("TEST CASE 11 IS FAILED");
    
    else $display ("TEST CASE 11 IS PASSED"); 
    
    //TEST CASE 12 for equality
    $display ("TEST CASE 12");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1010;
    
    #8
    if(ALU_OUT_tb != 0 & CMP_flag_tb != 1'b1)
      $display ("TEST CASE 12 IS FAILED");
    
    else $display ("TEST CASE 12 IS PASSED"); 
    
    //TEST CASE 13 for equality
    $display ("TEST CASE 13");
    #3
    A_tb = 100; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1010;
    
    #8
    if(ALU_OUT_tb != 1 & CMP_flag_tb != 1'b1)
      $display ("TEST CASE 13 IS FAILED");
    
    else $display ("TEST CASE 13 IS PASSED"); 
      
    //TEST CASE 14 for greater than
    $display ("TEST CASE 14");
    #3
    A_tb = 100; 
    B_tb = 50;
    ALU_FUN_tb = 4'b1011;
    
    #8
    if(ALU_OUT_tb != 2 & CMP_flag_tb != 1'b1)
      $display ("TEST CASE 14 IS FAILED");
    
    else $display ("TEST CASE 14 IS PASSED"); 
    
    //TEST CASE 15 for less than
    $display ("TEST CASE 15");
    #3
    A_tb = 100; 
    B_tb = 50;
    ALU_FUN_tb = 4'b1100;
    
    #8
    if(ALU_OUT_tb != 0 & CMP_flag_tb != 1'b1)
      $display ("TEST CASE 15 IS FAILED");
    
    else $display ("TEST CASE 15 IS PASSED");
    
    //TEST CASE 16 for less than
    $display ("TEST CASE 16");
    #3
    A_tb = 50; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1100;
    
    #8
    if(ALU_OUT_tb != 3 & CMP_flag_tb != 1'b1)
      $display ("TEST CASE 16 IS FAILED");
    
    else $display ("TEST CASE 16 IS PASSED");
    
    //TEST CASE 17 for shift right
    $display ("TEST CASE 17");
    #3
    A_tb = 100; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1101;
    
    #8
    if(ALU_OUT_tb != 50 & Shift_flag_tb != 1'b1)
      $display ("TEST CASE 17 IS FAILED");
    
    else $display ("TEST CASE 17 IS PASSED");
    
    //TEST CASE 18 for shift left
    $display ("TEST CASE 18");
    #3
    A_tb = 100; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1110;
    
    #8
    if(ALU_OUT_tb != 200 & Shift_flag_tb != 1'b1)
      $display ("TEST CASE 18 IS FAILED");
    
    else $display ("TEST CASE 18 IS PASSED");
    
    //TEST CASE 19 for shift left
    $display ("TEST CASE 19");
    #3
    A_tb = 100; 
    B_tb = 100;
    ALU_FUN_tb = 4'b1111;
    
    #8
    if(ALU_OUT_tb != 16'b0)
      $display ("TEST CASE 19 IS FAILED");
    
    else $display ("TEST CASE 19 IS PASSED");
    
    #10
    $stop; //finished with simulation
    
  end  
endmodule  
