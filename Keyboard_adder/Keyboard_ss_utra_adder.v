`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 15:44:46
// Design Name: 
// Module Name: Keyboard_ss_utra_adder_main
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

module Keyboard_ss_utra_adder_main(
    input clk , // main clk 
    input add_sig_show , // add sig 
    input clr , // clear ans a ,b 
    input switch , // switch a b 
    
    input  [2:0] in_key , //  EFG  pin
    output [3:0] out_singal , // ABCD  pin 
    
    output [7:0]light_code,// lightcode on
    output [6:0] decode ,
    output DP_out
    );
    reg DP ; 
    reg [4:0]ans ; // 0 to 18 
    reg [3:0]show_num_data[1:0] ; // show number use 
    reg [3:0]ab_number[1:0] ; // ab input 
    wire [3:0]input_num ; 
    wire get_data_states;
    wire o_clk ; 
   
    reg [3:0] data_2D[5:0] ; // to ss_ultra 
    wire [31:0]to_SS_ultra ;  
    
    initial begin 
        DP <= 1'b0 ;  
        ab_number [1] <= 4'd0 ; 
        ab_number [0] <= 4'd0 ;
        show_num_data[1] <= 4'b1111 ; 
        show_num_data[0] <= 4'b1111 ; 
        data_2D[5] <= 4'b1111 ; 
        data_2D[4] <= 4'b1111 ;
        data_2D[3] <= 4'b1111 ;
        data_2D[2] <= 4'b1111 ;
        data_2D[1] <= 4'b1111 ;
        data_2D[0] <= 4'b1111 ;
        ans <= 5'd0;
    end
     
    eight_pin_keyborad EPK_adder(
    .clk(clk) ,
    .in_key(in_key) , //  EFG  pin
    .out_singal(out_singal) , // ABCD  pin 
    
    .out_code_number(input_num), // input a and b 
    .out_data_stats(get_data_states)
    );
    
   Div_n_Frequency_keyboard Div_1000_2 (
       .clk(clk) , 
       .o_clk(o_clk)
    ) ;  
     
   always @(posedge o_clk) begin 
        if (clr == 1) begin 
            ab_number [1] <= 4'b0000 ; 
            ab_number [0] <= 4'b0000 ;
            ans <= 5'd0;
            show_num_data[1] <= 4'b1111; 
            show_num_data[0] <= ab_number [switch] ; 
        end 
        else begin 
            if (add_sig_show == 1) begin 
                ans <= ab_number[0] + ab_number[1] ; //show 
                if (ans <= 9) begin 
                    show_num_data[1] <= 4'b1111; 
                    show_num_data[0] <= ans ;
                end 
                else begin 
                    show_num_data[1] <= 4'b0001; 
                    show_num_data[0] <= ans % 10 ;
                end 
           end 
           else begin // show ab 
                 show_num_data[1] <= 4'b1111; 
                 //show_num_data[0] <= ab_number [switch] ; 
                  if (get_data_states) begin 
                    ab_number [switch] <= input_num ; 
                    show_num_data[0] <= ab_number [switch] ; 
                 end 
                 show_num_data[0] <= ab_number [switch] ;
           end
        end 
    end 
    
    
    assign to_SS_ultra = {data_2D[5] , data_2D[4] , data_2D[3] , data_2D[2] , data_2D[1] , data_2D[0] ,show_num_data[1] , show_num_data[0] } ; // to SS_ultra  
    SS_display_ultra SS_U(//1010 is - 
    .data_BCD(to_SS_ultra) , 
    .clk(clk) ,
    .DP(DP),
    
    .light_code(light_code),// lightcode on
    .decode(decode) ,
    .DP_out(DP_out)
    );
    
endmodule

 /* if (get_data_states) begin 
                    ab_number [switch] <= input_num ; 
                    show_num_data[0] <= ab_number [switch] ; 
                 end 
                 else begin 
                    show_num_data[0] <= ab_number [switch] ; 
                 end */
