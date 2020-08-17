module cpu_register
  #(parameter WIDTH = 8)
   (
    input              clock,
    input              reset,
    input [WIDTH-1:0]  data_in,
    input              data_in_en,
    output [WIDTH-1:0] data_out
    );
   
   reg [WIDTH-1:0]     register;
   
   always @(posedge clock)
     begin
        if (reset)
          register <= 0;
        else if (data_in_en) 
          register <= data_in;         
     end
   
   assign data_out = register;
   
endmodule
