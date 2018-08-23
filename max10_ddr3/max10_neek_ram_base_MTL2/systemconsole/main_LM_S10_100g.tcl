
# #####################################################
# Stratix 10 Low Latency 100Gbps Ethernet IP Instance 0
# #####################################################
source [file join [file dirname [info script]] "link_monitor_s10_100g/hwtest/main.tcl"]

source [file join [file dirname [info script]] "link_monitor_s10_100g/link_monitor_s10_100g_0.tcl"]
dashboard_s10_100g_0
