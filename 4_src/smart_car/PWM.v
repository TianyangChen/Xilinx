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
	turn_50MHz_1525Hz func(clk_in,clk_out);//call pulse transformation module, we wil get a 1525Hz pulse signal
	always @(posedge clk_out)
		begin
			if(reset)pwm=0;
			else
				begin
					if(count<zhankongbi)pwm=1;//count starts from 0 to 30£¬only when it is smaller than Duty cycle ouput 1, else output 0, its period is 1525/30
					else pwm=0; 
					if(count<30) count=count+1; 
					else count=0;
				end
		end
endmodule
