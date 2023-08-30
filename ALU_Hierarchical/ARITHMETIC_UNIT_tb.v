//time_unit = 10us & time percision = 10ns
`timescale 10us/10ns

//Testbench has no inputs or outputs
module ARITHMETIC_UNIT_tb #(parameter in_width = 8, out_width = 16);
  
  //Declaring testbench signals
  reg [ in_width - 1 :0] A_tb, B_tb;
  reg [1:0] ALU_FUN_tb;
  reg Arith_Enable_tb;
  reg RST_tb;
  reg clk_tb;
  wire [out_width - 1 : 0] Arith_OUT_tb;
  wire Carry_OUT_tb, Arith_Flag_tb; 
  
  //DUT instantiation
  ARITHMETIC_UNIT DUT(
  .A(A_tb),
  .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .Arith_Enable(Arith_Enable_tb),
  .RST(RST_tb),
  .clk(clk_tb),
  .Arith_OUT(Arith_OUT_tb),
  .Carry_OUT(Carry_OUT_tb),
  .Arith_Flag(Arith_Flag_tb)
  );
  
  
  //Clock generator with duty cycle 40% low and 60% high
  initial
    begin
      clk_tb = 1'b1;
      forever #5 clk_tb = ~clk_tb;  // toggle the clock every 5 ns
    end

  // create a 40% duty cycle clock by adding a delay to the low and high periods
  always @(posedge clk_tb)
    if (clk_tb == 1'b1) #3 clk_tb <= 1'b0;
    else #5 clk_tb <= 1'b1;



  //Initial block
  initial
  begin
    $dumpfile("ARITHMETIC_UNIT.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    RST_tb = 1'b0;
    ALU_FUN_tb = 2'b00;
    Arith_Enable_tb = 1'b0;
    A_tb = 15;
    B_tb = 30;
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    Arith_Enable_tb = 1'b1;
    RST_tb = 1'b1;
    
    #8
    if(Arith_OUT_tb != 45  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    ALU_FUN_tb = 2'b01;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 35  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    
    //TEST CASE 3
    $display ("TEST CASE 3");
    #3
    RST_tb = 1'b0;
    ALU_FUN_tb = 2'b10;
    A_tb = 50;
    B_tb = 15;
    
    #8
    if(Arith_OUT_tb != 0  & Arith_Flag_tb != 0 & Carry_OUT_tb != 0)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
    
    
    //TEST CASE 4
    $display ("TEST CASE 4");
    #3
    RST_tb = 1'b1;
    ALU_FUN_tb = 2'b10;
    A_tb = 50;
    B_tb = 15;
    
    #9
    if(Arith_OUT_tb != 750  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
    
    
    //TEST CASE 5
    $display ("TEST CASE 5");
    #3
    ALU_FUN_tb = 2'b11;
    A_tb = 50;
    B_tb = 5;
    
    #8
    if(Arith_OUT_tb != 10  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
    
    
    //TEST CASE 6 Division by zero
    $display ("TEST CASE 6");
    #3
    ALU_FUN_tb = 2'b11;
    A_tb = 50;
    B_tb = 0;
    
    #8
    if(Arith_OUT_tb != 65535  & Arith_Flag_tb != 1 & Carry_OUT_tb != 1)
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
    
    
    //TEST CASE 7 
    $display ("TEST CASE 7");
    #3
    ALU_FUN_tb = 2'b00;
    A_tb = 255;
    B_tb = 0;
    
    #24
    if(Arith_OUT_tb != 255  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
      
    
    //TEST CASE 8 
    $display ("TEST CASE 8");
    #3
    ALU_FUN_tb = 2'b10;
    A_tb = 255;
    B_tb = 255;
    
    #24
    if(Arith_OUT_tb != 65025  & Arith_Flag_tb != 1 & Carry_OUT_tb != 0)
      $display ("TEST CASE 8 IS FAILED");
    
    else $display ("TEST CASE 8 IS PASSED");  
      
    #20
    $stop; //finished with simulation  
    
  end
  
endmodule