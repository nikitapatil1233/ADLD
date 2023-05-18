`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:12 05/05/2023 
// Design Name: 
// Module Name:    PWM_Pro 
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
module PWM_Pro
 #(parameter R=8)(
 input clk,
 input reset_n,
 input [R-1:0] duty,
 
 output pwm_out
    );
	 
	 //wire tick;
	 reg [R-1:0] Q_reg, Q_next;
	 always @(posedge clk, negedge reset_n)
	 begin
		if(~reset_n)
			Q_reg <= 'b0;
		
		else
			Q_reg <= Q_next;
	end
	
	always@(*)
	begin
		Q_next = Q_reg +1;
	end
	
	assign pwm_out = (Q_reg < duty);
	
	



endmodule
