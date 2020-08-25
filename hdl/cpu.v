//------------------------------------------------------------
// Implements the SAP-1 Ben Eater 8 bit CPU in Verilog
//------------------------------------------------------------
module cpu(
           input        clk,
           input        reset,
           output [7:0] out);
   
   // Microcode control signals
   reg hlt;  // Halt
   reg mi;   // MAR in
   reg ri;   // RAM in
   reg ro;   // RAM out
   reg io;   // IR out
   reg ii;   // IR in
   reg ai;   // A reg in
   reg ao;   // A reg out
   reg eo;   // Sum out
   reg su;   // Subtract enable
   reg bi;   // B reg in
   reg oi;   // Out reg in
   reg ce;   // Program counter enable
   reg co;   // Program counter out
   reg j;    // Jump
   reg fi;   // Flags in
   
   // Internal CPU bus (W Bus)
   wire [7:0] bus;

   // Data outputs
   wire [3:0] pc_data;
   wire [7:0] rega_data;
   wire [7:0] regb_data;   
   wire [7:0] ireg_data;
   wire [7:0] oreg_data;
   wire [3:0] mar_data;
   wire [7:0] ram_data;
   wire [7:0] alu_data;
   wire [7:0] flags_data;
   
   // ALU result indicators used to feed the flags register
   wire       carry_ind;
   wire       zero_ind;
   
   // CPU logic for halt
   reg        halted;
   always @(posedge clk)
     begin
        if (reset)
          halted <= 1'b0;
        else if (hlt)
          halted <= 1'b1;
     end
   
   // Current CPU opcode (not needed operationally)
   wire [3:0] opcode;
   assign opcode = ireg_data[7:4];
   
   // Create microcode clock 180 deg out of phase with system clock
   wire       uclk;
   assign uclk = !clk;
   
   ram #(.DATA_WIDTH(8), .ADDR_WIDTH(4)) ram
     (
      .clock(clk),
      .data_in(bus),
      .addr(mar_data),
      .data_in_en(ri),
      .data_out(ram_data)
      );
   
   alu alu1
     (
      .data_1(rega_data),
      .data_2(regb_data),
      .subtract(su),
      .data_out(alu_data),
      .carry(carry_ind),
      .zero(zero_ind)
      );

   cpu_register flags
     (
      .clock(clk),
      .reset(reset),
      .data_in({6'b0, zero_ind, carry_ind}),
      .data_in_en(fi),
      .data_out(flags_data)
     );   

   counter #(.WIDTH(4)) pc
     (.clock(clk),
      .reset(reset),
      .clear(1'b0),
      .set(j),
      .incr_en(ce),
      .data_in(bus[3:0]),
      .data_out(pc_data)
      );
   
   cpu_register regA
     (
      .clock(clk),
      .reset(reset),
      .data_in(bus),
      .data_in_en(ai),
      .data_out(rega_data)
     );

   cpu_register regB
     (
      .clock(clk),
      .reset(reset),
      .data_in(bus),
      .data_in_en(bi),
      .data_out(regb_data)
     );

   cpu_register ireg
     (
      .clock(clk),
      .reset(reset),
      .data_in(bus),
      .data_in_en(ii),
      .data_out(ireg_data)
     );

   cpu_register oreg
     (
      .clock(clk),
      .reset(reset),
      .data_in(bus),
      .data_in_en(oi),
      .data_out(oreg_data)
      );

   cpu_register #(.WIDTH(4)) mar
     (
      .clock(clk),
      .reset(reset),
      .data_in(bus[3:0]),
      .data_in_en(mi),
      .data_out(mar_data)
      );
   
   bus_multiplexer busmux
     (
      .a_data(rega_data),
      .a_data_en(ao),
      .pc_data({4'b0000, pc_data}),
      .pc_data_en(co),
      .ram_data(ram_data),
      .ram_data_en(ro),
      .ireg_data({4'b0000, ireg_data[3:0]}),
      .ireg_data_en(io),
      .alu_data(alu_data),
      .alu_data_en(eo),
      .bus(bus)
     );
  
   wire [2:0]  step_data;
   counter #(.WIDTH(3)) ustepper
     (.clock(uclk),
      .reset(reset),
      .clear(1'b0),
      .set(1'b0),
      .incr_en(!halted),
      .data_in(3'b0),
      .data_out(step_data)
     );
   

   // step_data decoder to keep track of the CPU "T" states(not needed 
   // operationally)
   reg [7:0]   t_state;
   always @(step_data)
     begin
        case (step_data)
          3'b000: t_state = 1'b1 << 0;
          3'b001: t_state = 1'b1 << 1;
          3'b010: t_state = 1'b1 << 2;
          3'b011: t_state = 1'b1 << 3;
          3'b100: t_state = 1'b1 << 4;
          3'b101: t_state = 1'b1 << 5;
          3'b110: t_state = 1'b1 << 6;
          3'b111: t_state = 1'b1 << 7;
        endcase // case (step_data)
     end
   
   
   // Form address to access into the microcode ROM
   wire [8:0] ucaddr;
   assign ucaddr = {flags_data[1:0], ireg_data[7:4], step_data};
   
   // Microcode data word
   wire [15:0] ucdat;
   
   ucode ucode(.address(ucaddr), 
               .data(ucdat));
   
   // Set control signals from microcode rom data
   always @ (posedge uclk) 
     begin
        if (reset)
          {hlt, mi, ri, ro, io, ii, ai, ao, eo, su, bi, oi, ce, co, j, fi} <= 16'd0;
        else          
          {hlt, mi, ri, ro, io, ii, ai, ao, eo, su, bi, oi, ce, co, j, fi} <= ucdat[15:0];
     end 
   
   assign out = oreg_data;
   
endmodule
