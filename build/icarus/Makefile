IVERILOG=/cygdrive/c/Apps/iverilog/bin/iverilog
VVP=/cygdrive/c/Apps/iverilog/bin/vvp

SRCPATH=../../hdl/
SRC=$(SRCPATH)/ucode.v
SRC+=$(SRCPATH)/cpu_register.v
SRC+=$(SRCPATH)/bus_multiplexer.v
SRC+=$(SRCPATH)/ram.v
SRC+=$(SRCPATH)/alu.v
SRC+=$(SRCPATH)/counter.v
SRC+=$(SRCPATH)/cpu.v
SRC+=$(SRCPATH)/icarus/cpu_tb.v

all:
	$(IVERILOG) $(SRC)

run:
	$(VVP) a.out
	
clean:
	@rm -rf a.out
	@rm -rf *.vcd
