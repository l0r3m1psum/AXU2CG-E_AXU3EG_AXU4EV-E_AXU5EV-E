open_hw_manager
connect_hw_server
open_hw_target
current_hw_device [lindex [get_hw_devices] 0]
set_property PROGRAM.FILE {vivado_led.bit} [current_hw_device]
program_hw_devices [current_hw_device]