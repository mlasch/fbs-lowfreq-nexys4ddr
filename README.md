# FBS Project

This is a student project in the framework of the "FPGA based systems" course at the university of applied sciences Karlsruhe. The goal is to implement an audio signal transmission between two development boards. The sender and the receiver are implemented on a Nexys 4 DDR board. The Xilinx XADC IP is used as input to sample the audio signal. The samples are then transmitted with two LEDs (data and synchronization) and photo diodes to the second board where a PWM regenerates the original analog signal.

## Restore Project
The project settings are stored in a tcl script which restores the whole Vivado project. Run the following command from the TCL Console within Vivado.

<code>
cd /path/to/project
source generate\_project.tcl
</code>

Or create the project from the command line. The `vivado` executable must be in your system `$PATH`.

<code>
vivado -mode batch -source generate_project.tcl
</code>

## Save Project
First go into the project directory `cd [get_property DIRECTORY [current_project]]/..`. 


<code>
write_project_tcl -force generate_project.tcl
</code>
