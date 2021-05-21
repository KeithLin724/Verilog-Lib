`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 20:42:13
// Design Name: 
// Module Name: SSC_main
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
// PORT DEFINITION
// clk_src: clock source, i.e. pin E3
// isExp1: A switch. True for exp1 signal, False for exp2 signal
// clk: A Pmod pin. synchronous clock signal in exp1
// data_in: A Pmod pin. send streaming data to your circuit
// data_chk: A LED. real time data status indicator
// clk_chk: A LED. real time testbench internal clock signal indicator

// WARNING: CREATE A XDC FILE FOR NEXYS4 DDR BEFORE YOUR IMPLEMENTATION
// WARNING: THESE PATTERNS MAY NOT BE APPLIED ON DEMO DAY

/*module testbench_10(
	input clk_src,     // bulit-in clk = E3 // y
	input isExp1,      // select between exp1 and epx2, J15  // y 
	output clk,        //  clock signal for exp1, G17
	output data_in,    //  streaming data signal, H14
	output data_chk,   //  real-time data indicator, V11
	output clk_chk     //  real-time circuit clock indicator, V12
    );*/

module SSC_main(
    input clk_main , 
    input data_in , 
    
    output [3:0] out_light , 
    output reg success_light 
    );
    
    reg [3:0]save_data_in  ; 
    initial begin 
        save_data_in <= 4'b0000 ; 
    end 
   
    always @(posedge clk_main)begin 
        save_data_in[3] <=  save_data_in[2] ; 
        save_data_in[2] <=  save_data_in[1] ; 
        save_data_in[1] <=  save_data_in[0] ; 
        save_data_in[0] <=  data_in ; 
    end 
    
    always @(save_data_in)begin 
        if (save_data_in == 4'b1011)
            success_light <= 1'b1 ; 
        else  
            success_light <= 1'b0 ;
    end 
    
    assign out_light = save_data_in ; 
    
    
endmodule
