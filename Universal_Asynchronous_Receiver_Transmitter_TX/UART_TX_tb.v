//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

module UART_TX_tb;
  
  parameter Clock_PERIOD = 5;
  
  //Declaring testbench signals
  reg [7:0] P_DATA_tb;
  reg DATA_VALID_tb;
  reg PAR_EN_tb, PAR_TYP_tb;
  reg CLK_tb, RST_tb;
  wire TX_OUT_tb, Busy_tb;
  
  
  //DUT instantiation
  UART_TX DUT(
  .P_DATA(P_DATA_tb),
  .DATA_VALID(DATA_VALID_tb),
  .PAR_EN(PAR_EN_tb),
  .PAR_TYP(PAR_TYP_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .TX_OUT(TX_OUT_tb),
  .Busy(Busy_tb)
  );
  
  //Clock generator
  always #(Clock_PERIOD/2) CLK_tb = !CLK_tb;
  
  
  //// TASKS ////
  
  //Signal Initialization task
  task initialize;
    begin
      DATA_VALID_tb = 0;
      CLK_tb = 0;
      RST_tb = 0;
      PAR_EN_tb = 0;
      PAR_TYP_tb = 0;
      P_DATA_tb = 'b0;
    end
  endtask
  
  // RESET Task  
  task reset;
    begin
      RST_tb = 1;
      #(Clock_PERIOD)
      RST_tb = 0;
      #(Clock_PERIOD)
      RST_tb = 1;
    end
  endtask
  
  // Do operation Operation Task
  task Do_operation;
    input data_valid, parity_enable, parity_type, consecutive_flag; 
    begin
      	@(negedge CLK_tb);
	       DATA_VALID_tb = data_valid;
	       PAR_EN_tb = parity_enable;
	       PAR_TYP_tb = parity_type;
	     @(negedge CLK_tb);
	       DATA_VALID_tb = 0;
	     if(parity_enable && consecutive_flag) // two consecutive frames
		    #(10 * Clock_PERIOD);
	     else if(parity_enable && !consecutive_flag) // non consecutive frames
		    #(11 * Clock_PERIOD);
	     else
		    #(9 * Clock_PERIOD);
    end
    
  endtask 
  

  initial
  begin
    // System Functions
    $dumpfile("UART_TX.vcd");       
    $dumpvars;
    
    
    //Initialization and reset
    initialize();
    reset();
    
      
      //TEST CASE1
      $display ("TEST CASE 1");
      
      Do_operation(1'b1 ,1'b1 , 1'b0,1'b1); // valid - enable - type - consecutive_flag
	    P_DATA_tb = 8'b1010_0010;
      
      
      #((Clock_PERIOD/2) +3)
      if(TX_OUT_tb != 1 && Busy_tb != 0 )
      $display ("TEST CASE 1 IS FAILED");
    
      else $display ("TEST CASE 1 IS PASSED");
      
      
      //TEST CASE2
      $display ("TEST CASE 2");
      
	    Do_operation(1'b1 ,1'b1 , 1'b0,1'b0);
	    P_DATA_tb = 8'b0110_0110;
      
      
      #((Clock_PERIOD/2) +3)
      if(TX_OUT_tb != 1 && Busy_tb != 0 )
      $display ("TEST CASE 2 IS FAILED");
    
      else $display ("TEST CASE 2 IS PASSED");
      
 	    //TEST CASE3
      $display ("TEST CASE 3");
      
 	    Do_operation(1'b1 ,1'b0 , 1'b0,1'b0);
	    P_DATA_tb = 8'b0110_0110;
      
      #1
      if(TX_OUT_tb != 0 && Busy_tb != 0 )
      $display ("TEST CASE 3 IS FAILED");
    
      else $display ("TEST CASE 3 IS PASSED");
      
      
      //TEST CASE4
      $display ("TEST CASE 4");
      
      Do_operation(1'b1 ,1'b0 , 1'b1,1'b1);
	    P_DATA_tb = 8'b1110_1011;
     
      #((Clock_PERIOD/2) +3)
      if(TX_OUT_tb != 1 && Busy_tb != 0 )
      $display ("TEST CASE 4 IS FAILED");
    
      else $display ("TEST CASE 4 IS PASSED");
        
     
      #20
      $stop;
           
  end
  
endmodule
