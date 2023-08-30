//Module name
module ARITHMETIC_UNIT
#(parameter in_width = 8, out_width = 16)
(
  //ARITHMETIC_UNIT parameterized operands
  input [ in_width - 1 :0] A, B,
  //ARITHMETIC_UNIT function selection
  input [1:0] ALU_FUN,
  input Arith_Enable, RST,
  input clk,
  //ARITHMETIC_UNIT parameterized Result
  output reg [out_width - 1 : 0] Arith_OUT,
  output reg Carry_OUT, Arith_Flag
);

//All Outputs are registered.
reg [out_width - 1 : 0] out;
reg carry, flag;

//RTL code
always@(posedge clk, negedge RST)
  begin
    //Asynchronous active low reset
    if(!RST)
      begin
        Arith_OUT <= 'b0;
        Carry_OUT <= 1'b0;
        Arith_Flag <= 1'b0;
      end
      
    else if(!Arith_Enable)
      begin
        Arith_OUT <= 'b0;
        Carry_OUT <= 1'b0;
        Arith_Flag <= 1'b0;
      end
    else  
      begin
        Arith_OUT <= out;
        Carry_OUT <= carry;
        Arith_Flag <= flag;
      end
  end

always@(*)
  begin
    if(Arith_Enable)
      begin
        flag = 1'b1;
        case(ALU_FUN)
          //Addition operation
          2'b00:  {carry, out} = A+B;
          
          //Subtraction operation
          2'b01:  {carry, out} = A-B;
          
          //Multiplication operation
          2'b10:  {carry, out} = A*B;
          
          //Division operation
          2'b11:  if (B != 0)
                  {carry, out} = A/B;
                  else begin
                    $display("Error: Division by zero");
                    {carry, out} = 'hFFFFF;
                  end
                  
          default: {carry, out} = A+B;
        endcase 
      end
    else
      begin
        flag = 1'b0;
        carry = 1'b0;
        out = 'b0;
      end
  end  

endmodule