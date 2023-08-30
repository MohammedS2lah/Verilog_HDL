module UART_TX_MUX(
  input [1:0] mux_sel,
  input ser_data, par_bit,
  output reg TX_OUT
);

  
  always@(*)
  begin
    case(mux_sel)
      //To select start bit
      2'b00: TX_OUT = 1'b0;
      //To select stop bit 
      2'b01: TX_OUT = 1'b1;
      //To select serialized data
      2'b10: TX_OUT = ser_data;
      //To select parity bit
      2'b11: TX_OUT = par_bit;
      default : TX_OUT = 1'b1;
    endcase 
  end
  
endmodule