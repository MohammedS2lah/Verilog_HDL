//Linear Feedback Shift Register module name
module LFSR(
  input [7:0] seed,
  input enable, clk, rst, out_enable,
  output reg out, valid
);

  //Declare 8-bit register
  reg [7:0] LFSR;
  wire Feedback, Bit_0to6;
  //Taps define the sequence 
  parameter [7:0] Taps = 8'b10101010;
  integer N;
  //NOR  Reduction of LFSR 0 to 6 bits
  assign Bit_0to6 = ~|LFSR[6:0];
  assign Feedback = Bit_0to6 ^ LFSR[7];
  
  always@(posedge clk or negedge rst)
    begin
      //Asynchronous active low reset
      if(!rst)
        begin
          LFSR <= seed;
          out <= 1'b0;
          valid <= 1'b0;        
        end
    
    else if(enable)
      begin 
        LFSR[0] <= Feedback;
        for(N = 7; N >= 1; N = N - 1)
          if(Taps[N] == 1)
            LFSR[N] <= LFSR[N-1] ^ Feedback;
            
          else LFSR[N] <= LFSR[N-1];
      end
      //enable signal makes the result sequence available in the LFSR 
    else if (out_enable)
      begin
        {LFSR[6:0], out} <= LFSR;
        /*
        result is serially out through LFSR[0]
        LFSR[6] <= LFSR[7];
        LFSR[5] <= LFSR[6];
        LFSR[4] <= LFSR[5];
        LFSR[3] <= LFSR[4];
        LFSR[2] <= LFSR[3];
        LFSR[1] <= LFSR[2];
        LFSR[0] <= LFSR[1];
        out <= LFSR[0];
        */
        valid <= 1'b1;
        
      end
      
    end

endmodule