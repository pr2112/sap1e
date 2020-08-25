module cpu_top
  (input  i_Clk,      // Main Clock (25 MHz)
   input  i_Switch_1, 
   output o_Segment1_A,
   output o_Segment1_B,
   output o_Segment1_C,
   output o_Segment1_D,
   output o_Segment1_E,
   output o_Segment1_F,
   output o_Segment1_G,
   output o_Segment2_A,
   output o_Segment2_B,
   output o_Segment2_C,
   output o_Segment2_D,
   output o_Segment2_E,
   output o_Segment2_F,
   output o_Segment2_G
   );
   

   wire   w_Segment1_A;
   wire   w_Segment1_B;
   wire   w_Segment1_C;
   wire   w_Segment1_D;
   wire   w_Segment1_E;
   wire   w_Segment1_F;
   wire   w_Segment1_G;
   
   
   wire   w_Segment2_A;
   wire   w_Segment2_B;
   wire   w_Segment2_C;
   wire   w_Segment2_D;
   wire   w_Segment2_E;
   wire   w_Segment2_F;
   wire   w_Segment2_G;
   

   // Count FPGA clock cycles
   reg [31:0] counter;
   
   // Output from the CPU
   wire [7:0] cpu_out;
   
   // Use counter to slow input clock to CPU
   cpu cpu1(.clk(counter[20]),
            .reset(i_Switch_1),
            .out(cpu_out));
   
   
   always @ (posedge i_Clk) 
     begin      
        counter <= counter + 1;
     end
   
   
   // Most significant digit
   Binary_To_7Segment bin2sevenMSD
     (.i_Clk(i_Clk),
      .i_Binary_Num(cpu_out[7:4]),
      .o_Segment_A(w_Segment1_A),
      .o_Segment_B(w_Segment1_B),
      .o_Segment_C(w_Segment1_C),
      .o_Segment_D(w_Segment1_D),
      .o_Segment_E(w_Segment1_E),
      .o_Segment_F(w_Segment1_F),
      .o_Segment_G(w_Segment1_G)
      );   
   
   // Least significant digit
   Binary_To_7Segment bin2sevenLSD
     (.i_Clk(i_Clk),
      .i_Binary_Num(cpu_out[3:0]),
      .o_Segment_A(w_Segment2_A),
      .o_Segment_B(w_Segment2_B),
      .o_Segment_C(w_Segment2_C),
      .o_Segment_D(w_Segment2_D),
      .o_Segment_E(w_Segment2_E),
      .o_Segment_F(w_Segment2_F),
      .o_Segment_G(w_Segment2_G)
      );
   
   
   
   assign o_Segment1_A = ~w_Segment1_A;
   assign o_Segment1_B = ~w_Segment1_B;
   assign o_Segment1_C = ~w_Segment1_C;
   assign o_Segment1_D = ~w_Segment1_D;
   assign o_Segment1_E = ~w_Segment1_E;
   assign o_Segment1_F = ~w_Segment1_F;
   assign o_Segment1_G = ~w_Segment1_G;
   
   
   assign o_Segment2_A = ~w_Segment2_A;
   assign o_Segment2_B = ~w_Segment2_B;
   assign o_Segment2_C = ~w_Segment2_C;
   assign o_Segment2_D = ~w_Segment2_D;
   assign o_Segment2_E = ~w_Segment2_E;
   assign o_Segment2_F = ~w_Segment2_F;
   assign o_Segment2_G = ~w_Segment2_G;
   
endmodule
