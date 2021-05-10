`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 19:50:36
// Design Name: 
// Module Name: change_color_PWM
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


module change_color_PWM(
    input clk , 
    output [2:0]RGB  
    );
    reg [6:0] RGB_Count [2:0] ;
    wire main_clk ;
    reg [27:0]Div_2000000 = 28'd5000000;//2000000 ;  
    
    Div_n_Frequency_Plus DivTo_2000000 (
    .clk(clk),
    .DIVISOR(Div_2000000),
    .o_clk(main_clk)
    ); 
    initial begin 
        RGB_Count[2] <= 7'd50 ;
        RGB_Count[1] <= 7'd0 ;
        RGB_Count[0] <= 7'd0 ;
    end
    
    PWM_Generator Red(
        .clk(clk) , 
        .PWM__Duty_Cycle(RGB_Count[2]) , 
        .PWM_o_clk (RGB[2])
    );
    
    PWM_Generator Green(
        .clk(clk) , 
        .PWM__Duty_Cycle(RGB_Count[1]) , 
        .PWM_o_clk (RGB[1])
    );
    
    PWM_Generator Blue(
        .clk(clk) , 
        .PWM__Duty_Cycle(RGB_Count[0]) , 
        .PWM_o_clk (RGB[0])
    );
    
    always @(posedge main_clk) begin
        if (RGB_Count[2] > 0 && RGB_Count[1] != 50 && RGB_Count[0] == 0 ) begin 
            RGB_Count[2] <= RGB_Count[2] - 7'd1 ; 
            RGB_Count[1] <= RGB_Count[1] + 7'd1 ;
        end 
        else if (RGB_Count[2] == 0 && RGB_Count[1] > 0 && RGB_Count[0] != 50 ) begin 
            RGB_Count[1] <= RGB_Count[1] - 7'd1 ; 
            RGB_Count[0] <= RGB_Count[0] + 7'd1 ;
        end 
        else if (RGB_Count[2] != 50 && RGB_Count[1] == 0 && RGB_Count[0] > 0 ) begin 
            RGB_Count[0] <= RGB_Count[0] - 7'd1 ; 
            RGB_Count[2] <= RGB_Count[2] + 7'd1 ;
        end 
        
    end
    
    
    
endmodule
