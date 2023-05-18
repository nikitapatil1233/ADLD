`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:38:18 05/05/2023
// Design Name:   PWM_Pro
// Module Name:   /home/ise/xlinix_files/PWM_CP/PWM_Pro_tb.v
// Project Name:  PWM_CP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PWM_Pro
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PWM_Pro_tb;
	localparam R=8;
	// Inputs
	reg clk; 
	reg reset_n;
	reg [R -1:0] duty;

	// Outputs
	wire pwm_out;

	// Instantiate the Unit Under Test (UUT)
	PWM_Pro #(.R(R))uut (
		.clk(clk), 
		.reset_n(reset_n), 
		.duty(duty), 
		.pwm_out(pwm_out)
	);
	initial #(7 * 2**R*T) $stop;
	initial clk=0;
	localparam T=10;
	always
	begin
		#5 clk = ~clk;
		/*clk=1'b0;
		#(T/2);
		clk=1'b1;
		#(T/2);*/
	end
	initial begin
		// Initialize Inputs
		reset_n = 1'b0;
		#2 
		reset_n = 1'b1;
		duty = 0.25 * (2**R);
		
		repeat (2 *2**R) @(negedge clk);
		duty = 0.50 *(2**R);
		
		repeat (2 *2**R) @(negedge clk);
		duty = 0.750 *(2**R);

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
      
endmodule

