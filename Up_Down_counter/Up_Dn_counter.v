//Module name
module Up_Dn_counter(
  input [4:0] in,
  input load,
  input up,
  input down,
  input clk,
  output reg [4:0] counter,
  output high,
  output low
);
  

  //RTL code
  always@(posedge clk)
  begin
    
    //Load has highest priority and loads counter Value from in
    if(load)
      begin
      counter <= in;
      end
    
    //Down has higher priority than Up signal and counter Value is decremented by 1 if it's not zero
    else if (down && counter != 5'b00000)
      begin
      counter <= counter - 5'b00001;
      end
    
    //counter Value is incremented by 1 if it's not 31 up signal is high  
    else if (up && counter != 5'b11111 && !down)
      begin
      counter <= counter + 5'b00001;
      end
    
    else counter <= counter;
      
  end
  
  //High flag active high whenever count value is 31
  assign high = (counter == 5'b11111);
  
  //"Low" flag active high whenever count value is 0
  assign low = (counter == 5'b00000);
  
endmodule