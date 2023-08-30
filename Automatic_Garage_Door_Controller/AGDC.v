//Automatic Garage Door Controller with Moore Finite state machine
module AGDC(
  //Sensor - User - Sensor
  input UP_Max, Activate, DN_Max,
  input CLK, RST,
  //Up and Down motors
  output reg UP_M, DN_M
);
 
 reg [1:0] present_state, next_state;
 
 parameter IDLE = 2'b00;
 parameter Mv_Up = 2'b01;
 parameter Mv_Dn = 2'b10;
 
 always@(posedge CLK or negedge RST)
 begin
   if(!RST)
     present_state <= IDLE;
   else present_state <= next_state;
 end
 
 always@(*)
 begin
   if(!RST)
     begin
     present_state = IDLE;
     UP_M = 0;
     DN_M = 0;
     end
   else
    begin
      case(present_state)
        IDLE: begin
                UP_M = 0;
                DN_M = 0;
                if(!Activate)
                  next_state = IDLE;
                
                else if (Activate & DN_Max & !UP_Max)
                  next_state = Mv_Up;
                  
                else if (Activate & !DN_Max & UP_Max)
                  next_state = Mv_Dn;
                 
                else next_state = IDLE;
              end
        
        Mv_Up: begin
                UP_M = 1;
                DN_M = 0;
                if(UP_Max)
                  next_state = IDLE;
                 
                else next_state = Mv_Up;
               end
        
        Mv_Dn: begin
                UP_M = 0;
                DN_M = 1;
                if(DN_Max)
                  next_state = IDLE;
                 
                else next_state = Mv_Dn;
               end 
               
        default: begin
                  UP_M = 0;
                  DN_M = 0;
                  next_state = IDLE;        
                 end
        
      endcase
    end
 end

endmodule