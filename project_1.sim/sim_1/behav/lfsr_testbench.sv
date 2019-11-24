`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2017 10:50:36 AM
// Design Name: 
// Module Name: lfsr_testbench
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


module lfsr_testbench();
logic clock, reset; 
logic [3:0]result;

lfsr(clock,reset,result);
always
begin
clock <= ~clock; #10;
end

initial begin
reset = 0; #100;
rsertt = 1; #100;
end


endmodule
