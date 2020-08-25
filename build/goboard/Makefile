# Makefile

SRCPATH=../../hdl/
SRC=$(SRCPATH)/ucode.v
SRC+=$(SRCPATH)/cpu_register.v
SRC+=$(SRCPATH)/bus_multiplexer.v
SRC+=$(SRCPATH)/ram.v
SRC+=$(SRCPATH)/alu.v
SRC+=$(SRCPATH)/counter.v
SRC+=$(SRCPATH)/cpu.v
SRC+=$(SRCPATH)/goboard/cpu_top.v
SRC+=$(SRCPATH)/goboard/bintoseven.v

TARGET=sap1e
PCF_FILE=nandland.pcf

# Nandland board needs the package set to 'vq100'
PACKAGE=vq100


yosys:
	yosys -p "synth_ice40 -blif $(TARGET).blif" $(SRC)

pnr:
	arachne-pnr -d 1k -p $(PCF_FILE) -P $(PACKAGE) $(TARGET).blif -o $(TARGET).asc

pack:
	icepack $(TARGET).asc $(TARGET).bin

prog:
	iceprog $(TARGET).bin

all:	yosys pnr pack prog

clean:
	@rm -rf $(TARGET).blif
	@rm -rf $(TARGET).bin
	@rm -rf $(TARGET).asc
