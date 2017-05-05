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
	turn_50MHz_1525Hz func(clk_in,clk_out);//调用脉冲变换模块，得 1525Hz
	always @(posedge clk_out)
		begin
			if(reset)pwm=0;
			else
				begin
					if(count<zhankongbi)pwm=1;//count 从 0 计数到 30，只在比zhankongbi小的时候输出 1，否则输出0,其输出脉冲周期为1525/30
					else pwm=0; 
					if(count<30) count=count+1; 
					else count=0;
				end
		end
endmodule
