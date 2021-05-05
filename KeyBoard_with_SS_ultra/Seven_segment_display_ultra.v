`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 12:19:09
// Design Name: 
// Module Name: Seven_segment_display_main
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
