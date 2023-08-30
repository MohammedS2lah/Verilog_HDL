//Module name
module SHIFT_UNIT
#(parameter in_width = 8, out_width = 16)
(
  //SHIFT_UNIT parameterized Operands
  input [ in_width - 1 :0] A, B,
  //SHIFT_UNIT function selection
  input [1:0] ALU_FUN,
  input Shift_Enable, RST,
  input clk,
  //SHIFT_UNIT parameterized Result
  output reg [out_width - 1 : 0] SHIFT_OUT,
  output reg SHIFT_Flag
);

//All Outputs are registered.
reg [out_width - 1 : 0] out;
reg flag;

//RTL code
always@(posedge clk, negedge RST)
  begin
    //Asynchronous active low reset
    if(!RST)
      begin
        SHIFT_OUT <= 'b0;
        SHIFT_Flag <= 1'b0;
      end
    else 
      begin
        SHIFT_OUT <= out;
        SHIFT_Flag <= flag;
      end
  end

always@(*)
  begin
    //Block enable
    if(Shift_Enable)
      begin
        flag = 1'b1;
        case(ALU_FUN)
          //Shift right for A
          2'b00: out = A >> 1;
          
          //Shift left for A
          2'b01: out = A << 1;
          
          //Shift right for B
          2'b10: out = B >> 1;
          
          //Shift left for B      
          2'b11: out = B << 1;
                 
          default: out = A >> 1;
        endcase 
      end
      
    else
      begin
        flag = 1'b0;
        out = 'b0;
      end
  end  

endmodule

