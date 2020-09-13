# SAP1
A Verilog implementation of the SAP1 CPU as described by Albert Paul Malvino in
his book "Digital Computer Electronics".  This version includes the enhanced instruction
set described by Ben Eater in his "Building an 8-bit Breadboard Computer" YouTube video series.


## Building
This code runs under the following platforms:

* Icarus Verilog - Use gtkwave to verify proper operation
* DE0-Nano using Quartus version 18.0 - the 8 LEDs on the board are tied to the SAP1 CPU output register
* Nandland Go Board using icestorm tools - the 2 digit seven segment display is tied to the SAP1 CPU output register 
* Lattice iCEstick using icestorm tools

The ram.v module uses "$readmemh" to populate the RAM with a program to execute.  See the roms 
directory for example programs.

## References
* [Ben Eater YouTube Series](https://www.youtube.com/watch?v=HyznrdDSSGM&list=PLowKtXNTBypGqImE405J2565dvjafglHU)
* [Nandland Go Board](https://www.nandland.com/)
* [Project Icestorm](http://www.clifford.at/icestorm/)
