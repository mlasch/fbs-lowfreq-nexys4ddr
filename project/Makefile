# A Makefile to organize project files
#

VIVADO=$(XILINX_PATH)/vivado

project:
	$(VIVADO) -mode batch -source save_project.tcl fbs_project/fbs_project.xpr

restore:
	$(VIVADO) -mode batch -source generate\_project.tcl

clean:
	rm fbs_project/ -r
all:
