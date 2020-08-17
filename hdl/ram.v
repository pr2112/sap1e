module ram 
  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4)
   
   (
    input                   clock,
    input [DATA_WIDTH-1:0]  data_in,
    input [ADDR_WIDTH-1:0]  addr,
    input                   data_in_en,
    output [DATA_WIDTH-1:0] data_out
    );
   
   localparam DEPTH = 1 << ADDR_WIDTH;
   
   reg [DATA_WIDTH-1:0]    mem [0:DEPTH-1];
   
   always @(posedge clock)
     begin
        if (data_in_en) 
          mem[addr] <= data_in;
     end

   assign data_out = mem[addr];
   
   initial 
     begin
        $readmemh("rom_image.txt", mem, 0, 15);
     end
   
endmodule
