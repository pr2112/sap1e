module bus_multiplexer (input [7:0] a_data,
                        input        a_data_en,
                        input [7:0]  pc_data,
                        input        pc_data_en,
                        input [7:0]  ram_data,
                        input        ram_data_en,
                        input [7:0]  ireg_data,
                        input        ireg_data_en,
                        input [7:0]  alu_data,
                        input        alu_data_en,
                        output [7:0] bus
                        );

   assign bus = a_data_en ? a_data :
                pc_data_en ? pc_data :
                ram_data_en ? ram_data :
                ireg_data_en ? ireg_data :
                alu_data_en ? alu_data :
                8'b0;

endmodule
