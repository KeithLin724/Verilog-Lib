`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 21:18:46
// Design Name: 
// Module Name: SS_display_ultra
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

module Seven_segment_display_ultra(
    input [7:0] light_on ,
    input [3:0] BCD ,
    input DP,  
    
    output [7:0]light_code,// lightcode on
    output reg [6:0] decode ,
    output DP_out
    
    );
    assign light_code = ~light_on ;  
    assign DP_out = ~DP;
    
    always @(BCD) begin 
        case (BCD)
        4'b0000:  decode = ~(7'b1111110);
        4'b0001:  decode = ~(7'b0110000);
        4'b0010:  decode = ~(7'b1101101);
        4'b0011:  decode = ~(7'b1111001);
        4'b0100:  decode = ~(7'b0110011);
        4'b0101:  decode = ~(7'b1011011);
        4'b0110:  decode = ~(7'b0011111);
        4'b0111:  decode = ~(7'b1110000);
        4'b1000:  decode = ~(7'b1111111);
        4'b1001:  decode = ~(7'b1110011); // 9 
        4'b1010:  decode = ~(7'b0000001); // 10 is - 
        4'b1011:  decode = ~(7'b0111110); // 11 is u  
        default:   decode = ~(7'b0000000);
        /*4'b1010:  decode = ~(7'b0001101);
        4'b1011:  decode = ~(7'b0011001);
        4'b1100:  decode = ~(7'b0100011);
        4'b1101:  decode = ~(7'b1001011);
        4'b1110:  decode = ~(7'b0001111);*/
       // 4'b1111:  decode = ~(7'b0000000);
        endcase 
    end    
endmodule

module Div_n_Frequency(
    input  clk,
   // input  rst_n,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd131233;// 762 hz
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1)) counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module SS_display_ultra(//1010 is - 
    input [31:0]data_BCD , 
    input clk ,
    input DP,
    
    output [7:0]light_code,// lightcode on
    output [6:0] decode ,
    output DP_out
    );
    
    wire [3:0] array [7:0] ; 
    wire O_clk ; 
    reg [7:0] Light_sigle = 8'b00000001;
    reg [3:0] Count = 4'b0 ; 
    assign {array [7] ,array [6] , array [5] , array [4] , 
    array [3] ,array [2] , array [1] , array [0] } = data_BCD ; // 32 bits to 8bytes 1 bytes = 4bits 
    
    Div_n_Frequency DIVto762(
        .clk(clk),
        .o_clk(O_clk)
    ) ; 
    
    always @(posedge O_clk)begin 
        Light_sigle[0] <= Light_sigle[7];
        Light_sigle[1] <= Light_sigle[0];
        Light_sigle[2] <= Light_sigle[1];
        Light_sigle[3] <= Light_sigle[2];
        Light_sigle[4] <= Light_sigle[3];
        Light_sigle[5] <= Light_sigle[4];
        Light_sigle[6] <= Light_sigle[5];
        Light_sigle[7] <= Light_sigle[6];
        case (Light_sigle)  
           8'b00000001 : Count = 4'b0001 ; 
           8'b00000010 : Count = 4'b0010 ;
           8'b00000100 : Count = 4'b0011 ;
           8'b00001000 : Count = 4'b0100 ;
           8'b00010000 : Count = 4'b0101 ;
           8'b00100000 : Count = 4'b0110 ;
           8'b01000000 : Count = 4'b0111 ;
           8'b10000000 : Count = 4'b1000 ;
       endcase
    end 
      
    Seven_segment_display_ultra SS_ultra(
        .light_on(Light_sigle),
        .BCD(array[Count]),
        .DP(DP),

        .light_code(light_code),// lightcode on
        .decode(decode) ,
        .DP_out(DP_out)
    );
    
endmodule
