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
	 reg [21:0] tone; // if you wanted to assign tone to one press 
							// you would wire it instead declare as reg
	 wire [3:0] time_stamp;
	 wire [3:0] b_leds = led;
	 assign b_leds = time_stamp;
	 
	 always @* begin
		case(time_stamp) 
			4'd0: tone = press ? 22'd000000 : 22'd125000;
			4'd1: tone = press ? 22'd000000 : 22'd75000;
			4'd2: tone = press ? 22'd000000 : 22'd50000;
			4'd3: tone = press ? 22'd000000 : 22'd30000;
			4'd4: tone = press ? 22'd000000 : 22'd125000;
			4'd5: tone = press ? 22'd000000 : 22'd75000;
			4'd6: tone = press ? 22'd000000 : 22'd50000;
			4'd7: tone = press ? 22'd000000 : 22'd30000;
			default: tone = press ? 22'd000000 : 22'd125000;
		endcase
	 end
	 
	 tone_generator clk_wiz_0_inst(
		.clk(clk),
		.counter(tone),
		.sound(sound)
	 );
	 
	 clock_divider clk_wiz_0_inst_time(
		.clk(clk),
		.counter(time_stamp)
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
