# FBS Project

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
