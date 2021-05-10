`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/09 23:54:10
// Design Name: 
// Module Name: PWM_Generator
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

module Div_n_Frequency_Plus(
    input  clk,
    input [27:0]DIVISOR,
    output reg  o_clk
    );
    reg[27:0] counter=28'd0;
    //parameter DIVISOR = 28'd2;//50MHz
    always @(posedge clk) begin
    counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
        counter <= 28'd0;
    o_clk <= (counter<DIVISOR/2)?1'b1:1'b0;
    end
    
endmodule

module PWM_Generator(
    input clk , 
    input [6:0]PWM__Duty_Cycle , // 0 to 100 level; 
    output reg PWM_o_clk 
    );
    
    reg [6:0]PWM__Duty_Cycle_in ;  
    //reg [27:0]D_Frequency = 28'd200000 ; // 500Hz // 10**8 / ( f * 100 )
    reg [27:0]D_Frequency_x100 = 28'd2000 ; // 50000MHz 
    reg [6:0] Count ; 
    wire o_clk_tran ; 
    
    initial begin 
        Count <= 7'd0 ; 
    end
    
    always @(PWM__Duty_Cycle)begin 
        PWM__Duty_Cycle_in  <= PWM__Duty_Cycle ; // train 
        if (PWM__Duty_Cycle > 100) 
            PWM__Duty_Cycle_in <= 7'd100;
    end

    Div_n_Frequency_Plus DivTo_50000(
    .clk(clk),
    .DIVISOR(D_Frequency_x100) , 
    .o_clk(o_clk_tran)
    );
    
    always @(posedge o_clk_tran) begin
        if(Count < 100)
            Count <= Count + 28'd1;
        else 
            Count <= 28'd0;
        PWM_o_clk <= (Count < PWM__Duty_Cycle_in)?1'b1:1'b0;
    end
endmodule

