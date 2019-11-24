`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2017 07:50:22 AM
// Design Name: 
// Module Name: lfsr
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

module lfsr(
    input clock,
    input reset,
    output reg [3:0] result
    );  
    
    
      
    logic feedback;
    reg [15:0]out;
    
    assign feedback = ~( out[15] ^ out [10] ^ out [9] ^ out[5]);
    
    always @(posedge clock, posedge reset)
    begin
    if(reset)
    out = 16'b0;
    else
    out = {out[14:0],feedback};
    end
    assign result = out[3:0];
endmodule
