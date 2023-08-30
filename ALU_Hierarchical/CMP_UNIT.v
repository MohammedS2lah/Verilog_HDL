//Module name
module CMP_UNIT
#(parameter in_width = 8, out_width = 16)
(
  //CMP_UNIT parameterized Operands
  input [ in_width - 1 :0] A, B,
  //CMP_UNIT function selection
  input [1:0] ALU_FUN,
  input CMP_Enable, RST,
  input clk,
  //CMP_UNIT parameterized Result
  output reg [out_width - 1 : 0] CMP_OUT,
  output reg CMP_Flag
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
        CMP_OUT <= 'b0;
        CMP_Flag <= 1'b0;
      end
    else 
      begin
        CMP_OUT <= out;
        CMP_Flag <= flag;
      end
  end

always@(*)
  begin
    //Block enable
    if(CMP_Enable)
      begin
        flag = 1'b1;
        case(ALU_FUN)
          //No Operation 
          2'b00: out = 'b0;
          
          //Equality
          2'b01: begin
                  if(A == B)
                    out = 1;
                  else out = 'b0; 
                 end
          
          //Greater than
          2'b10: begin
                  if(A > B)
                    out = 2;
                  else out = 'b0; 
                 end
          
          //Less than       
          2'b11: begin
                  if(A < B)
                    out = 3;
                  else out = 'b0; 
                 end
                 
          default: out = 'b0;
        endcase 
      end
      
    else
      begin
        flag = 1'b0;
        out = 'b0;
      end
  end  

endmodule