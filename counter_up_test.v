`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:20:38 09/20/2019
// Design Name:   counter_up
// Module Name:   C:/Users/ryancor/Desktop/Exercises/FPGA/Counter_Up/counter_up_test.v
// Project Name:  Counter_Up
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter_up
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_up_test;

	// Inputs
	reg clk;
	reg press;

	// Outputs
	reg [3:0] led;
	wire sound;

	// Instantiate the Unit Under Test (UUT)
	counter_up uut (
		.clk(clk), 
		.led(led), 
		.press(press), 
		.sound(sound)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		press = 1;
		led = 4'b0000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
	
	always
		#5 clk = !clk;
		initial begin
			led = 4'b1111;
		end
	
	initial begin
		$dumpfile("counter_up_test.vcd");
		$dumpvars;
	end
	initial begin
		$display("\t\ttime,\tclk,\tpress,\tled,\tcounter");
		$monitor("%d,\t%b,\t%b,\t%b,\t%d",$time, clk, press, led, sound);
	end
      
endmodule

