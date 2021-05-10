`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 19:34:11
// Design Name: 
// Module Name: PWM_use_switch
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


module PWM_use_switch(
     input clk ,
     
     input [6:0] PWM__Duty_Cycle , 
     
     output o_clk_JA1
    );
     PWM_Generator OUT(
    .clk(clk) , 
    .PWM__Duty_Cycle(PWM__Duty_Cycle) , 
    .PWM_o_clk (o_clk_JA1)
    );
endmodule
