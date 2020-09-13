module cpu_top
  (input  i_CLK,
   input  i_TEST,
   output o_LED1,
   output o_LED2,
   output o_LED3,
   output o_LED4,
   output o_LED5
   );

   // Use a counter to slow the clock down
   reg [31:0] counter;

   always @ (posedge i_CLK) 
     begin      
        counter <= counter + 1;
     end  
   
   // Output from the CPU
   wire [7:0] cpu_out;
   
   // 
   cpu cpu1(.clk(counter[20]),
            .reset(i_TEST),
            .out(cpu_out));

   // With the USB connector facing down, the icestick
   // board LEDs are oriented as follows:
   //
   //         D2
   //
   //     D1  D5  D3
   //
   //         D4

   // Let's make the 4 LSB bits of cpu_out map to
   // {D1}{D2}{D3}{D4}, where D4 is the LSB
   
   assign o_LED1 = cpu_out[3];    // D1
   assign o_LED2 = cpu_out[2];    // D2
   assign o_LED3 = cpu_out[1];    // D3
   assign o_LED4 = cpu_out[0];    // D4

   assign o_LED5 = counter[20];   // D5
   
   
endmodule
