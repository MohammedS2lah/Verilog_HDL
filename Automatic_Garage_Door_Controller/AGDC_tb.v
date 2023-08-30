//time_unit = 1ns & time percision = 1ps 
`timescale 1ns/1ps

module AGDC_tb;
  
  //using 50 MHz clock frequency
  parameter Clock_PERIOD = 20;
  
  reg UP_Max_tb, Activate_tb, DN_Max_tb;
  reg CLK_tb, RST_tb;
  wire UP_M_tb, DN_M_tb;
  
  
  AGDC DUT(
  .UP_Max(UP_Max_tb),
  .Activate(Activate_tb),
  .DN_Max(DN_Max_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .UP_M(UP_M_tb),
  .DN_M(DN_M_tb)
  );
  
  //Clock Generator
  always #(Clock_PERIOD/2)  CLK_tb = ~CLK_tb;
  
  
  //// TASKS ////
  
  //Signal Initialization task
  task initialize;
    begin
      UP_Max_tb = 0;
      Activate_tb = 0;
      DN_Max_tb = 0;
      CLK_tb = 0;
      RST_tb = 0;
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
  
  //Initial block
  initial
  begin
    $dumpfile("AGDC.vcd");
    $dumpvars;
    
    //Initialization
    initialize();
    #(Clock_PERIOD)
      reset();
      //TEST CASE 1
      $display ("TEST CASE 1");
      #((Clock_PERIOD/2)-1)
      UP_Max_tb = 0;
      Activate_tb = 1;
      DN_Max_tb = 1; //Go to Mv_Up state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 1 & DN_M_tb !=0)
      $display ("TEST CASE 1 IS FAILED");
    
      else $display ("TEST CASE 1 IS PASSED");
      
      
      //TEST CASE 2
      $display ("TEST CASE 2");
      #((Clock_PERIOD/2)-1)
      UP_Max_tb = 1; //Go back to IDLE state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=0)
      $display ("TEST CASE 2 IS FAILED");
    
      else $display ("TEST CASE 2 IS PASSED");
      
      
      //TEST CASE 3
      $display ("TEST CASE 3");
      #((Clock_PERIOD/2)-1)
      UP_Max_tb = 1;
      Activate_tb = 1;
      DN_Max_tb = 0; //Go to Mv_Dn state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=1)
      $display ("TEST CASE 3 IS FAILED");
    
      else $display ("TEST CASE 3 IS PASSED");
        
      
      //TEST CASE 4
      $display ("TEST CASE 4");
      #((Clock_PERIOD/2)-1)
      reset();       //Go back to IDLE state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=0)
      $display ("TEST CASE 4 IS FAILED");
    
      else $display ("TEST CASE 4 IS PASSED");
        
      
      //TEST CASE 5
      $display ("TEST CASE 5");
      #((Clock_PERIOD/2)-2)
      UP_Max_tb = 1;
      Activate_tb = 1;
      DN_Max_tb = 0; //Go to Mv_Dn state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=1)
      $display ("TEST CASE 5 IS FAILED");
    
      else $display ("TEST CASE 5 IS PASSED");
      
            
      //TEST CASE 6
      $display ("TEST CASE 6");
      #((Clock_PERIOD/2)-2)
      DN_Max_tb = 0; //Stay in Mv_Dn state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=1)
      $display ("TEST CASE 6 IS FAILED");
    
      else $display ("TEST CASE 6 IS PASSED");
      
      
      //TEST CASE 7
      $display ("TEST CASE 7");
      #((Clock_PERIOD/2)-2)
      DN_Max_tb = 1; //Go back to IDLE state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=0)
      $display ("TEST CASE 7 IS FAILED");
    
      else $display ("TEST CASE 7 IS PASSED");
      
      
      //TEST CASE 8
      $display ("TEST CASE 8");
      #((Clock_PERIOD/2)-2)
      UP_Max_tb = 0;
      Activate_tb = 1;
      DN_Max_tb = 1; //Go to Mv_Up state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 1 & DN_M_tb !=0)
      $display ("TEST CASE 8 IS FAILED");
    
      else $display ("TEST CASE 8 IS PASSED"); 
      
      
      //TEST CASE 9
      $display ("TEST CASE 9");
      #((Clock_PERIOD/2)-2)
      UP_Max_tb = 0; //Stay in Mv_Up state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 1 & DN_M_tb !=0)
      $display ("TEST CASE 9 IS FAILED");
    
      else $display ("TEST CASE 9 IS PASSED"); 
      
      
      //TEST CASE 10
      $display ("TEST CASE 10");
      #((Clock_PERIOD/2)-2)
      UP_Max_tb = 1; //Go back to IDLE state
      
      #((Clock_PERIOD/2)+3)
      if(UP_M_tb != 0 & DN_M_tb !=0)
      $display ("TEST CASE 10 IS FAILED");
    
      else $display ("TEST CASE 10 IS PASSED");
    
      
    #(2*Clock_PERIOD)
    $stop; //finished with simulation  
    
  end
  
endmodule