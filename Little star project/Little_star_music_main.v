`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/05 23:13:39
// Design Name: 
// Module Name: Little_star_music_main
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


module Little_star_music_main(
    input clk , 
    output reg music_play
    );
    wire main_clk ; 
    wire play_clk ; 
    wire [8:1] music_code ; 
    
    reg [2:0] count_stop ; // 6
    reg [5:0] count_music_index ; // go to 41 index 
    reg [3:0] music_arr [41:0] ;  
    reg [3:0] get_code ; 
    initial begin 
        music_arr[41] <= 4'd1 ; music_arr[40] <= 4'd1 ; music_arr[39] <= 4'd5 ; music_arr[38] <= 4'd5 ;music_arr[37] <= 4'd6 ;music_arr[36] <= 4'd6 ;music_arr[35] <= 4'd5 ;
        music_arr[34] <= 4'd4 ; music_arr[33] <= 4'd4 ; music_arr[32] <= 4'd3 ; music_arr[31] <= 4'd3 ;music_arr[30] <= 4'd2 ;music_arr[29] <= 4'd2 ;music_arr[28] <= 4'd1 ;
        
        music_arr[27] <= 4'd5 ; music_arr[26] <= 4'd5 ; music_arr[25] <= 4'd4 ; music_arr[24] <= 4'd4 ;music_arr[23] <= 4'd3 ;music_arr[22] <= 4'd3 ;music_arr[21] <= 4'd2 ;
        music_arr[20] <= 4'd5 ; music_arr[19] <= 4'd5 ; music_arr[18] <= 4'd4 ; music_arr[17] <= 4'd4 ;music_arr[16] <= 4'd3 ;music_arr[15] <= 4'd3 ;music_arr[14] <= 4'd2 ;
        
        music_arr[13] <= 4'd1 ; music_arr[12] <= 4'd1 ; music_arr[11] <= 4'd5 ; music_arr[10] <= 4'd5 ;music_arr[9] <= 4'd6 ;music_arr[8] <= 4'd6 ;music_arr[7] <= 4'd5 ;
        music_arr[6] <= 4'd4 ; music_arr[5] <= 4'd4 ; music_arr[4] <= 4'd3 ; music_arr[3] <= 4'd3 ;music_arr[2] <= 4'd2 ;music_arr[1] <= 4'd2 ;music_arr[0] <= 4'd1 ;
        
        count_stop <= 3'd0 ; 
        count_music_index <= 6'd41 ; 
    end 
    
    
    
    Div_n_Frequency_main MAIN_clk(.clk(clk),.o_clk(main_clk));
    Div_n_Frequency_play PLAY_clk(.clk(clk),.o_clk(play_clk));

    Div_n_Frequency_C4 C4( .clk(clk), .o_clk(music_code[1]));
    Div_n_Frequency_D4 D4( .clk(clk), .o_clk(music_code[2]));
    Div_n_Frequency_E4 E4( .clk(clk), .o_clk(music_code[3]));
    Div_n_Frequency_F4 F4( .clk(clk), .o_clk(music_code[4]));
    Div_n_Frequency_G4 G4( .clk(clk), .o_clk(music_code[5]));
    Div_n_Frequency_A4 A4( .clk(clk), .o_clk(music_code[6]));
    Div_n_Frequency_B4 B4( .clk(clk), .o_clk(music_code[7]));
    Div_n_Frequency_C5 C5( .clk(clk), .o_clk(music_code[8]));
    
    always @(posedge main_clk) begin 
        count_stop <= count_stop + 1'd1 ; 
        if (count_stop == 1 ) begin 
            count_stop <= 3'd0 ; 
            get_code <= 4'd15; 
        end 
        else begin 
            count_music_index <= count_music_index - 1'd1 ;   
            if (count_music_index == 0 )begin 
                get_code <= music_arr[count_music_index] ; 
                count_music_index <= 6'd41 ;      
            end 
            else get_code <= music_arr[count_music_index] ; 
        end 
    end 
    always @(posedge play_clk) begin 
        case(get_code) 
            4'd15 : music_play <= 1'b0 ;  
            default :  music_play <= music_code[get_code] ;
        endcase 
    end
    
    
    
endmodule
