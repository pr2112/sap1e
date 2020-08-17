//------------------------------------------------------------
// Microcode ROM for the Ben Eater 8 bit CPU in Verilog
//------------------------------------------------------------
module ucode(
             input [8:0]   address,
             output reg [15:0] data
             );

   // Control bit constants
   localparam HLT = 16'b1000_0000_0000_0000;  // Halt
   localparam MI  = 16'b0100_0000_0000_0000;  // Memory address register (MAR) in
   localparam RI  = 16'b0010_0000_0000_0000;  // RAM in
   localparam RO  = 16'b0001_0000_0000_0000;  // RAM out
   localparam IO  = 16'b0000_1000_0000_0000;  // Instruction register out
   localparam II  = 16'b0000_0100_0000_0000;  // Instruction register in
   localparam AI  = 16'b0000_0010_0000_0000;  // A register in
   localparam AO  = 16'b0000_0001_0000_0000;  // A register out
   
   localparam EO  = 16'b0000_0000_1000_0000;  // ALU Sum out
   localparam SU  = 16'b0000_0000_0100_0000;  // ALU subtract enable
   localparam BI  = 16'b0000_0000_0010_0000;  // B register in
   localparam OI  = 16'b0000_0000_0001_0000;  // Output register in
   localparam CE  = 16'b0000_0000_0000_1000;  // Program counter increment
   localparam CO  = 16'b0000_0000_0000_0100;  // Program counter out
   localparam J   = 16'b0000_0000_0000_0010;  // Jump enable
   localparam FI  = 16'b0000_0000_0000_0001;  // Flags register in

   
   always @ (address) 
     begin 
        casez (address)
          // NOP Instruction
          9'b??_0000_000:       data = MI | CO;
          9'b??_0000_001:       data = RO | II | CE;
          9'b??_0000_010:       data = 16'b0;
          9'b??_0000_011:       data = 16'b0;
          9'b??_0000_100:       data = 16'b0;
          9'b??_0000_101:       data = 16'b0;
          9'b??_0000_110:       data = 16'b0;
          9'b??_0000_111:       data = 16'b0;

          // LDA Instruction
          9'b??_0001_000:       data = MI | CO;
          9'b??_0001_001:       data = RO | II | CE;
          9'b??_0001_010:       data = MI | IO;
          9'b??_0001_011:       data = RO | AI;
          9'b??_0001_100:       data = 16'b0;
          9'b??_0001_101:       data = 16'b0;
          9'b??_0001_110:       data = 16'b0;
          9'b??_0001_111:       data = 16'b0;
          

          // ADD Instruction
          9'b??_0010_000:       data = MI | CO;
          9'b??_0010_001:       data = RO | II | CE;
          9'b??_0010_010:       data = MI | IO;
          9'b??_0010_011:       data = RO | BI;
          9'b??_0010_100:       data = AI | EO | FI;
          9'b??_0010_101:       data = 16'b0;
          9'b??_0010_110:       data = 16'b0;
          9'b??_0010_111:       data = 16'b0;

          // SUB Instruction
          9'b??_0011_000:       data = MI | CO;
          9'b??_0011_001:       data = RO | II | CE;
          9'b??_0011_010:       data = MI | IO;
          9'b??_0011_011:       data = RO | BI;
          9'b??_0011_100:       data = AI | EO | SU | FI;
          9'b??_0011_101:       data = 16'b0;
          9'b??_0011_110:       data = 16'b0;
          9'b??_0011_111:       data = 16'b0;

          // STA Instruction
          9'b??_0100_000:       data = MI | CO;
          9'b??_0100_001:       data = RO | II | CE;
          9'b??_0100_010:       data = MI | IO;
          9'b??_0100_011:       data = AO | RI;
          9'b??_0100_100:       data = 16'b0;
          9'b??_0100_101:       data = 16'b0;
          9'b??_0100_110:       data = 16'b0;
          9'b??_0100_111:       data = 16'b0;

          // LDI Instruction
          9'b??_0101_000:       data = MI | CO;
          9'b??_0101_001:       data = RO | II | CE;
          9'b??_0101_010:       data = AI | IO;
          9'b??_0101_011:       data = 16'b0;
          9'b??_0101_100:       data = 16'b0;
          9'b??_0101_101:       data = 16'b0;
          9'b??_0101_110:       data = 16'b0;
          9'b??_0101_111:       data = 16'b0;

          // JMP Instruction
          9'b??_0110_000:       data = MI | CO;
          9'b??_0110_001:       data = RO | II | CE;
          9'b??_0110_010:       data = J  | IO;
          9'b??_0110_011:       data = 16'b0;
          9'b??_0110_100:       data = 16'b0;
          9'b??_0110_101:       data = 16'b0;
          9'b??_0110_110:       data = 16'b0;
          9'b??_0110_111:       data = 16'b0;
          
          // JC Instruction     CY=0
          9'b?0_0111_000:       data = MI | CO;
          9'b?0_0111_001:       data = RO | II | CE;
          9'b?0_0111_010:       data = 16'b0;
          9'b?0_0111_011:       data = 16'b0;
          9'b?0_0111_100:       data = 16'b0;
          9'b?0_0111_101:       data = 16'b0;
          9'b?0_0111_110:       data = 16'b0;
          9'b?0_0111_111:       data = 16'b0;
          
          // JC Instruction     CY=1
          9'b?1_0111_000:       data = MI | CO;
          9'b?1_0111_001:       data = RO | II | CE;
          9'b?1_0111_010:       data = J  | IO;
          9'b?1_0111_011:       data = 16'b0;
          9'b?1_0111_100:       data = 16'b0;
          9'b?1_0111_101:       data = 16'b0;
          9'b?1_0111_110:       data = 16'b0;
          9'b?1_0111_111:       data = 16'b0;
       
          // JZ Instruction     Z=0
          9'b0?_1000_000:       data = MI | CO;
          9'b0?_1000_001:       data = RO | II | CE;
          9'b0?_1000_010:       data = 16'b0;
          9'b0?_1000_011:       data = 16'b0;
          9'b0?_1000_100:       data = 16'b0;
          9'b0?_1000_101:       data = 16'b0;
          9'b0?_1000_110:       data = 16'b0;
          9'b0?_1000_111:       data = 16'b0;
          
          // JZ Instruction     Z=1
          9'b1?_1000_000:       data = MI | CO;
          9'b1?_1000_001:       data = RO | II | CE;
          9'b1?_1000_010:       data = J  | IO;
          9'b1?_1000_011:       data = 16'b0;
          9'b1?_1000_100:       data = 16'b0;
          9'b1?_1000_101:       data = 16'b0;
          9'b1?_1000_110:       data = 16'b0;
          9'b1?_1000_111:       data = 16'b0;
          
          // OUT Instruction
          9'b??_1110_000:       data = MI | CO;
          9'b??_1110_001:       data = RO | II | CE;
          9'b??_1110_010:       data = OI | AO;
          9'b??_1110_011:       data = 16'b0;
          9'b??_1110_100:       data = 16'b0;
          9'b??_1110_101:       data = 16'b0;
          9'b??_1110_110:       data = 16'b0;
          9'b??_1110_111:       data = 16'b0;

          // HLT instruction
          9'b??_1111_000:       data = MI | CO;
          9'b??_1111_001:       data = RO | II | CE;
          9'b??_1111_010:       data = HLT;
          9'b??_1111_011:       data = 16'b0;
          9'b??_1111_100:       data = 16'b0;
          9'b??_1111_101:       data = 16'b0;
          9'b??_1111_110:       data = 16'b0;
          9'b??_1111_111:       data = 16'b0;
          
          default:              data = 16'b0;
        endcase 
     end 

endmodule
