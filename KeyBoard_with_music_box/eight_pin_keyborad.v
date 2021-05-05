`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/04 21:01:30
// Design Name: 
// Module Name: eight_pin_keyborad
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

// only one number
module eight_pin_keyborad(
    input clk ,
    input  [2:0] in_key , //  EFG  pin
    output reg [3:0] out_singal , // ABCD  pin 
    
    output reg [3:0] out_code_number
    );

    wire o_clk ; 
    reg is_in_data ; // is in data ? 
    //reg [3:0] out_code_number_r ; 
    
    
    Div_n_Frequency_keyboard Div_1000 (
       .clk(clk) , 
       .o_clk(o_clk)
    ) ; 
    
    initial begin 
        out_singal <= 4'b1000 ; 
        is_in_data <= 1'b0 ; 
        //out_code_number_r <= 4'b1111 ;
        
    end 
    always @(posedge o_clk) begin 
        out_singal [3] <= out_singal [0] ;
        out_singal [2] <= out_singal [3] ;
        out_singal [1] <= out_singal [2] ;
        out_singal [0] <= out_singal [1] ;
    end 
    
    always @(in_key , out_singal) begin  // posedge o_clk
        case (in_key) 
            3'b100  : begin 
                case (out_singal)
                    4'b1000 : begin  is_in_data <= 1'b1 ;  out_code_number <= 4'b0001 ;  end // '1'                    
                    4'b0100 : begin  is_in_data <= 1'b1 ;  out_code_number <= 4'b0100 ;  end// '4'
                    4'b0010 : begin is_in_data <= 1'b1 ;  out_code_number <= 4'b0111 ; end //'7'
                    4'b0001 : begin is_in_data <= 1'b1 ;  out_code_number <= 4'b1100 ;  end// '*' -> '12' // dont touch dp 

                endcase 
            end 
            
            3'b010  : begin 
                case (out_singal)
                    4'b1000 : begin  is_in_data <= 1'b1 ;  out_code_number <= 4'b0010 ;  end // '2'                  
                    4'b0100 : begin  is_in_data <= 1'b1 ; out_code_number <= 4'b0101;   end // '5'                   
                    4'b0010 : begin  is_in_data <= 1'b1 ;  out_code_number <= 4'b1000 ;  end // '8'                
                    4'b0001 : begin  is_in_data <= 1'b1 ; out_code_number <= 4'b0000 ;  end // '0'
                endcase
            end 
            
            3'b001  : begin 
                case (out_singal)
                    4'b1000 : begin  is_in_data <= 1'b1 ; out_code_number <= 4'b0011;end // '3'                   
                    4'b0100 : begin is_in_data <= 1'b1 ;  out_code_number <= 4'b0110;end // '6'                  
                    4'b0010 : begin is_in_data <= 1'b1 ; out_code_number <= 4'b1001 ;end //'9'                    
                    4'b0001 : begin is_in_data <= 1'b1 ; out_code_number <= 4'b1011 ;end // # -> '11' -> u 
                endcase
            end 
            default : begin is_in_data <= 1'b0 ; out_code_number <= 4'b1111 ;end // no key in 
            
        endcase
    end 
    //always @(in_key , out_singal) begin 
        //out_code_number <= out_code_number_r ; 
       /* if (is_in_data)begin 
             out_code_number <= out_code_number_r ;  
        end 
        else begin 
            out_code_number <= 4'b1111 ;  
        end */
     //out_code_number <= out_code_number_r ;  
        /*if (is_in_data) begin  // open save 
            out_code_number <= out_code_number_r ;  
        end 
        
        else begin 
            out_code_number <= out_code_number ; 
        end */
    //end 
     
    
    
endmodule






