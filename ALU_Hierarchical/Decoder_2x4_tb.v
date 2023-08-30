//time_unit = 10us & time percision = 10ns
`timescale 10us/10ns

//Testbench has no inputs or outputs
module Decoder_2x4_tb;
  
  //Declaring testbench signals
  reg [1:0] ALU_FUN_tb;
  wire [3:0] y_tb; 
  
  //DUT instantiation
  Decoder_2x4 DUT(
  .ALU_FUN(ALU_FUN_tb),
  .y(y_tb)
  );
  
  
  //Clock generator with duty cycle 40% low and 60% high
  reg clk_tb;
  initial
    begin
      clk_tb = 1'b1;
      forever #5 clk_tb = ~clk_tb;  // toggle the clock every 5 us
    end

  // create a 40% duty cycle clock by adding a delay to the low and high periods
  always @(posedge clk_tb)
    if (clk_tb == 1'b1) #3 clk_tb <= 1'b0;
    else #5 clk_tb <= 1'b1;



  //Initial block
  initial
  begin
    $dumpfile("Decoder_2x4.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    ALU_FUN_tb = 2'b00;
    
    #8
    if(y_tb != 4'b1000)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    ALU_FUN_tb = 2'b01;
    
    #8
    if(y_tb != 4'b0100)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    
    //TEST CASE 3
    $display ("TEST CASE 3");
    #3
    ALU_FUN_tb = 2'b10;
    
    #8
    if(y_tb != 4'b0010)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
    
    
    //TEST CASE 4
    $display ("TEST CASE 4");
    #3
    ALU_FUN_tb = 2'b11;
    
    #9
    if(y_tb != 4'b0001)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
     
      
    #10
    $stop; //finished with simulation  
    
  end
  
endmodule