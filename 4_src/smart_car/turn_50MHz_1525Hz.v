`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:22 12/30/2014 
// Design Name: 
// Module Name:    turn_50MHz_1525Hz 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module turn_50MHz_1525Hz(clk_in, clk_out);
	input clk_in;
	output clk_out;
	reg [14:0] count=0;//set a counter, when it becomes 8096, output high level
	always @(posedge clk_in) 
		count=count+1;
	assign clk_out=count[14];
endmodule
