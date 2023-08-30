module ClkDiv(
  input i_ref_clk,
  input [3:0] i_div_ratio,
  input i_rst_n, i_clk_en,
  output reg o_div_clk
);
  
  reg [3:0] count;
  reg Toggle_Flag;
  wire [3:0] half, halfplus1;
  wire odd, CLK_DIV_EN;
  
  assign half = i_div_ratio >> 1;
  
  assign odd = i_div_ratio[0];
  
  assign halfplus1 = half + 1'b1;
  
  assign CLK_DIV_EN = i_clk_en && (i_div_ratio != 0) && (i_div_ratio != 1);
  
  
  always@(posedge i_ref_clk or negedge i_rst_n)
  begin
    if(!i_rst_n)
      begin
        o_div_clk <= 1'b0;
        count <= 4'b0001;
        Toggle_Flag <= 1'b0;
      end
    else if (CLK_DIV_EN)
      begin
        if(count == half && !odd)
          begin
            o_div_clk <= !o_div_clk;
            count <= 4'b0001;
          end
        else if (((count == half && !Toggle_Flag) || (count == halfplus1 && Toggle_Flag)) && odd)
          begin
            o_div_clk <= !o_div_clk;
            Toggle_Flag <= !Toggle_Flag;
            count <= 4'b0001;
          end
          
        else count <= count +1;
      end
      
    else begin
        o_div_clk <= 1'b0;
        count <= 4'b0001;
    end

  end
  
endmodule
