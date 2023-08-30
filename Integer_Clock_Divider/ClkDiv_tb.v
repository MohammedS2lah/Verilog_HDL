`timescale 1ns/1ps

module ClkDiv_tb;
  
  parameter Clock_PERIOD = 10;
  
  reg i_ref_clk_tb;
  reg [3:0] i_div_ratio_tb;
  reg i_rst_n_tb, i_clk_en_tb;
  wire o_div_clk_tb;
  
  
  ClkDiv DUT(
  .i_ref_clk(i_ref_clk_tb),
  .i_div_ratio(i_div_ratio_tb),
  .i_rst_n(i_rst_n_tb),
  .i_clk_en(i_clk_en_tb),
  .o_div_clk(o_div_clk_tb)
  );
  
  
  always #(Clock_PERIOD/2)  i_ref_clk_tb = ~i_ref_clk_tb;  
  
  
  //// TASKS ////
  
  //Signal Initialization task
  task initialize;
    begin
      i_div_ratio_tb = 4'b0001;
      i_clk_en_tb = 1'b0;
      i_ref_clk_tb = 1'b0;
      i_rst_n_tb = 1'b0;
    end
  endtask
  
  
  // RESET Task  
  task reset;
    begin
      i_rst_n_tb = 1;
      #(Clock_PERIOD)
      i_rst_n_tb = 0;
      #(Clock_PERIOD)
      i_rst_n_tb = 1;
    end
  endtask
  
  
    //Initial block
  initial
  begin
    $dumpfile("ClkDiv.vcd");
    $dumpvars;
    
    //Initialization
    initialize();
    #(Clock_PERIOD)
      reset();
      //TEST CASE 1
      $display ("TEST CASE 1");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0010;
      i_clk_en_tb = 1'b0;
      #(10 * Clock_PERIOD)  
      reset();
    
    
      //TEST CASE 2
      $display ("TEST CASE 2");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0001;
      i_clk_en_tb = 1'b1;
    
      #(10 * Clock_PERIOD)  
      reset();
    
    
      //TEST CASE 3
      $display ("TEST CASE 3");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0000;
    
      #(10 * Clock_PERIOD)  
      reset();    
    
      
      //TEST CASE 4
      $display ("TEST CASE 4");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0010;
    
      #(9 * Clock_PERIOD)  
      reset();      
      
      
      //TEST CASE 5
      $display ("TEST CASE 5");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0011;
    
      #(20 * Clock_PERIOD)  
      reset();      
      
      
      
      //TEST CASE 6
      $display ("TEST CASE 6");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0100;
    
      #(20 * Clock_PERIOD)  
      reset();       
      
      
      //TEST CASE 7
      $display ("TEST CASE 7");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b0101;
    
      #(19 * Clock_PERIOD)  
      reset();        
      
      
      //TEST CASE 8
      $display ("TEST CASE 8");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b1000;
    
      #(40 * Clock_PERIOD)  
      reset();
            
      
      //TEST CASE 9
      $display ("TEST CASE 9");
      #((Clock_PERIOD/2)-1)
      i_div_ratio_tb = 4'b1111;
    
      #(40 * Clock_PERIOD)    
      
      
      
    #(5*Clock_PERIOD)
    $stop; //finished with simulation  
    
  end
  
 
endmodule