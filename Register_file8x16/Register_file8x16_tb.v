//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

//Testbench has no inputs or outputs
module Register_file8x16_tb;
  
  //Declaring testbench signals
  reg [15:0] WrData_tb;
  reg [2:0] Address_tb;
  reg WrEn_tb, RdEn_tb;
  reg CLK_tb;
  reg RST_tb;
  wire [15:0] RdData_tb;
  
  //DUT instantiation
  Register_file8x16 DUT(
  .WrData(WrData_tb),
  .Address(Address_tb),
  .WrEn(WrEn_tb),
  .RdEn(RdEn_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .RdData(RdData_tb)
  );
  
  //Clock generator
  always #5 CLK_tb = !CLK_tb;
  
  //Initial block
  initial
  begin
    $dumpfile("Register_file8x16.vcd");
    $dumpvars;
    CLK_tb = 1'b0;
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0;
    Address_tb = 0;
    RST_tb = 0;
    WrData_tb = 50;
    
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    RST_tb = 1;
    Address_tb = 0;
    WrEn_tb = 1'b1;
    WrData_tb = 50;
    
    
    #9
    if(RdData_tb != 0)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    Address_tb = 5;
    WrData_tb = 70;
    
    #9
    if(RdData_tb != 0)
      $display ("TEST CASE 2 IS FAILED");
    
    else $display ("TEST CASE 2 IS PASSED");
    
    //TEST CASE 3
    $display ("TEST CASE 3");
    #3
    Address_tb = 1;
    WrData_tb = 20;
    
    #9
    if(RdData_tb != 0)
      $display ("TEST CASE 3 IS FAILED");
    
    else $display ("TEST CASE 3 IS PASSED");
      
    
    //TEST CASE 4
    $display ("TEST CASE 4");
    #3
    Address_tb = 0;
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    
    #9
    if(RdData_tb != 50)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
      
    
    //TEST CASE 5
    $display ("TEST CASE 5");
    #3
    Address_tb = 1;
    RdEn_tb = 1'b1;
    
    #9
    if(RdData_tb != 20)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
      
    
    //TEST CASE 6
    $display ("TEST CASE 6");
    #3
    Address_tb = 5;
    
    #9
    if(RdData_tb != 70)
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
      
    
    //TEST CASE 7
    $display ("TEST CASE 7");
    #3
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;
    Address_tb = 7;
    WrData_tb = 1023;
    
    #9
    if(RdData_tb != 0)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
    
    
    //TEST CASE 8
    $display ("TEST CASE 8");
    #3
    Address_tb = 7;
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    
    #9
    if(RdData_tb != 1023)
      $display ("TEST CASE 8 IS FAILED");
    
    else $display ("TEST CASE 8 IS PASSED");
    
    
    //TEST CASE 9
    $display ("TEST CASE 9");
    #3
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b1;
    
    #9
    if(RdData_tb != 65535)
      $display ("TEST CASE 9 IS FAILED");
    
    else $display ("TEST CASE 9 IS PASSED");
    
    
    //TEST CASE 10
    $display ("TEST CASE 10");
    #3
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0;
    
    #9
    if(RdData_tb != 65535)
      $display ("TEST CASE 10 IS FAILED");
    
    else $display ("TEST CASE 10 IS PASSED");
    
      
    //TEST CASE 11
    $display ("TEST CASE 11");
    #3
    RST_tb = 0;
    Address_tb = 7;
    RdEn_tb = 1'b1;
    
    #9
    if(RdData_tb != 0)
      $display ("TEST CASE 11 IS FAILED");
    
    else $display ("TEST CASE 11 IS PASSED");
    
    
    #10
    $stop; //finished with simulation  
    
  end
   
endmodule