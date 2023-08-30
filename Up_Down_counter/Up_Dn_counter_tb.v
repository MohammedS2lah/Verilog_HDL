//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

//Testbench has no inputs or outputs
module Up_Dn_counter_tb;
  
  //Declaring testbench signals
  reg [4:0] in_tb;
  reg load_tb;
  reg up_tb;
  reg down_tb;
  reg clk_tb;
  wire [4:0] counter_tb;
  wire high_tb;
  wire low_tb;
  
  //DUT instantiation
  Up_Dn_counter DUT(
  .in(in_tb),
  .load(load_tb),
  .up(up_tb),
  .down(down_tb),
  .clk(clk_tb),
  .counter(counter_tb),
  .high(high_tb),
  .low(low_tb)
  );
  
  //Clock generator
  always #5 clk_tb = !clk_tb;
  
  //Initial block
  initial
  begin
    $dumpfile("Up_Dn_counter.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    load_tb = 1'b0;
    in_tb = 5'b00101;
    up_tb = 1'b0;
    down_tb = 1'b0;
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    load_tb = 1'b1;
    
    #8
    if(counter_tb != 5'b00101)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    load_tb = 1'b0;
    up_tb = 1'b1;
    down_tb = 1'b1;
    
    #8
    if(counter_tb != 5'b00100)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    
    //TEST CASE 3
    $display ("TEST CASE 3");
    #3
    up_tb = 1'b1;
    down_tb = 1'b0;
    
    #34
    if(counter_tb != 5'b01000)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
    
    
    //TEST CASE 4
    $display ("TEST CASE 4");
    #3
    load_tb = 1'b1;
    in_tb = 5'b11111;
    
    #9
    if(counter_tb != 5'b11111)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
    
    
    //TEST CASE 5
    $display ("TEST CASE 5");
    #3
    load_tb = 1'b0;
    up_tb = 1'b1;
    
    #8
    if(counter_tb != 5'b11111)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
    
    
    //TEST CASE 6
    $display ("TEST CASE 6");
    #3
    load_tb = 1'b1;
    in_tb = 5'b00001;
    
    #8
    if(counter_tb != 5'b00001)
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
    
    
    //TEST CASE 7
    $display ("TEST CASE 7");
    #3
    load_tb = 1'b0;
    down_tb = 1'b1;
    
    #24
    if(counter_tb != 5'b00000)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
      
    #20
    $stop; //finished with simulation  
    
  end
endmodule