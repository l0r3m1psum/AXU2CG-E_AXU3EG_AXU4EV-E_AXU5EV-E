
set proj_name "vivado_led"
set work_dir [pwd]

################################################################################

create_project -force $proj_name $work_dir/$proj_name -part xczu2cg-sfvc784-1-e
# Create 'sources_1' fileset (if not found)；file mkdir创建ip、new、bd三个子文件
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/ip
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/new
file mkdir $work_dir/$proj_name/$proj_name.srcs/sources_1/bd
# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/constrs_1/new
# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $work_dir/$proj_name/$proj_name.srcs/sim_1/new

################################################################################

add_files -fileset sources_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sources_1/new -force -quiet [glob -nocomplain $work_dir/src/design/*.v]
add_files -fileset sim_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/sim_1/new -force -quiet [glob -nocomplain $work_dir/src/testbench/*.v]
add_files -fileset constrs_1  -copy_to $work_dir/$proj_name/$proj_name.srcs/constrs_1/new -force -quiet [glob -nocomplain $work_dir/src/constraints/*.xdc]

# IP
# ILA IP
if 0 {
  create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila -dir $work_dir/$proj_name/$proj_name.srcs/sources_1/ip
  set_property -dict [list CONFIG.C_PROBE0_WIDTH {32} CONFIG.C_NUM_OF_PROBES {2} CONFIG.Component_Name {ila}] [get_ips ila]
  #set_property -dict [list CONFIG.C_PROBE4_WIDTH {128} CONFIG.C_PROBE3_WIDTH {8} CONFIG.C_PROBE2_WIDTH {32} CONFIG.C_PROBE1_WIDTH {16} CONFIG.C_DATA_DEPTH {2048} CONFIG.C_NUM_OF_PROBES {5} CONFIG.C_ENABLE_ILA_AXI_MON {false} CONFIG.C_MONITOR_TYPE {Native}] [get_ips ila_0]
  generate_target {instantiation_template} [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
  update_compile_order -fileset sources_1
  generate_target all [get_files  $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
  catch { config_ip_cache -export [get_ips -all ila] }
  export_ip_user_files -of_objects [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci] -no_script -sync -force -quiet
  create_ip_run [get_files -of_objects [get_fileset sources_1] $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci]
  launch_runs ila_synth_1 -jobs 5
  export_simulation -of_objects [get_files $work_dir/$proj_name/$proj_name.srcs/sources_1/ip/ila/ila.xci] -directory $work_dir/$proj_name/vivado_led.ip_user_files/sim_scripts -ip_user_files_dir $work_dir/$proj_name/vivado_led.ip_user_files -ipstatic_source_dir $work_dir/$proj_name/vivado_led.ip_user_files/ipstatic -lib_map_path [list {modelsim=$work_dir/$proj_name/vivado_led.cache/compile_simlib/modelsim} {questa=$work_dir/$proj_name/vivado_led.cache/compile_simlib/questa} {riviera=$work_dir/$proj_name/vivado_led.cache/compile_simlib/riviera} {activehdl=$work_dir/$proj_name/vivado_led.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
}
# Block Design
# source $work_dir/vivado_project/$proj_name.srcs/sources_1/bd/my_bd/my_bd.tcl

################################################################################

launch_runs synth_1 -jobs 5
wait_on_run synth_1
# set_property top_auto_detect true [current_project]
set_property top_file "/$work_dir/$proj_name/$proj_name.srcs/sources_1/new/led.v" [current_fileset]
synth_design -top led -quiet
opt_design -quiet
place_design -quiet
route_design -quiet
write_bitstream -force $work_dir/$proj_name.bit
write_debug_probes -force $work_dir/$proj_name.ltx

################################################################################

open_hw_manager
connect_hw_server
open_hw_target
current_hw_device [lindex [get_hw_devices] 0]
set_property PROGRAM.FILE {vivado_led.bit} [current_hw_device]
program_hw_devices [current_hw_device]
