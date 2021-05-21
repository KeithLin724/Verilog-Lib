`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 17:42:39
// Design Name: 
// Module Name: Tb_noc_ssc_show
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


module Tb_noc_ssc_show();
    reg [4:0]count;
    reg clk;
    reg data;
    wire [4:0] odata;
    
    Non_SCC_main UUT(
    .clk(clk) ,
    .data_in(data) ,
    .out_light(odata)
    );
    
    initial begin
        clk =0;
        data=1'b1;
        count = 5'b0;
    end
    always #5 clk = ~clk;
    always #5000 begin
    count <= (count == 19) ?  5'b0:  count + 1'b1;
    case(count)
        0:data <=1'b1;
        1:data <=1'b0;
        2:data <=1'b1;
        
        3:data <=1'b1;
        4:data <=1'b0;
        5:data <=1'b0;
        6:data <=1'b1;
        
        7:data <=1'b0;
        8:data <=1'b1;
        9:data <=1'b1;
        10:data <=1'b0;
        
        11:data <=1'b0;
        12:data <=1'b1;
        13:data <=1'b0;
        14:data <=1'b1;
        
        15:data <=1'b1;
        16:data <=1'b0;
        17:data <=1'b1;
        18:data <=1'b1;
        
        19:data <=1'b1;
        endcase
    end
endmodule
