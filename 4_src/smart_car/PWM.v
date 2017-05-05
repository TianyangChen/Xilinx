`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:29 12/30/2014 
// Design Name: 
// Module Name:    PWM 
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
module PWM(clk_in, reset, zhankongbi, pwm);
	input clk_in;
	input reset;
	input [3:0] zhankongbi;
	output pwm;
	reg [4:0] count;
	reg pwm;
	wire clk_out;
	turn_50MHz_1525Hz func(clk_in,clk_out);//��������任ģ�飬�� 1525Hz
	always @(posedge clk_out)
		begin
			if(reset)pwm=0;
			else
				begin
					if(count<zhankongbi)pwm=1;//count �� 0 ������ 30��ֻ�ڱ�zhankongbiС��ʱ����� 1���������0,�������������Ϊ1525/30
					else pwm=0; 
					if(count<30) count=count+1; 
					else count=0;
				end
		end
endmodule
