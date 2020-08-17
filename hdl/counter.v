module counter 
  #(parameter WIDTH = 4)
   (
    input              clock,
    input              reset,
    input              clear,
    input              set,
    input              incr_en,
    input [WIDTH-1:0]  data_in,
    output [WIDTH-1:0] data_out
    );

   reg [WIDTH-1:0]     cntr;
   localparam [WIDTH-1:0] ONE = { {WIDTH-1 {1'b0}},  1'b1 };
   
   always @(posedge clock)
     begin
        if (reset || clear)
          cntr <= 0;
        else if (incr_en)
          cntr <= cntr + ONE;
	else if (set) 
	  cntr <= data_in;
     end
   
   assign data_out = cntr;
   
endmodule
