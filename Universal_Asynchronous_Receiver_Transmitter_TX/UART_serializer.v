module UART_serializer(
  input wire [7:0] P_DATA,
  input wire ser_en, CLK, RST,
  output reg ser_data,
  output wire ser_done
);

  reg [3:0] counter; 
  
  
  always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        counter <= 4'b0000;
        ser_data <= 1'b0;
      end
     
    else if (ser_en && counter != 4'b1000)
      begin
        ser_data <= P_DATA[counter];
        counter <= counter + 1 ;
      end
      
    else begin
        counter <= 4'b0000;
        ser_data <= 1'b0;
    end
  end
  
  assign ser_done = (counter == 4'b1000);
  
endmodule