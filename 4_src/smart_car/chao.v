`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:09 12/30/2014 
// Design Name: 
// Module Name:    chao 
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
  module	chao(clk_in,chaotime,chaoimpulse,seg,sel_out,has_obstruction,backward);
	input clk_in;
	input chaotime;
	output chaoimpulse;
	output has_obstruction,backward;
	output [7:0] seg;
	output [3:0] sel_out;
	reg [12:0] count;
	reg [13:0] count_1;
	reg [15:0] BCD,jieguo;
	reg chaoimpulse,chao_clk,temp;
	reg backward,has_obstruction;
	integer devided;
	always @(posedge clk_in)
		begin
			count=count+1;
			if(count>735)chao_clk=1;
			if(count>1469)
				begin
					chao_clk=0;
					count=0;
				end
		end
	always @(posedge chao_clk)
		begin
			count_1=count_1+1;
			if(count_1>2500)count_1=0;
			if(count_1==1)chaoimpulse=1;
			else chaoimpulse=0;
			if(chaotime==1)
				begin
				temp=~temp;
				if(temp==1)
					begin//一位一位的加上去
						BCD[3:0]=BCD[3:0]+1; //
						if(BCD[3:0]>9) //
							begin //
								BCD[3:0]=0; //
								BCD[7:4]=BCD[7:4]+1; //
								if(BCD[7:4]>9) //
									begin //
										BCD[7:4]=0; //
										BCD[11:8]=BCD[11:8]+1; //
										if(BCD[11:8]>9) //
											begin //
												BCD[11:8]=0; //
												BCD[15:12]=BCD[15:12]+1; //
												if(BCD[15:12]>9)BCD[15:12]=0; //
											end //
									end //
							end //
					end
				end
			else
				begin
					if(BCD!=0)
						begin
							jieguo=BCD;//chaotime 为 0 的时候，将加到的数据送给 jieguo
							if(jieguo[7:4]>2)has_obstruction=0;//判断是否要后退或急转
							else if((jieguo[7:4] <3)&&(jieguo[11:8]==0))
								begin
									has_obstruction=1;
									if(jieguo[7:4]==0)backward=1;
									if(jieguo[7:4]>=1)backward=0;
								end
						end
					BCD=0;
				end
			case(count_1[6:5])//首先把最低位显示，然后显示最高位，但速度很快
			3:devided=jieguo[15:12]; //人眼看不出来
			2:devided=jieguo[11:8];
			1:devided=jieguo[7:4];
			0:devided=jieguo[3:0];
			endcase
		end
	BCD_SEG speed_display0(devided,count_1[6:5],seg,sel_out);
endmodule
