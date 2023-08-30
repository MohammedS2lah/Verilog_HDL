/*Decoder Unit responsibles for enable which Function 
to operate according to the highest Most significant 2-bit
of the ALU_FUNC control bus ALU_FUNC [3:2] */

//Module name
module Decoder_2x4(
  input [1:0] ALU_FUN,  
  output reg [3:0] y
);

always@(*)
  begin
    
    case(ALU_FUN)
        //Arith_En
        2'b00:  begin  
                  y[3] = 1'b1;
                  y[2] = 1'b0;
                  y[1] = 1'b0;
                  y[0] = 1'b0;
                end 
        
        //Logic_En
        2'b01:  begin  
                  y[3] = 1'b0;
                  y[2] = 1'b1;
                  y[1] = 1'b0;
                  y[0] = 1'b0;
                end
        
        //CMP_EN
        2'b10:  begin  
                  y[3] = 1'b0;
                  y[2] = 1'b0;
                  y[1] = 1'b1;
                  y[0] = 1'b0;
                end
        
        //SHIFT_EN
        2'b11:  begin  
                  y[3] = 1'b0;
                  y[2] = 1'b0;
                  y[1] = 1'b0;
                  y[0] = 1'b1;
                end
        
        default: begin  
                  y[3] = 1'b1;
                  y[2] = 1'b0;
                  y[1] = 1'b0;
                  y[0] = 1'b0;
                end
    
      endcase
  
  end

endmodule