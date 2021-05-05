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


module Div_n_Frequency_C4 ( // 
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd382225;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_D4 ( // 
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd340524;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_E4 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd303372;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_F4 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd286345;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_G4 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd255106;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_A4 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd227272;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_B4 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd202475;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Div_n_Frequency_C5 (
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd191112;
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule



