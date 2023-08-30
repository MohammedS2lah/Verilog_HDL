//Module name
module LOGIC_UNIT
#(parameter in_width = 8, out_width = 16)
(
  //LOGIC_UNIT parameterized Operands
  input [ in_width - 1 :0] A, B,
  //LOGIC_UNIT function selection
  input [1:0] ALU_FUN,
  input Logic_Enable, RST,
  input clk,
  //LOGIC_UNIT parameterized Result
  output reg [out_width - 1 : 0] Logic_OUT,
  output reg Logic_Flag
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
        Logic_OUT <= 'b0;
        Logic_Flag <= 1'b0;
      end
    else 
      begin
        Logic_OUT <= out;
        Logic_Flag <= flag;
      end
  end

always@(*)
  begin
    //Block enable
    if(Logic_Enable)
      begin
        flag = 1'b1;
        case(ALU_FUN)
          //AND operation
          2'b00: out = A & B;
          
          //OR operation
          2'b01: out = A | B;
          
          //NAND operation
          2'b10: out = ~(A & B);
          
          //NOR operation
          2'b11: out = ~(A | B);
          default: out = A & B;
        endcase 
      end
    
    else
      begin
        flag = 1'b0;
        out = 'b0;
      end
  end  

endmodule