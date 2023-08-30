module UART_TX(
  input [7:0] P_DATA,
  input DATA_VALID, PAR_EN, PAR_TYP,
  input CLK, RST,
  output TX_OUT, Busy
);
  
  //UART_TX internal wires between blocks
  wire ser_done, ser_en, ser_data, par_bit;
  wire [1:0] mux_sel;
  
  //UART_TX_FSM instantiation
  UART_TX_FSM FSM(
  .Data_valid(DATA_VALID),
  .PAR_EN(PAR_EN),
  .ser_done(ser_done),
  .RST(RST),
  .CLK(CLK),
  .ser_en(ser_en),
  .Busy(Busy),
  .mux_sel(mux_sel)
  );
  
  //UART_serializer instantiation
  UART_serializer serializer(
  .P_DATA(P_DATA),
  .ser_en(ser_en),
  .CLK(CLK),
  .RST(RST),
  .ser_data(ser_data),
  .ser_done(ser_done)
  );
  
  //UART_Parity_Calc instantiation
  UART_Parity_Calc Parity_Calculator(
  .P_DATA(P_DATA),
  .Data_Valid(DATA_VALID),
  .PAR_TYP(PAR_TYP),
  .CLK(CLK),
  .RST(RST),
  .par_bit(par_bit)
  );
  
  //UART_TX_MUX instantiation
  UART_TX_MUX Multiplixer(
  .mux_sel(mux_sel),
  .ser_data(ser_data),
  .par_bit(par_bit),
  .TX_OUT(TX_OUT)
  );
  
  
endmodule