# SAP1
A Verilog implementation of the SAP1 CPU as described by Albert Paul Malvino in
his book "Digital Computer Electronics".  This version includes the enhanced instruction
set described by Ben Eater in his "Building an 8-bit Breadboard Computer" YouTube video series.


## Building
This code runs under Icarus Verilog and has also been built and tested on the Terasic
DE0-Nano board using Quartus version 18.0.

The ram.v module uses "$readmemh" to populate the RAM with a program to execute.  See the roms 
directory for example programs.

## References
* [Ben Eater YouTube Series](https://www.youtube.com/watch?v=HyznrdDSSGM&list=PLowKtXNTBypGqImE405J2565dvjafglHU)
