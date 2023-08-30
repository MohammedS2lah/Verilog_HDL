`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2023 12:34:26 PM
// Design Name: 
// Module Name: moore_1101_detector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module moore_1101_detector(
    input clk,
    input reset_n,
    input x, 
    output reg y
    );
    
    reg [2:0] present_state, next_state;
    
    parameter [2:0] s0 = 3'b000;
    parameter [2:0] s1 = 3'b001;
    parameter [2:0] s2 = 3'b010;
    parameter [2:0] s3 = 3'b011;
    parameter [2:0] s4 = 3'b100;
    
    //State register
    always@(posedge clk, negedge reset_n)
      begin
        if(!reset_n)
            present_state <= s0;
        else  present_state <= next_state;
      end
    
    //Next state and output logic
    always@(*)
      begin
      if(!reset_n) begin
         present_state = s0;
         y=0;
         end
      else begin   
        case(present_state)
            s0: begin
                y=0;
                $display(present_state);
                if(x)
                  next_state = s1;
                else next_state = s0;                    
                end
            
            s1: begin
                y=0;
                $display(present_state);
                if(x)
                  next_state = s2;
                else next_state = s0;    
                end
            
            s2: begin
                y=0;
                $display(present_state);
                if(x)
                  next_state = s2;
                else next_state = s3;            
                end
            
            s3: begin
                y=0;
                $display(present_state);
                if(x)
                  begin
                  next_state = s4;
                  end
                else next_state = s0;            
                end
            
            s4: begin
                y=1;
                $display(present_state);
                if(x)
                begin
                    next_state = s1;
                end
                else next_state = s0;            
                end
                
            default: begin 
                     y=0;
                     $display(present_state);
                     next_state = present_state;
                     
                     end                  
          
        endcase
        end
      end
endmodule