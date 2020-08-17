
//------------------------------------------------------------
// Top level module for the Ben Eater 8 bit CPU for the 
// Terasic DE0-Nano
//------------------------------------------------------------

module cpu_top(
	input clk,
	input  KEY0,
//	input reg KEY1,
	output  LED0,
	output  LED1,
	output  LED2,
	output  LED3,
	output  LED4,
	output  LED5,
	output  LED6,
	output  LED7
);

	// Count FPGA clock cycles
	reg [31:0] counter;

	// Output from the CPU
	wire [7:0] cpu_out;
	
	// Use counter to slow input clock to CPU
	cpu cpu1(.clk(counter[18]),    // 22 runs slow, was 16, was 14
             .reset(!KEY0),
		  	 .out(cpu_out));
   
	
	always @ (posedge clk) 
	begin	
		counter <= counter + 1;
	end

	assign LED0 = cpu_out[0];
	assign LED1 = cpu_out[1];
	assign LED2 = cpu_out[2];
	assign LED3 = cpu_out[3];
	assign LED4 = cpu_out[4];
	assign LED5 = cpu_out[5];
	assign LED6 = cpu_out[6];
	assign LED7 = cpu_out[7];
	
endmodule
