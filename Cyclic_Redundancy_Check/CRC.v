//Module name
module CRC(
input DATA,
input ACTIVE, CLK, RST,
output reg CRC, Valid
);

  //Output registers
	reg crc_reg =0 , valid_reg = 0;
	//LFSR registers
	reg [7:0] R;
	//Counter to control shifting the outputs
	reg counter = 3'b000;
	//Seed is the initial content of the shift register
	localparam SEED = 8'hD8;
	wire feedback;
	assign feedback = DATA ^ R[0];
	
	always@(posedge CLK or negedge RST)
	begin
	  //Asynchronous active low reset
		if(!RST)
		begin
		  //All registers are set to LFSR Seed value
			R <= SEED;
			crc_reg <= 0;
			valid_reg <= 0;
		end
	  
	  //ACTIVE input signal is high during data transmission, low otherwise
		else if(ACTIVE)
		begin
			R[0] <= R[1];
			R[1] <= R[2];
			R[2] <= R[3] ^ feedback;
			R[3] <= R[4];
			R[4] <= R[5];
			R[5] <= R[6];
			R[6] <= R[7] ^ feedback;
			R[7] <= feedback;
		end
		
		else if (counter <= 3'b111)
		begin
			counter <= counter +1;
			//Valid signal is high during CRC bits transmission, otherwise low
			valid_reg <= 1;
			//CRC 8 bits are shifted serially through CRC output port
			{R[6:0], crc_reg} <= R[7:0];
		
		end
		
		else 
		begin
		  valid_reg <= 0;
		end
	
	end
	//Getting outputs from their registers
	always@(posedge CLK or negedge RST)
	begin
	   	CRC <= crc_reg;
			Valid <= valid_reg;
	end

endmodule