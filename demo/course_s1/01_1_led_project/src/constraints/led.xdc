set_property -dict { PACKAGE_PIN AB11 IOSTANDARD DIFF_SSTL12 } [get_ports sys_clk_p];
set_property -dict { PACKAGE_PIN W13  IOSTANDARD LVCMOS33    } [get_ports {led[0]}];
set_property -dict { PACKAGE_PIN Y12  IOSTANDARD LVCMOS33    } [get_ports {led[1]}];
set_property -dict { PACKAGE_PIN AA12 IOSTANDARD LVCMOS33    } [get_ports {led[2]}];
set_property -dict { PACKAGE_PIN AB13 IOSTANDARD LVCMOS33    } [get_ports {led[3]}];
set_property -dict { PACKAGE_PIN AA13 IOSTANDARD LVCMOS33    } [get_ports {key[0]}];
set_property -dict { PACKAGE_PIN AE14 IOSTANDARD LVCMOS33    } [get_ports {key[1]}];
set_property -dict { PACKAGE_PIN AE15 IOSTANDARD LVCMOS33    } [get_ports {key[2]}];
set_property -dict { PACKAGE_PIN AG14 IOSTANDARD LVCMOS33    } [get_ports {key[3]}];

create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p];

# create_debug_core u_ila_0 ila
# set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
# set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
# set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
# set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
# set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
# set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
# set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
# set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
# set_property port_width 1 [get_debug_ports u_ila_0/clk]
# connect_debug_port u_ila_0/clk [get_nets [list sys_clk_BUFG]]
# set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
# set_property port_width 32 [get_debug_ports u_ila_0/probe0]
# connect_debug_port u_ila_0/probe0 [get_nets [list
# 	{timer_cnt[0]}  {timer_cnt[1]}  {timer_cnt[2]}  {timer_cnt[3]}  {timer_cnt[4]}  {timer_cnt[5]}  {timer_cnt[6]}  {timer_cnt[7]}
# 	{timer_cnt[8]}  {timer_cnt[9]}  {timer_cnt[10]} {timer_cnt[11]} {timer_cnt[12]} {timer_cnt[13]} {timer_cnt[14]} {timer_cnt[15]}
# 	{timer_cnt[16]} {timer_cnt[17]} {timer_cnt[18]} {timer_cnt[19]} {timer_cnt[20]} {timer_cnt[21]} {timer_cnt[22]} {timer_cnt[23]}
# 	{timer_cnt[24]} {timer_cnt[25]} {timer_cnt[26]} {timer_cnt[27]} {timer_cnt[28]} {timer_cnt[29]} {timer_cnt[30]} {timer_cnt[31]}]]
# create_debug_port u_ila_0 probe
# set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
# set_property port_width 1 [get_debug_ports u_ila_0/probe1]
# connect_debug_port u_ila_0/probe1 [get_nets [list led_OBUF]]
# set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
# set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
# set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
# connect_debug_port dbg_hub/clk [get_nets sys_clk_BUFG]
