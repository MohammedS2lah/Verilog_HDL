`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2023 03:40:05 PM
// Design Name: 
// Module Name: moore_1101_detector_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module moore_1101_detector_tb;
  
  reg clk_tb;
  reg reset_n_tb;
  reg x_tb; 
  wire y_tb;
  
  
  moore_1101_detector DUT(
    .clk(clk_tb),
    .reset_n(reset_n_tb),
    .x(x_tb),
    .y(y_tb)
  );
  
  // Clock generator
  always begin
      #5 clk_tb = ~clk_tb;
  end
  
  initial begin
    clk_tb = 0;
    reset_n_tb = 0;
    x_tb = 0;
    
    #10
    reset_n_tb = 1;
    x_tb = 0;
    
    #10
    x_tb = 1; //to s1
    
    #10
    x_tb = 1; //to s2
    
    #10
    x_tb = 1; //to s2
    
    #10
    x_tb = 0; //to s3
    
    #10
    x_tb = 1; //to s4
    
    #20
    reset_n_tb = 0; //to s0
    x_tb = 1;
    
    #20
    reset_n_tb = 1;
    x_tb = 1; //to s1 
        
    #10
    x_tb = 1; //to s2
    
    #10
    x_tb = 1; //to s2
    
    #10
    x_tb = 0; //to s3
    
    #10
    x_tb = 1; //to s4
    
    #10
    x_tb = 1; //to s1
    
    #10
    x_tb = 1; //to s2
    
    #10
    x_tb = 0; //to s3
    
    #10
    x_tb = 1; //to s4
    
    #10
    x_tb = 1; //to s1
    
    #20
    $stop;
  end
endmodule
