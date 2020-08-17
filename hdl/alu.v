module alu
  #(parameter WIDTH = 8)
   
   (
    input [WIDTH-1:0]  data_1,
    input [WIDTH-1:0]  data_2,
    input              subtract,
    output [WIDTH-1:0] data_out,
    output             carry,
    output             zero             
    );                              
   
   assign {carry, data_out} = subtract ? data_1 - data_2 : data_1 + data_2;
   assign zero = (data_out == 0);
     
endmodule
