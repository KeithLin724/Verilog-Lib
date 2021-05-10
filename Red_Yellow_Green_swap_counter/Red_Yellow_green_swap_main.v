`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 21:44:20
// Design Name: 
// Module Name: Red_Yellow_green_swap_main
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


module Red_Yellow_green_swap_main(
    input clk ,

    output [7:0]light_code,// lightcode on
    output [6:0] decode ,
    output DP_out,
    
    output reg [2:0] RGB 
    );
    reg DP = 1'b0 ; 
    reg [31:0]To_SS_code_line ; 
    reg [3:0] BCD_code [7:0] ; 
    
    reg [27:0] To_one = 28'd100000000;
    reg [3:0] Count ; 
    reg shift ; 
    reg [3:0] change_time_show[1:0] ; 
    wire o_clk;
    
    initial begin 
        BCD_code[7] <= 4'b1111 ; 
        BCD_code[6] <= 4'b1111 ; 
        BCD_code[5] <= 4'b1111 ; 
        BCD_code[4] <= 4'b1111 ; 
        BCD_code[3] <= 4'b1111 ; 
        BCD_code[2] <= 4'b1111 ; 
        //1 and zero is show 
        Count <= 4'd10 ; 
        shift <= 1'b0 ; 
        RGB <= 3'b100 ; 
    end 
    
    Div_n_Frequency_Plus Div_to_1( .clk(clk), .DIVISOR(To_one), .o_clk(o_clk) );
    
    always @(posedge o_clk) begin 
        if (Count == 1 ) begin 
            case (RGB) 
                3'b100 : begin 
                    shift <= 1'b0 ; 
                    Count <= 4'd5 ; 
                    RGB <= 3'b110 ;
                end 
                3'b110 : begin 
                    Count <= 4'd10 ;
                    if (shift)  RGB <= 3'b100 ;
                    else  RGB <= 3'b010 ;
                end 
                
                3'b010 : begin 
                
                    shift <= 1'b1 ; 
                    Count <= 4'd5 ; 
                    RGB <= 3'b110 ;
                    
                end 
            endcase
        end 
        else begin 
            Count <= Count - 4'd1 ;
        end 
    end
    
    always @(Count)begin 
        if (Count > 9)begin 
            change_time_show[1] <= 4'b0001 ; 
            change_time_show[0] <= 4'b0000 ; 
        end 
        else begin 
            change_time_show[1] <= 4'b0000 ; 
            change_time_show[0] <= Count ; 
        end 
        To_SS_code_line <= {BCD_code[7] , BCD_code[6] , BCD_code[5] , BCD_code[4] , 
            BCD_code[3] , BCD_code[2] ,change_time_show[1] , change_time_show[0]} ; 
    end
    // output 
    SS_display_ultra SS_display (//1010 is - 
        .data_BCD(To_SS_code_line) , 
        .clk(clk) ,
        .DP(DP),
        
        .light_code(light_code),// lightcode on
        .decode(decode) ,
        .DP_out(DP_out)
    );
    
    
endmodule
