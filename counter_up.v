`timescale 1ns / 1ps
////////////////////////
///
////////////////////////
module counter_up(
		input clk,
		output reg [3:0] led,
		input press,
		output sound
    );
	 
	 // For LEDs
	 reg slow_clk;
	 reg [22:0] counter;
	 reg [3:0] next_led;
	 
	 // For Buzzer
	 wire clk_400;
	 wire valid;
	 wire [21:0] tone;
	 
	 assign tone = press ? 22'd000000 : 22'd125000;
	 
	 tone_generator clk_wiz_0_inst(
			.clk(clk),
			.counter(tone),
			.sound(sound)
	 );
	 
	 initial begin
		next_led = 4'b0000;
		led = 4'b0000;
		slow_clk = 1'b0;
		counter = 0;
	 end
	 
	 always @ (posedge clk) // 27Mhz
	 begin
		counter = counter + 1;
		if (counter == 0)
		begin
			slow_clk = ~slow_clk; // 1Hz
		end
	 end
	 
	 always @ (posedge slow_clk)
	 begin
		next_led <= led + 1;
		if (next_led > 4'b1111) // if all LEDs are on
		begin
			next_led = 4'b0000; // reset LED
		end
	 end

	 always @ (next_led)
	 begin
		led = next_led;
	 end


endmodule
