`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/05 21:09:28
// Design Name: 
// Module Name: KeyBoard_speaker
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


module KeyBoard_speaker(
    input clk ,
    input  [2:0] in_key , //  EFG  pin
    output [3:0] out_singal , // ABCD  pin 
    
    output reg music  
    );
    wire [3:0] get_keyboard_code; 
    wire [8:1] music_code ; 
    
    Div_n_Frequency_C4 C4( .clk(clk),.o_clk(music_code[1]));
    Div_n_Frequency_D4 D4( .clk(clk), .o_clk(music_code[2]));
    Div_n_Frequency_E4 E4( .clk(clk),.o_clk(music_code[3]));
    Div_n_Frequency_F4 F4( .clk(clk),.o_clk(music_code[4]));
    Div_n_Frequency_G4 G4( .clk(clk), .o_clk(music_code[5]));
    Div_n_Frequency_A4 A4( .clk(clk),.o_clk(music_code[6]));
    Div_n_Frequency_B4 B4( .clk(clk),.o_clk(music_code[7]));
    Div_n_Frequency_C5 C5( .clk(clk),.o_clk(music_code[8]));
    
    eight_pin_keyborad EPK (
    .clk(clk) ,
    .in_key(in_key) , //  EFG  pin
    .out_singal(out_singal) , // ABCD  pin 
    
    .out_code_number(get_keyboard_code)
    );
    
    always @(get_keyboard_code) begin 
        case (get_keyboard_code)
            4'b0001 : music <= music_code[1] ; 
            4'b0010 : music <= music_code[2] ; 
            4'b0011 : music <= music_code[3] ; 
            4'b0100 : music <= music_code[4] ; 
            4'b0101 : music <= music_code[5] ; 
            4'b0110 : music <= music_code[6] ; 
            4'b0111 : music <= music_code[7] ; 
            4'b1000 : music <= music_code[8] ; 
            default : music <= 1'b0 ; 
        endcase 
    end 
    
endmodule
