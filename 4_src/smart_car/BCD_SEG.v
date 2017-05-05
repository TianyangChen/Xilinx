`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:29 12/30/2014 
// Design Name: 
// Module Name:    BCD_SEG 
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
module BCD_SEG(BCD,SEL_IN,SEG,SEL_OUT);
	input [3:0] BCD;
	input [1:0] SEL_IN;
	output [7:0] SEG;
	output [3:0] SEL_OUT;
	reg [7:0] SEG;
	always @(BCD)
		begin
			case(BCD)
			4'd0:SEG=8'b00000011; //显示 0，需要 00000011
			4'd1:SEG=8'b10011111;
			4'd2:SEG=8'b00100101;
			4'd3:SEG=8'b00001101;
			4'd4:SEG=8'b10011001;
			4'd5:SEG=8'b01001001;
			4'd6:SEG=8'b01000001;
			4'd7:SEG=8'b00011111;
			4'd8:SEG=8'b00000001;
			4'd9:SEG=8'b00011001;
			4'b1010:SEG=8'b00010001;
			4'b1011:SEG=8'b11000001;
			4'b1100:SEG=8'b01100011;
			4'b1101:SEG=8'b10000101;
			4'b1110:SEG=8'b01100001;
			4'b1111:SEG=8'b01110001;
			default:SEG=8'b11111111;
			endcase
		end
	assign SEL_OUT[0]=~((~SEL_IN[1])&&(~SEL_IN[0]));//SEL_IN 信号为 0：输出为 1110
	assign SEL_OUT[1]=~((~SEL_IN[1])&&(SEL_IN[0]));
	assign SEL_OUT[2]=~((SEL_IN[1])&&(~SEL_IN[0]));
	assign SEL_OUT[3]=~((SEL_IN[1])&&(SEL_IN[0]));
endmodule
