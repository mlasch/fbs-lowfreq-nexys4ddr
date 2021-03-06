#*****************************************************************************************
# Vivado (TM) v2018.1 (64-bit)
#
# generate_project.tcl: Tcl script for re-creating project 'fbs_project'
#
# Generated by Vivado on Sat Jun 02 13:41:14 CEST 2018
# IP Build 2185939 on Wed Apr  4 20:55:05 MDT 2018
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (generate_project.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    <none>
#
# 3. The following remote source files that were added to the original project:-
#
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/psc.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/spc.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/adc_interface.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/toplevel.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/pwm.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/fir_lowpass.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/signal_sink.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/signal_source.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/mod-demod/mod.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/top_send.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/xilinx_ip/xadc_wiz_0/xadc_wiz_0.xci"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/xilinx_ip/xbip_dsp48_B/xbip_dsp48_B.xci"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/xilinx_ip/xbip_dsp48_A/xbip_dsp48_A.xci"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/xilinx_ip/lia_0/ila_0.xci"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/constrs/Nexys4DDR_Master.xdc"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/spc_tb.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/spc_tb_behav.wcfg"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/pwm_tb.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/pwm_tb_behav.wcfg"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/dsp_tb.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/dsp_tb_behav.wcfg"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/toplevel_tb.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/top_send_tb.vhd"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/hdl/xilinx_ip/xadc_wiz_0/sample1khz.txt"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/toplevel_tb_behav.wcfg"
#    "/home/marc/workspace/vhdl/fbs-lowfreq-nexys4ddr/sim/source_sim_tb.vhd"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "fbs_project"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "generate_project.tcl"

# Help information for this script
proc help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/fbs_project"]"

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a100tcsg324-3

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "part" -value "xc7a100tcsg324-3" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "source_mgmt_mode" -value "DisplayOnly" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/../hdl/psc.vhd"] \
 [file normalize "${origin_dir}/../hdl/spc.vhd"] \
 [file normalize "${origin_dir}/../hdl/adc_interface.vhd"] \
 [file normalize "${origin_dir}/../hdl/toplevel.vhd"] \
 [file normalize "${origin_dir}/../hdl/pwm.vhd"] \
 [file normalize "${origin_dir}/../hdl/fir_lowpass.vhd"] \
 [file normalize "${origin_dir}/../hdl/signal_sink.vhd"] \
 [file normalize "${origin_dir}/../hdl/signal_source.vhd"] \
 [file normalize "${origin_dir}/../hdl/mod-demod/mod.vhd"] \
 [file normalize "${origin_dir}/../hdl/top_send.vhd"] \
 [file normalize "${origin_dir}/../hdl/xilinx_ip/xadc_wiz_0/xadc_wiz_0.xci"] \
 [file normalize "${origin_dir}/../hdl/xilinx_ip/xbip_dsp48_B/xbip_dsp48_B.xci"] \
 [file normalize "${origin_dir}/../hdl/xilinx_ip/xbip_dsp48_A/xbip_dsp48_A.xci"] \
 [file normalize "${origin_dir}/../hdl/xilinx_ip/lia_0/ila_0.xci"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/../hdl/psc.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/spc.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/adc_interface.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/toplevel.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/pwm.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../hdl/fir_lowpass.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/signal_sink.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/signal_source.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/mod-demod/mod.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj

set file "$origin_dir/../hdl/top_send.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "toplevel" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/../hdl/constrs/Nexys4DDR_Master.xdc"]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file "$origin_dir/../hdl/constrs/Nexys4DDR_Master.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_constrs_file" -value "[file normalize "$origin_dir/../hdl/constrs/Nexys4DDR_Master.xdc"]" -objects $obj

# Create 'spc_sim' fileset (if not found)
if {[string equal [get_filesets -quiet spc_sim] ""]} {
  create_fileset -simset spc_sim
}

# Set 'spc_sim' fileset object
set obj [get_filesets spc_sim]
set files [list \
 [file normalize "${origin_dir}/../sim/spc_tb.vhd"] \
 [file normalize "${origin_dir}/../sim/spc_tb_behav.wcfg"] \
]
add_files -norecurse -fileset $obj $files

# Set 'spc_sim' fileset file properties for remote files
set file "$origin_dir/../sim/spc_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets spc_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'spc_sim' fileset file properties for local files
# None

# Set 'spc_sim' fileset properties
set obj [get_filesets spc_sim]
set_property -name "top" -value "spc_tb" -objects $obj
set_property -name "xsim.simulate.runtime" -value "100us" -objects $obj

# Create 'pwm_sim' fileset (if not found)
if {[string equal [get_filesets -quiet pwm_sim] ""]} {
  create_fileset -simset pwm_sim
}

# Set 'pwm_sim' fileset object
set obj [get_filesets pwm_sim]
set files [list \
 [file normalize "${origin_dir}/../sim/pwm_tb.vhd"] \
 [file normalize "${origin_dir}/../sim/pwm_tb_behav.wcfg"] \
]
add_files -norecurse -fileset $obj $files

# Set 'pwm_sim' fileset file properties for remote files
set file "$origin_dir/../sim/pwm_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets pwm_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj


# Set 'pwm_sim' fileset file properties for local files
# None

# Set 'pwm_sim' fileset properties
set obj [get_filesets pwm_sim]
set_property -name "top" -value "pwm_tb" -objects $obj
set_property -name "xsim.simulate.runtime" -value "200us" -objects $obj

# Create 'dsp_sim' fileset (if not found)
if {[string equal [get_filesets -quiet dsp_sim] ""]} {
  create_fileset -simset dsp_sim
}

# Set 'dsp_sim' fileset object
set obj [get_filesets dsp_sim]
set files [list \
 [file normalize "${origin_dir}/../sim/dsp_tb.vhd"] \
 [file normalize "${origin_dir}/../sim/dsp_tb_behav.wcfg"] \
]
add_files -norecurse -fileset $obj $files

# Set 'dsp_sim' fileset file properties for remote files
set file "$origin_dir/../sim/dsp_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets dsp_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj


# Set 'dsp_sim' fileset file properties for local files
# None

# Set 'dsp_sim' fileset properties
set obj [get_filesets dsp_sim]
set_property -name "top" -value "dsp_tb" -objects $obj
set_property -name "xsim.simulate.runtime" -value "100us" -objects $obj

# Create 'top_sim' fileset (if not found)
if {[string equal [get_filesets -quiet top_sim] ""]} {
  create_fileset -simset top_sim
}

# Set 'top_sim' fileset object
set obj [get_filesets top_sim]
set files [list \
 [file normalize "${origin_dir}/../sim/toplevel_tb.vhd"] \
 [file normalize "${origin_dir}/../sim/top_send_tb.vhd"] \
 [file normalize "${origin_dir}/../hdl/xilinx_ip/xadc_wiz_0/sample1khz.txt"] \
 [file normalize "${origin_dir}/../sim/toplevel_tb_behav.wcfg"] \
]
add_files -norecurse -fileset $obj $files

# Set 'top_sim' fileset file properties for remote files
set file "$origin_dir/../sim/toplevel_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets top_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../sim/top_send_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets top_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj


# Set 'top_sim' fileset file properties for local files
# None

# Set 'top_sim' fileset properties
set obj [get_filesets top_sim]
set_property -name "top" -value "toplevel_tb" -objects $obj
set_property -name "xsim.simulate.runtime" -value "100us" -objects $obj

# Create 'source_sim' fileset (if not found)
if {[string equal [get_filesets -quiet source_sim] ""]} {
  create_fileset -simset source_sim
}

# Set 'source_sim' fileset object
set obj [get_filesets source_sim]
set files [list \
 [file normalize "${origin_dir}/../sim/source_sim_tb.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Set 'source_sim' fileset file properties for remote files
set file "$origin_dir/../sim/source_sim_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets source_sim] [list "*$file"]]
set_property -name "file_type" -value "VHDL 2008" -objects $file_obj


# Set 'source_sim' fileset file properties for local files
# None

# Set 'source_sim' fileset properties
set obj [get_filesets source_sim]
set_property -name "top" -value "source_sim_tb" -objects $obj
set_property -name "xsim.simulate.runtime" -value "100us" -objects $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7a100tcsg324-3 -flow {Vivado Synthesis 2018} -strategy "Flow_RuntimeOptimized" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Flow_RuntimeOptimized" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2018" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "needs_refresh" -value "1" -objects $obj
set_property -name "part" -value "xc7a100tcsg324-3" -objects $obj
set_property -name "strategy" -value "Flow_RuntimeOptimized" -objects $obj
set_property -name "steps.synth_design.args.flatten_hierarchy" -value "none" -objects $obj
set_property -name "steps.synth_design.args.directive" -value "RuntimeOptimized" -objects $obj
set_property -name "steps.synth_design.args.fsm_extraction" -value "off" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7a100tcsg324-3 -flow {Vivado Implementation 2018} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2018" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0]
if { $obj != "" } {

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {

}
# Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0]
if { $obj != "" } {

}
set obj [get_runs impl_1]
set_property -name "needs_refresh" -value "1" -objects $obj
set_property -name "part" -value "xc7a100tcsg324-3" -objects $obj
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.write_bitstream.args.bin_file" -value "1" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:${_xil_proj_name_}"
