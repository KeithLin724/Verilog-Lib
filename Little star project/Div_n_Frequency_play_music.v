`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/16 11:22:11
// Design Name: 
// Module Name: Div_n_Frequency
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


module Div_n_Frequency_play(
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd16;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule
