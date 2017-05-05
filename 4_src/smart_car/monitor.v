`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:22 12/30/2014 
// Design Name: 
// Module Name:    monitor 
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
module	monitor(clk_in,reset,moshi,infrared_sensor,pwm_right,pwm_right2,pwm_left,pwm_left2,led_out,seg,sel_out,chaotime,chaoimpulse,qianhou);
	input clk_in;
	input reset,chaotime,moshi;
	input [2:0] infrared_sensor;
	output pwm_right,pwm_right2,pwm_left,pwm_left2,chaoimpulse;
	output [3:0] qianhou;
	output [7:0]led_out,seg;
	reg [7:0] led_out;
	reg [3:0] qianhou;
	wire [7:0] seg;
	output [3:0] sel_out;
	wire pwm_left,pwm_left2,pwm_right,pwm_right2,clk_out,chaoimpulse,backward;
	wire has_obstruction;
	reg [4:0] zhankongbi_right,zhankongbi_right2,zhankongbi_left,zhankongbi_left2;
	always @(posedge clk_out)//ÿ clk_out�� 1525Hz���������������¶���
		begin
			if(reset)//reset Ϊ 1 ������г�ʼ��
				begin
					zhankongbi_right=0;
					zhankongbi_right2=0;
					zhankongbi_left=0;
					zhankongbi_left2=0;
					led_out[7:0]=8'b00000000;
				end
			else if(!moshi)//ģʽ����Ϊ 0�����պ����ߣ��ú����߼������
				begin
					qianhou=4'b0000;
					case(infrared_sensor[2:0])//�����߼�⵽������
					3'b010:	begin //�м�ļ��ܼ�⣬��ֱ��
									qianhou=4'b0000;
									zhankongbi_right=31;
									zhankongbi_left=31;
									zhankongbi_right2=31;
									zhankongbi_left2=31;
									led_out=8'b0000_0000;
								end
						
					3'b001,3'b011:	begin //��Ҫ���ҹգ����ַ�ת��������ת
											qianhou=4'b1010;
											zhankongbi_right=0;
											zhankongbi_right2=0;
											zhankongbi_left=31;
											zhankongbi_left2=31;
											led_out=8'b00000011;
										end
					3'b100,3'b110:	begin//��Ҫ����գ�������ת�����ַ�ת
											qianhou=4'b0101;
											zhankongbi_right=31;
											zhankongbi_right2=31;
											zhankongbi_left=0;
											zhankongbi_left2 =0;
											led_out=8'b11000000;
										end
					3'b000:	begin //ʲô��û��⵽��ͣ�����
										qianhou=4'b0000;
										zhankongbi_right=0;
										zhankongbi_right2=0;
										zhankongbi_left=0;
										zhankongbi_left2=0;
										led_out=8'b1111_1111;
									end
					default:	begin//���������������
									qianhou=4'b0000;
									zhankongbi_right=31;
									zhankongbi_right2=31;
									zhankongbi_left=31;
									zhankongbi_left2=31;
								end
					endcase
				end
			else if(moshi)
				begin
					if(has_obstruction==1&&backward==1)
						begin// ���ϰ����Ҫ���ˣ� qianhou ���ó� 1111
							qianhou=4'b1111;
							zhankongbi_right=10;
							zhankongbi_left=10;
							zhankongbi_right2=10;
							zhankongbi_left2=10;
							led_out=8'b1111_1111;
						end
					else if(has_obstruction==1&&backward==0)
						begin//���ϰ��ֻ��Ҫת�������ڼ�ת��һ����ǰ����һ������ת��
							qianhou=4'b1010; 
							zhankongbi_right=0;
							zhankongbi_left=31;
							zhankongbi_right2=0;
							zhankongbi_left2=31;
							led_out=8'b1111_0000;
						end
					else
						begin// û�������ϰ����ǰת
							qianhou=4'b0000;
							zhankongbi_right=31;
							zhankongbi_left=31;
							zhankongbi_right2=31;
							zhankongbi_left2=31;
							led_out=8'b0000_0000;
						end
				end
		end//���ø�ģ��
	turn_50MHz_1525Hz clk_bianhuan(clk_in,clk_out);
	chao ch(clk_in,chaotime,chaoimpulse,seg,sel_out,has_obstruction,backward);
	PWM motor_right(clk_in,reset,zhankongbi_right,pwm_right);
	PWM motor_left(clk_in,reset,zhankongbi_left,pwm_left);
	PWM motor_right2(clk_in,reset,zhankongbi_right2,pwm_right2);
	PWM motor_left2(clk_in,reset,zhankongbi_left2,pwm_left2);
endmodule
