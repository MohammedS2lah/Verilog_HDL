//Module name
module ALU_16bit(
  //ALU Operands
  input [15:0] A,B,
  //ALU function selection
  input [3:0] ALU_FUN,
  input clk,
  //ALU Result
  output reg [15:0] ALU_OUT,
  //ALU output flags 
  output reg Arith_flag, Logic_flag, CMP_flag, Shift_flag
);
  
  //ALU Result (ALU_OUT) is registered
  reg [15:0] ALU_OUTreg;
  
  //RTL code
  always@(clk)
    begin
      ALU_OUT <= ALU_OUTreg;
    end

  always@(*)
    begin
      case(ALU_FUN)
        
        //Addition operation
        4'b0000:  begin 
                    ALU_OUTreg = A + B;
                    Arith_flag = 1'b1;
                    Logic_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
                  
        //Subtraction operation
        4'b0001: begin 
                    ALU_OUTreg = A - B;
                    Arith_flag = 1'b1;
                    Logic_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
                  
        //Multiplication operation
        4'b0010: begin 
                    ALU_OUTreg = A * B;
                    Arith_flag = 1'b1;
                    Logic_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
                  
        //Division operation
        4'b0011: begin 
                    ALU_OUTreg = A / B;
                    Arith_flag = 1'b1;
                    Logic_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
                  
        //AND operation
        4'b0100: begin 
                    ALU_OUTreg = A & B;
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
                  
        //OR operation
        4'b0101: begin 
                    ALU_OUTreg = A | B;
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //NAND operation
        4'b0110: begin 
                    ALU_OUTreg = ~(A & B);
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //NOR operation
        4'b0111: begin 
                    ALU_OUTreg = ~(A | B);
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end          
        
        //XOR operation
        4'b1000: begin 
                    ALU_OUTreg = A ^ B;
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //XNOR operation
        4'b1001: begin 
                    ALU_OUTreg = ~(A ^ B);
                    Logic_flag = 1'b1;
                    Arith_flag = 1'b0;
                    CMP_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //Equality 
        4'b1010: begin 
                     if (A == B)
                        ALU_OUTreg = 16'b1;
                     else ALU_OUTreg = 16'b0;
                       
                    CMP_flag = 1'b1;
                    Logic_flag = 1'b0;
                    Arith_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //Greater than
        4'b1011: begin 
                    if (A > B)
                        ALU_OUTreg = 16'b10;
                    else ALU_OUTreg = 16'b0;
                     
                    CMP_flag = 1'b1;
                    Logic_flag = 1'b0;
                    Arith_flag = 1'b0;
                    Shift_flag = 1'b0;
                  end
        
        //Less than
        4'b1100: begin 
                    if (A < B)
                        ALU_OUTreg = 16'b11;
                     else ALU_OUTreg = 16'b0;
                     
                    CMP_flag = 1'b1;
                    Logic_flag = 1'b0;
                    Arith_flag = 1'b0;
                    Shift_flag = 1'b0;
                 end
        
        //Shift right
        4'b1101: begin 
                    ALU_OUTreg = A >> 1 ;
                    Shift_flag = 1'b1;
                    CMP_flag = 1'b0;
                    Logic_flag = 1'b0;
                    Arith_flag = 1'b0;
                 end
        
        //Shift left
        4'b1110: begin 
                    ALU_OUTreg = A << 1 ;
                    Shift_flag = 1'b1;
                    CMP_flag = 1'b0;
                    Logic_flag = 1'b0;
                    Arith_flag = 1'b0;
                 end
        
        //Default case
        default: begin
                  ALU_OUTreg = 16'b0;
                  Shift_flag = 1'b0;
                  CMP_flag = 1'b0;
                  Logic_flag = 1'b0;
                  Arith_flag = 1'b0;
                 end
                 
      endcase
  
    end
  

endmodule