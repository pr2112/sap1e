//------------------------------------------------------------
// Implements the Ben Eater 8 bit CPU in Verilog
//------------------------------------------------------------

`timescale 1 ms / 1 ms

module cpu_tb;   
   
   reg        reset;   
   reg        clk;
   wire [7:0] out;
   
   
   always #1 clk = !clk;   
   
   initial 
     begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0,cpu_tb);
        #0 
          begin
             reset = 1;             
             clk = 1;
          end
        
        #10 reset = 0;
        #100000 $finish;
     end
   
   cpu cpu1(.clk(clk),
            .reset(reset),
            .out(out));
   
endmodule
