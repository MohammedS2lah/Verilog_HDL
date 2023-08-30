`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2023 12:33:52 PM
// Design Name: 
// Module Name: mealy_1101_detector
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


module mealy_1101_detector(
    input clk,
    input reset_n,
    input x, 
    output reg y
    );
    
    reg [1:0] present_state, next_state;
    
    parameter [1:0] s0 = 2'b00;
    parameter [1:0] s1 = 2'b01;
    parameter [1:0] s2 = 2'b10;
    parameter [1:0] s3 = 2'b11;
    
    
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
                
                $display(present_state);
                if(x)
                  begin
                  next_state = s1;
                    y = 1; 
                  end
                else begin
                 next_state = s0;
                 y=0;
                 end            
                end
                
            default: begin 
                     y=0;
                     $display(present_state);
                     next_state = present_state;
                     
                     end                  
          
        endcase

      end
    
endmodule