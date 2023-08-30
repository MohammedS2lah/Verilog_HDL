module UART_Parity_Calc(
  input wire [7:0] P_DATA,
  input wire Data_Valid, PAR_TYP,
  input wire CLK, RST,
  output reg par_bit
);


  always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        par_bit <= 1'b0;
      end
    else
      begin
        case ({Data_Valid,PAR_TYP})
          2'b10: par_bit <= ^P_DATA; //Even parity
          2'b11: par_bit <= ~(^P_DATA); //Odd parity
          default: par_bit <= 1'b0;
        endcase
      end
  end
  
endmodule
