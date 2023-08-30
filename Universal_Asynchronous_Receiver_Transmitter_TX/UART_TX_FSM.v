module UART_TX_FSM(
  input Data_valid,
  input PAR_EN, ser_done,
  input RST, CLK,
  output reg ser_en, Busy,
  output reg [1:0] mux_sel
);

  //Registers to store present state and next state
  reg [2:0] present_state, next_state;
  
  //FSM states
  parameter [2:0] IDLE = 3'b000;
  parameter [2:0] STR = 3'b001;
  parameter [2:0] DATA = 3'b010;
  parameter [2:0] PARITY = 3'b011;
  parameter [2:0] STP = 3'b100;
  
  always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        present_state <= IDLE;
      end
    else present_state <= next_state;
  end
  
  //Next state logic
  always@(*)
  begin
    next_state = IDLE;
    case(present_state)
        IDLE:
          begin
            if(Data_valid == 1'b1) 
               next_state = STR;
            else next_state = IDLE;
          end
        
        STR: next_state = DATA; 
        
        DATA:
          begin
            if(PAR_EN == 1'b1 && ser_done == 1'b1) 
               next_state = PARITY;
            else if (PAR_EN == 1'b0 && ser_done == 1'b1)
               next_state = STP;
            else next_state = DATA;
          end
          
        PARITY: next_state = STP;
        
        STP:
          begin
            if(Data_valid == 1'b1) 
               next_state = STR;
            else next_state = IDLE;
          end
          
        default: next_state = IDLE;
          
      endcase
  end
  
  //Output Logic
  always@(*)
  begin
    case(present_state)
        IDLE:
          begin
            ser_en = 1'b0;
            Busy = 1'b0;
            mux_sel = 2'b01;
          end
        
        STR:
          begin
            ser_en = 1'b1;
            Busy = 1'b1;
            mux_sel = 2'b00;
          end 
        
        DATA:
          begin
            ser_en = 1'b1;
            Busy = 1'b1;
            mux_sel = 2'b10;
          end
          
        PARITY:
          begin
            ser_en = 1'b0;
            Busy = 1'b1;
            mux_sel = 2'b11;
          end
        
        STP:
          begin
            ser_en = 1'b0;
            Busy = 1'b1;
            mux_sel = 2'b01;
          end
          
        default:
          begin
            ser_en = 1'b0;
            Busy = 1'b0;
            mux_sel = 2'b00;
          end
      endcase
  end
endmodule