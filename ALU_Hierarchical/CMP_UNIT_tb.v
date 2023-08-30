//time_unit = 10us & time percision = 10ns
`timescale 10us/10ns

//Testbench has no inputs or outputs
module CMP_UNIT_tb #(parameter in_width = 8, out_width = 16);
  
  //Declaring testbench signals
  reg [ in_width - 1 :0] A_tb, B_tb;
  reg [1:0] ALU_FUN_tb;
  reg CMP_Enable_tb;
  reg RST_tb;
  reg clk_tb;
  wire [out_width - 1 : 0] CMP_OUT_tb;
  wire CMP_Flag_tb; 
  
  //DUT instantiation
  CMP_UNIT DUT(
  .A(A_tb),
  .B(B_tb),
  .ALU_FUN(ALU_FUN_tb),
  .CMP_Enable(CMP_Enable_tb),
  .RST(RST_tb),
  .clk(clk_tb),
  .CMP_OUT(CMP_OUT_tb),
  .CMP_Flag(CMP_Flag_tb)
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
    $dumpfile("CMP_UNIT.vcd");
    $dumpvars;
    clk_tb = 1'b0;
    RST_tb = 1'b0;
    ALU_FUN_tb = 2'b00;
    CMP_Enable_tb = 1'b0;
    A_tb = 15;
    B_tb = 30;
    
    
    //TEST CASE 1
    $display ("TEST CASE 1");
    #3
    CMP_Enable_tb = 1'b1;
    RST_tb = 1'b1;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1)
      $display ("TEST CASE 1 IS FAILED");
    
    else $display ("TEST CASE 1 IS PASSED");
    
    
    //TEST CASE 2
    $display ("TEST CASE 2");
    #3
    ALU_FUN_tb = 2'b01;
    A_tb = 50;
    B_tb = 50;
    
    #8
    if(CMP_OUT_tb != 1  & CMP_Flag_tb != 1)
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
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 0)
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
    if(CMP_OUT_tb != 2  & CMP_Flag_tb != 1)
      $display ("TEST CASE 4 IS FAILED");
    
    else $display ("TEST CASE 4 IS PASSED");
    
    
    //TEST CASE 5
    $display ("TEST CASE 5");
    #3
    ALU_FUN_tb = 2'b11;
    A_tb = 50;
    B_tb = 5;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1)
      $display ("TEST CASE 5 IS FAILED");
    
    else $display ("TEST CASE 5 IS PASSED");
    
    
    //TEST CASE 6 
    $display ("TEST CASE 6");
    #3
    ALU_FUN_tb = 2'b11;
    A_tb = 10;
    B_tb = 50;
    
    #8
    if(CMP_OUT_tb != 3  & CMP_Flag_tb != 1 )
      $display ("TEST CASE 6 IS FAILED");
    
    else $display ("TEST CASE 6 IS PASSED");
    
    
    //TEST CASE 7 
    $display ("TEST CASE 7");
    #3
    ALU_FUN_tb = 2'b01;
    A_tb = 25;
    B_tb = 23;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1)
      $display ("TEST CASE 7 IS FAILED");
    
    else $display ("TEST CASE 7 IS PASSED");
      
    
    //TEST CASE 8 
    $display ("TEST CASE 8");
    #3
    ALU_FUN_tb = 2'b10;
    A_tb = 240;
    B_tb = 245;
    
    #8
    if(CMP_OUT_tb != 0  & CMP_Flag_tb != 1)
      $display ("TEST CASE 8 IS FAILED");
    
    else $display ("TEST CASE 8 IS PASSED");  
      
    #10
    $stop; //finished with simulation  
    
  end
  
endmodule
