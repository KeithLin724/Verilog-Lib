`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 17:04:31
// Design Name: 
// Module Name: tb_ssc_show
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


module tb_ssc_show();
    reg iclk ; 
    reg idata ; 
    
    wire chk_light ; 
    wire [3:0] odata ; 
    
    SSC_main SSC(
    .clk_main(iclk) , 
    .data_in(idata) , 
    
    .out_light(odata) , 
    .success_light(chk_light) 
    );
    initial begin 
        iclk = 1'b0 ; 
        
        #10 
        idata = 1'b1 ; 
        #10 
        idata = 1'b1 ;
        #10 
        idata = 1'b0 ;
        #10 
        idata = 1'b1 ;
        
        #10 
        idata = 1'b1 ; 
        #10 
        idata = 1'b0 ;
        #10 
        idata = 1'b0 ;
        #10 
        idata = 1'b0 ;
        
        #10 
        idata = 1'b0 ; 
        #10 
        idata = 1'b1 ;
        #10 
        idata = 1'b1 ;
        #10 
        idata = 1'b1 ;
        
    end
    always #5 iclk = ~iclk ; 
    
endmodule
