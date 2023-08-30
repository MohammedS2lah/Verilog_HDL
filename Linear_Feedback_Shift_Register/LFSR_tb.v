`timescale 1ns/1ps

module  LFSR_tb ;
  
  //Testbench parameters
  parameter LFSR_WD_tb = 8;
  parameter Clock_PERIOD = 10;
  parameter Test_Cases = 5;

  
  reg [LFSR_WD_tb-1:0] seed_tb;
  reg enable_tb;
  reg clk_tb;
  reg rst_tb;
  reg out_enable_tb;
  wire out_tb;
  wire valid_tb;
  
  
  //Memories to read the files
  reg [LFSR_WD_tb-1:0] Test_seeds [Test_Cases-1:0];
  reg [LFSR_WD_tb-1:0] Expected_outs [Test_Cases-1:0];
  
  
  //Clock Generator
  always #(Clock_PERIOD/2)  clk_tb = ~clk_tb;
  
  //DUT Instantation
  LFSR DUT(
  .seed(seed_tb),
  .enable(enable_tb),
  .clk(clk_tb),
  .rst(rst_tb),
  .out_enable(out_enable_tb),
  .out(out_tb),
  .valid(valid_tb)
  );
  
  
  //// TASKS ////
  
  //Signal Initialization task
  task initialize;
    begin
      seed_tb = 'b10010011;
      clk_tb = 0;
      rst_tb = 0;
      enable_tb = 0;
      out_enable_tb = 0;
    end
  endtask
  
  // RESET Task  
  task reset;
    begin
      rst_tb = 1;
      #(Clock_PERIOD)
      rst_tb = 0;
      #(Clock_PERIOD)
      rst_tb = 1;
    end
  endtask
   
  // Do LFSR Operation Task
  task Do_operation;
    input [LFSR_WD_tb-1 : 0] IN_seed;
      
    begin
      seed_tb = IN_seed;
      reset();
      #(Clock_PERIOD)
      enable_tb = 1'b1;
      #(10*Clock_PERIOD)
      enable_tb = 1'b0;
    end
       
  endtask  
   
  
  // Check Out Response Task
  task Check_out;
    input reg [LFSR_WD_tb-1 : 0] expec_out;
    input integer Oper_Num;
      
    integer i;
    reg [LFSR_WD_tb-1:0] gener_out;
    
    begin
      enable_tb = 1'b0;  
      #(Clock_PERIOD)
      out_enable_tb = 1'b1; 
      @(posedge valid_tb)
      for(i=0; i<8; i=i+1)
        begin
        #(Clock_PERIOD) gener_out[i] = out_tb ;
        end
        if(gener_out == expec_out) 
          begin
          $display("Test Case %d is succeeded",Oper_Num);
          end
        else
        begin
        $display("Test Case %d is failed", Oper_Num);
        end
        out_enable_tb = 1'b0;
      

    end
  endtask
  
  // initial block
  integer operation;
  initial
  begin
    // System Functions
    $dumpfile("LFSR.vcd");       
    $dumpvars;
    // Read Input Files
    $readmemb("seed.txt", Test_seeds);
    $readmemb("Expec_out.txt", Expected_outs);
    
    //Initialization
    initialize();
    
    for (operation = 0;operation < Test_Cases; operation = operation +1)
      begin
        Do_operation(Test_seeds[operation]);
        Check_out(Expected_outs[operation], operation);
      end
      
    #100
    $stop;  
    
  end
  
endmodule