//time_unit = 1ns & time percision = 1ps
`timescale 1ns/1ps

module CRC_tb;
  
  //Testbench parameters
  parameter LFSR_WIDTH = 8;
  //Clock frequency: 10 MHz
  parameter Clock_PERIOD = 100;
  parameter Test_Cases = 10;
  
  //Declaring testbench signals
  reg DATA_tb;
  reg ACTIVE_tb, CLK_tb, RST_tb;
  wire CRC_tb, Valid_tb;
  
  //Memories to read the files
  reg [LFSR_WIDTH-1:0] data [Test_Cases-1:0];
  reg [LFSR_WIDTH-1:0] Expected_outs [Test_Cases-1:0];
  
  //Clock Generator
  always #(Clock_PERIOD/2)  CLK_tb = ~CLK_tb;
  
  //DUT Instantation
  CRC DUT(
  .DATA(DATA_tb),
  .ACTIVE(ACTIVE_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .CRC(CRC_tb),
  .Valid(Valid_tb)
  );
  
  //// TASKS ////
  
  //Signal Initialization task
  task initialize;
    begin
      DATA_tb = 1'b0;
      CLK_tb = 0;
      RST_tb = 0;
      ACTIVE_tb = 0;
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
  
  // Do LFSR Operation Task and getting data from data file
  task Do_operation;
    input [LFSR_WIDTH-1 : 0] DATA_fromfile;
    integer i;  
    begin
      ACTIVE_tb = 1;
      for(i=0; i<LFSR_WIDTH; i=i+1)
        begin
        DATA_tb = DATA_fromfile[i];
        @(posedge CLK_tb);
        end
        ACTIVE_tb = 0;
    end
       
  endtask  
  
  // Check Out Response Task
  task Check_out;
    input reg [LFSR_WIDTH-1 : 0] expec_out;
    input integer Oper_Num;
      
    integer i;
    reg [LFSR_WIDTH-1:0] gener_out;
    
    begin 
      @(posedge Valid_tb)
      for(i=0; i<LFSR_WIDTH; i=i+1)
        begin
        #(Clock_PERIOD) 
        gener_out[i] = CRC_tb;
        end
        if(gener_out == expec_out) 
          begin
          $display("Test Case %d is succeeded",Oper_Num);
          end
        else
        begin
        $display("Test Case %d is failed", Oper_Num);
        end

    end
  endtask
  
  
  // initial block
  integer operation;
  initial
  begin
    // System Functions
    $dumpfile("CRC.vcd");       
    $dumpvars;
    // Read Input Files in hexadecimal
    $readmemh("DATA_h.txt", data);
    $readmemh("Expec_Out_h.txt", Expected_outs);
    
    //Initialization
    initialize();
    reset();
    ACTIVE_tb = 1;
    for (operation = 0;operation < Test_Cases; operation = operation +1)
      begin
        reset();
        Do_operation(data[operation]);
        Check_out(Expected_outs[operation], operation);
      end
    
    ACTIVE_tb = 0;
      
    #50
    $stop;  
    
  end 

endmodule