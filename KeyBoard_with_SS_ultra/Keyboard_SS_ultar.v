`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/05 19:03:55
// Design Name: 
// Module Name: Keyboard_SS_ultar
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


module Keyboard_SS_ultar(
    input clk ,
    input  [2:0] in_key , //  EFG  pin
    output [3:0] out_singal , // ABCD  pin
    
    output [7:0]light_code,// lightcode on
    output [6:0] decode ,
    output DP_out
    );
    
    wire[3:0]out_code_number ; 
    reg DP = 1'b0; 
    reg [7:0]light_on = 8'b00000001 ; // set light code 
    
    eight_pin_keyborad EPK(
    .clk(clk) ,
    .in_key(in_key) , //  EFG  pin
    .out_singal(out_singal) , // ABCD  pin 
    
    .out_code_number(out_code_number)
    );
    
    always @(out_code_number) begin 
        if (out_code_number == 12) begin 
            DP <= 1'b1 ; 
        end 
        else begin 
            DP <= 1'b0 ; 
        end 
    end 
    Seven_segment_display_ultra SS_U(
    .light_on(light_on) ,
    .BCD(out_code_number) ,
    .DP(DP),  
    
    .light_code(light_code),// lightcode on
    .decode(decode) ,
    .DP_out(DP_out)
    
    );
    
    
endmodule
