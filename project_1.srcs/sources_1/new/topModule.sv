`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2017 07:48:34 AM
// Design Name: 
// Module Name: topModule
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

module Or(input logic x , input logic y , output logic z );
assign z = x | y;
endmodule

module mappingTable(input logic key_valid, input logic [3:0] key_value, output logic [3:0]out) ;

always@(key_valid)
      case(key_value)
      4'b0000: out<= 4'b1111;
      4'b0001: out<= 4'b1110;
      4'b0010: out<= 4'b1101;
      4'b0011: out<= 4'b1100;
      4'b0100: out<= 4'b1011;
      4'b0101: out<= 4'b1010;
      4'b0110: out<= 4'b1001;
      4'b0111: out<= 4'b1000;
      
      4'b1000: out<= 4'b0111;
      4'b1001: out<= 4'b0110;
      4'b1010: out<= 4'b0101;
      4'b1011: out<= 4'b0100;
      4'b1100: out<= 4'b0011;
      4'b1101: out<= 4'b0010;
      4'b1110: out<= 4'b0001;
      4'b1111: out<= 4'b0000;
      
     
  endcase    
endmodule

module topModule(input logic start_button,input logic reset,input logic clk,input logic [3:0]keyb_col, output logic [3:0] phases, output logic [3:0] keyb_row,output logic[3:0] an,
output logic a,output logic b,output logic c,output logic d,output logic e,output logic f,output logic g,output logic dp  );

logic key_valid;
logic [3:0] in3;
logic a,b,c,d,e,f,g,dp;
//logic[3:0] an, keyb_row , keyb_col,key_value;
logic [1:0] direction;
logic [1:0] rotation;  
//logic [3:0] phases;
//logic start ;
logic [3:0]in0;
logic [3:0]in1;
logic [3:0]in2;
logic [3:0] key_value;
logic start;
logic lfsr_clk;
logic [3:0]random;
logic [3:0]score;
logic [3:0] map_out;

lfsr generator(clk,0,in3);

steppermotor_wrapper  step(clk, random[1:0]  , random[3:2] , phases, start);
keypad4X4  key( clk, keyb_row,   keyb_col,  key_value,  key_valid );
mappingTable map(key_valid,key_value,map_out);

SevSeg_4digit SevSeg_4digit_inst0(
	.clk(clk),
	.in3(random), .in2(map_out), .in1(4'b000), .in0(score), //user inputs for each digit (hexadecimal)
	.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp), // just connect them to FPGA pins (individual LEDs).
	.an(an)   // just connect them to FPGA pins (enable vector for 4 digits active low) 
);

always@(posedge clk )

begin

if(reset ==1)
score <= 4'd0;

if( key_valid == 1)

begin
start <= 0;
random <= in3;

if(map_out == random)
begin
if(reset ==1)
score <= 4'd0;
else if ( score < 4'd9)
score <= score + 4'd1;

end

else 
begin

if(reset ==1)
score <= 4'd0;
else if (score > 4'd0)
score <= score - 4'd1;

end
end

if(start == 0 && start_button == 1)
start <= 1;


end
endmodule


