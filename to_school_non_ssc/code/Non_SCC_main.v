`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 22:49:29
// Design Name: 
// Module Name: Non_SCC_main
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

module Div_n_Frequency(
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd500;//100000000;//50000000 // Qtion 1   524288 // Qtion 2 3670016
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module Non_SCC_main(
    input clk ,
    input data_in ,
    output reg [4:0]out_light
    );
    reg [2:0]Count ; // 5  
    wire o_clk ; 
    
    Div_n_Frequency Div_1(
    .clk(clk),
    .o_clk(o_clk)
    );
    
    initial begin 
        Count <= 3'd0 ;
    end 
    
    always @(posedge o_clk)begin
        if(data_in == 0 && Count == 0)  
            Count <= 1;      
        else if(Count > 0 && Count < 6 )begin  
            Count <= Count + 1'b1;    //cnt¤W¼Æ
            out_light[4] <= out_light[3];
            out_light[3] <= out_light[2];
            out_light[2] <= out_light[1];
            out_light[1] <= out_light[0]; 
            out_light[0] <= data_in;      
        end
        else if(Count == 6)    
            Count <= 3'b000;     
    end
endmodule
