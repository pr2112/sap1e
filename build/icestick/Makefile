# Makefile

SRCPATH=../../hdl/
SRC=$(SRCPATH)/ucode.v
SRC+=$(SRCPATH)/cpu_register.v
SRC+=$(SRCPATH)/bus_multiplexer.v
SRC+=$(SRCPATH)/ram.v
SRC+=$(SRCPATH)/alu.v
SRC+=$(SRCPATH)/counter.v
SRC+=$(SRCPATH)/cpu.v
SRC+=$(SRCPATH)/icestick/cpu_top.v

TARGET=sap1e
PCF_FILE=icestick.pcf

yosys:
	yosys -p "synth_ice40 -blif $(TARGET).blif" $(SRC)

pnr:
	arachne-pnr -d 1k -p $(PCF_FILE) $(TARGET).blif -o $(TARGET).asc

pack:
	icepack $(TARGET).asc $(TARGET).bin

prog:
	iceprog $(TARGET).bin

all:	yosys pnr pack prog

clean:
	@rm -rf $(TARGET).blif
	@rm -rf $(TARGET).bin
	@rm -rf $(TARGET).asc
