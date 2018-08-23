
global MAIN_DICT_s10_100g_0
dict set MAIN_DICT_s10_100g_0 OFFSET_S10CSR 0x0
dict set MAIN_DICT_s10_100g_0 OFFSET_S10RECO 0x4000

proc dashboard_s10_100g_0 {} {
	global dash_s10_100g_0
		
	set dash_s10_100g_0 [add_service dashboard Ethernet_Link_Monitor_s10_100g_0 "Ethernet Link Monitor" "Tools/Ethernet_Link_Monitor_s10_100g_0"]
	dashboard_set_property $dash_s10_100g_0 self visible true
	widget_group topGroup self 1 ""
	
		widget_label ip_var topGroup "IP Variant: Stratix 10 Low Latency 100-Gbps Ethernet IP"
		widget_checkBox continuous_read topGroup "Continuous Read All Registers" proc_continuous_read
	
		dashboard_add $dash_s10_100g_0 allstatus tabbedGroup topGroup
	
			#
			#MAC & PCS
			#
			widget_group MAC_PCS allstatus 1 "MAC & PHY"
			
				widget_group reset_mac_pcs MAC_PCS 3 "Resets"
					widget_button full_sys_rst reset_mac_pcs "Full System Reset" proc_full_sys_rst
					widget_button soft_txp_rst reset_mac_pcs "Reset TX PCS & TX MAC" proc_soft_txp_rst
					widget_button soft_rxp_rst reset_mac_pcs "Reset RX PCS & RX MAC" proc_soft_rxp_rst
						
				widget_group MAC MAC_PCS 2 "MAC Status"
				
					widget_group TXMAC MAC 2 "TX MAC Status"
					
						widget_button read_txmac TXMAC "Read TX MAC Status" proc_read_txmac
						widget_label txmac_blank TXMAC ""
						
						widget_label force_remote_fault TXMAC "Force Remote Fault"
						widget_label force_remote_fault_text TXMAC "Off"
						
						widget_label disable_remote_fault TXMAC "Disable Remote Fault"
						widget_label disable_remote_fault_text TXMAC "Off"
						
						widget_label unidir_remote_link_fault_reporting TXMAC "Unidir Remote Link Fault Reporting"
						widget_label unidir_remote_link_fault_reporting_text TXMAC "Off"
						
						widget_label link_fault_reporting TXMAC "Link Fault Reporting"
						widget_label link_fault_reporting_text TXMAC "On"
						
						widget_label idle_col_rem TXMAC "Idle Columns"
						widget_label idle_col_rem_text TXMAC "00000000"
						
						widget_label max_tx_size_config TXMAC "Max TX Size Config"
						widget_label max_tx_size_config_text TXMAC "00000000"
						
						widget_label vlan_detection_tx TXMAC "VLAN Detection"
						widget_label vlan_detection_tx_text TXMAC "Enabled"
						
					widget_group RXMAC MAC 2 "RX MAC Status"
					
						widget_button read_rxmac RXMAC "Read RX MAC Status" proc_read_rxmac
						widget_label rxmac_blank RXMAC ""
						
						widget_label local_fault RXMAC "Local Fault"
						widget_led local_fault_led RXMAC "" black
						
						widget_label remote_fault RXMAC "Remote Fault"
						widget_led remote_fault_led RXMAC "" black
						
						widget_label mac_crc_config RXMAC "RX CRC Forwarding"
						widget_label mac_crc_config_text RXMAC "Removed"
						
						widget_label preamble_check RXMAC "Preamble Check"
						widget_label preamble_check_text RXMAC "On"
						
						widget_label sfd_check RXMAC "SFD Check"
						widget_label sfd_check_text RXMAC "On"
						
						widget_label max_rx_size_config RXMAC "MAX RX Size Config"
						widget_label max_rx_size_config_text RXMAC "00000000"
						
						widget_label vlan_detection_rx RXMAC "VLAN Detection"
						widget_label vlan_detection_rx_text RXMAC "Enabled"
						
				widget_group PCS MAC_PCS 2 "PHY Status"
				
					widget_button read_pcs_status PCS "Read PHY Status" proc_read_pcs_status
					widget_button eio_sloop PCS "Enable Serial PMA Loopback" proc_eio_sloop
					
					widget_group pcs_dummy_1 PCS 5 ""
						
						widget_label  pcs_dummy_1_blank pcs_dummy_1 ""
						widget_label  pcs_dummy_1_l0 pcs_dummy_1 "Lane 0"
						widget_label  pcs_dummy_1_l1 pcs_dummy_1 "Lane 1"
						widget_label  pcs_dummy_1_l2 pcs_dummy_1 "Lane 2"
						widget_label  pcs_dummy_1_l3 pcs_dummy_1 "Lane 3"
						
						widget_label wordlock pcs_dummy_1 "Word Lock"
						widget_led  wordlock_l0 pcs_dummy_1 ""  black
						widget_led  wordlock_l1 pcs_dummy_1 ""  black
						widget_led  wordlock_l2 pcs_dummy_1 ""  black
						widget_led  wordlock_l3 pcs_dummy_1 ""  black
			
						widget_label rxcdrplllocked pcs_dummy_1 "RX CDR PLL Locked"
						widget_led rxcdrplllocked_l0 pcs_dummy_1 ""  black
						widget_led rxcdrplllocked_l1 pcs_dummy_1 ""  black
						widget_led rxcdrplllocked_l2 pcs_dummy_1 ""  black
						widget_led rxcdrplllocked_l3 pcs_dummy_1 ""  black
						
						widget_label tx_fifo_full pcs_dummy_1 "TX FIFO Full"
						widget_led tx_fifo_full_l0 pcs_dummy_1 ""  black
						widget_led tx_fifo_full_l1 pcs_dummy_1 ""  black
						widget_led tx_fifo_full_l2 pcs_dummy_1 ""  black
						widget_led tx_fifo_full_l3 pcs_dummy_1 ""  black
						
						widget_label tx_fifo_empty pcs_dummy_1 "TX FIFO Empty"
						widget_led tx_fifo_empty_l0 pcs_dummy_1 ""  black
						widget_led tx_fifo_empty_l1 pcs_dummy_1 ""  black
						widget_led tx_fifo_empty_l2 pcs_dummy_1 ""  black
						widget_led tx_fifo_empty_l3 pcs_dummy_1 ""  black
						
						widget_label tx_fifo_pfull pcs_dummy_1 "TX FIFO Partial Full"
						widget_led tx_fifo_pfull_l0 pcs_dummy_1 ""  black
						widget_led tx_fifo_pfull_l1 pcs_dummy_1 ""  black
						widget_led tx_fifo_pfull_l2 pcs_dummy_1 ""  black
						widget_led tx_fifo_pfull_l3 pcs_dummy_1 ""  black
						
						widget_label tx_fifo_pempty pcs_dummy_1 "TX FIFO Partial Empty"
						widget_led tx_fifo_pempty_l0 pcs_dummy_1 ""  black
						widget_led tx_fifo_pempty_l1 pcs_dummy_1 ""  black
						widget_led tx_fifo_pempty_l2 pcs_dummy_1 ""  black
						widget_led tx_fifo_pempty_l3 pcs_dummy_1 ""  black
						
						widget_label rx_fifo_full pcs_dummy_1 "RX FIFO Full"
						widget_led rx_fifo_full_l0 pcs_dummy_1 ""  black
						widget_led rx_fifo_full_l1 pcs_dummy_1 ""  black
						widget_led rx_fifo_full_l2 pcs_dummy_1 ""  black
						widget_led rx_fifo_full_l3 pcs_dummy_1 ""  black
						
						widget_label rx_fifo_empty pcs_dummy_1 "RX FIFO Empty"
						widget_led rx_fifo_empty_l0 pcs_dummy_1 ""  black
						widget_led rx_fifo_empty_l1 pcs_dummy_1 ""  black
						widget_led rx_fifo_empty_l2 pcs_dummy_1 ""  black
						widget_led rx_fifo_empty_l3 pcs_dummy_1 ""  black
						
						widget_label rx_fifo_pfull pcs_dummy_1 "RX FIFO Partial Full"
						widget_led rx_fifo_pfull_l0 pcs_dummy_1 ""  black
						widget_led rx_fifo_pfull_l1 pcs_dummy_1 ""  black
						widget_led rx_fifo_pfull_l2 pcs_dummy_1 ""  black
						widget_led rx_fifo_pfull_l3 pcs_dummy_1 ""  black
						
						widget_label rx_fifo_pempty pcs_dummy_1 "RX FIFO Partial Empty"
						widget_led rx_fifo_pempty_l0 pcs_dummy_1 ""  black
						widget_led rx_fifo_pempty_l1 pcs_dummy_1 ""  black
						widget_led rx_fifo_pempty_l2 pcs_dummy_1 ""  black
						widget_led rx_fifo_pempty_l3 pcs_dummy_1 ""  black
		
					widget_group pcs_dummy_2 PCS 2 ""
					
						widget_label txpcsready_title pcs_dummy_2 "TX PCS Ready"
						widget_led txpcsready_stat pcs_dummy_2 ""  black
			
						widget_label txpll_title pcs_dummy_2 "TX PLL Locked"
						widget_led txpll_stat pcs_dummy_2 ""  black
			
						widget_label rxpll_title pcs_dummy_2 "RX PLL Locked"
						widget_led rxpll_stat pcs_dummy_2 ""  black
						
						widget_label frameerror_title pcs_dummy_2 "Frame Error"
						widget_label frameerror_stat pcs_dummy_2 "0"
			
						widget_label rxpcs_title pcs_dummy_2 "RX PCS Fully Aligned"
						widget_led  rxpcs_stat pcs_dummy_2 ""  black
			
						widget_label amlock pcs_dummy_2 "Alignment Marker Lock"
						widget_led amlock_stat pcs_dummy_2 ""  black
			
						widget_label lanesdeskewed_title pcs_dummy_2 "Lanes Deskewed"
						widget_led lanesdeskewed_stat pcs_dummy_2 ""  black
			
						widget_label rxclk_title pcs_dummy_2 "RX Clock (KHz)"
						widget_label rxclk_stat pcs_dummy_2 "0"
			
						widget_label txclk_title pcs_dummy_2 "TX Clock (KHz)"
						widget_label txclk_stat pcs_dummy_2 "0"
			
			#
			#Statistics Counters
			#
			widget_group STATS_COUNT allstatus 2 "Statistics Counters"
				
				widget_button pkt_gen STATS_COUNT "Start Packet Generator" proc_pkt_gen
				widget_label pkt_gen_note STATS_COUNT "Note: Only available when example design is instantiated"
				
				widget_button read_tx_stats STATS_COUNT "Read TX Statistics Counters" proc_read_tx_stats
				widget_button read_rx_stats STATS_COUNT "Read RX Statistics Counters" proc_read_rx_stats
				
				widget_button pause_tx_stats STATS_COUNT "Pause TX Statistics Counters Collection" proc_pause_tx_stats
				widget_button pause_rx_stats STATS_COUNT "Pause RX Statistics Counters Collection" proc_pause_rx_stats
				
				widget_button reset_tx_stats STATS_COUNT "Reset TX Statistics Counters" proc_reset_tx_stats
				widget_button reset_rx_stats STATS_COUNT "Reset RX Statistics Counters" proc_reset_rx_stats
				
				widget_group CNTR_TX_STATUS STATS_COUNT 2 ""
					
					widget_label tx_stats_pause CNTR_TX_STATUS "TX Statistics Registers are"
					widget_label tx_stats_pause_d CNTR_TX_STATUS "unpaused"
				
				widget_group CNTR_RX_STATUS STATS_COUNT 2 ""
				
					widget_label rx_stats_pause CNTR_RX_STATUS "RX Statistics Registers are"
					widget_label rx_stats_pause_d CNTR_RX_STATUS "unpaused"
				
				
				widget_group TX_STATS_COUNT STATS_COUNT 2  "TX Statistics Counters"
				
					widget_label cntr_tx_fragments TX_STATS_COUNT "Fragmented Frames"
					widget_label cntr_tx_fragments_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_jabbers TX_STATS_COUNT "Jabbered Frames"
					widget_label cntr_tx_jabbers_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_fcs TX_STATS_COUNT "Any Size with FCS Err Frames"
					widget_label cntr_tx_fcs_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_crcerr TX_STATS_COUNT "Right Size with FCS Err Frames"
					widget_label cntr_tx_crcerr_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_mcast_data_err TX_STATS_COUNT "Multicast data Err Frames"
					widget_label cntr_tx_mcast_data_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_bcast_data_err TX_STATS_COUNT "Broadcast data Err Frames"
					widget_label cntr_tx_bcast_data_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_ucast_data_err TX_STATS_COUNT "Unicast data Err Frames"
					widget_label cntr_tx_ucast_data_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_mcast_ctrl_err TX_STATS_COUNT "Multicast Control Err Frames"
					widget_label cntr_tx_mcast_ctrl_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_bcast_ctrl_err TX_STATS_COUNT "Broadcast Control Err Frames"
					widget_label cntr_tx_bcast_ctrl_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_ucast_ctrl_err TX_STATS_COUNT "Unicast Control Err Frames"
					widget_label cntr_tx_ucast_ctrl_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_pause_err TX_STATS_COUNT "Pause Control Err Frames"
					widget_label cntr_tx_pause_err_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_64b TX_STATS_COUNT "64 Byte Frames"
					widget_label cntr_tx_64b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_65to127b TX_STATS_COUNT "65 - 127 Byte Frames"
					widget_label cntr_tx_65to127b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_128to255b TX_STATS_COUNT "128 - 255 Byte Frames"
					widget_label cntr_tx_128to255b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_256to511b TX_STATS_COUNT "256 - 511 Byte Frames"
					widget_label cntr_tx_256to511b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_512to1023b TX_STATS_COUNT "512 - 1023 Byte Frames"
					widget_label cntr_tx_512to1023b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_1024to1518b TX_STATS_COUNT "1024 - 1518 Byte Frames"
					widget_label cntr_tx_1024to1518b_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_1519tomaxb TX_STATS_COUNT "1519 - MAX Byte Frames"
					widget_label cntr_tx_1519tomaxb_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_oversize TX_STATS_COUNT "> MAX Byte Frames"
					widget_label cntr_tx_oversize_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_mcast_data_ok TX_STATS_COUNT "Multicast data OK Frames"
					widget_label cntr_tx_mcast_data_ok_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_bcast_data_ok TX_STATS_COUNT "Broadcast data OK Frames"
					widget_label cntr_tx_bcast_data_ok_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_ucast_data_ok TX_STATS_COUNT "Unicast data OK Frames"
					widget_label cntr_tx_ucast_data_ok_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_mcast_ctrl TX_STATS_COUNT "Multicast Control Frames"
					widget_label cntr_tx_mcast_ctrl_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_bcast_ctrl TX_STATS_COUNT "Broadcast Control Frames"
					widget_label cntr_tx_bcast_ctrl_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_ucast_ctrl TX_STATS_COUNT "Unicast Control Frames"
					widget_label cntr_tx_ucast_ctrl_d TX_STATS_COUNT "0"
					
					widget_label cntr_tx_pause TX_STATS_COUNT "Pause Control Frames"
					widget_label cntr_tx_pause_d TX_STATS_COUNT "0"
					
				widget_group RX_STATS_COUNT STATS_COUNT 2  "RX Statistics Counters"
				
					widget_label cntr_rx_fragments RX_STATS_COUNT "Fragmented Frames"
					widget_label cntr_rx_fragments_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_jabbers RX_STATS_COUNT "Jabbered Frames"
					widget_label cntr_rx_jabbers_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_fcs RX_STATS_COUNT "Any Size with FCS Err Frames"
					widget_label cntr_rx_fcs_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_crcerr RX_STATS_COUNT "Right Size with FCS Err Frames"
					widget_label cntr_rx_crcerr_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_mcast_data_err RX_STATS_COUNT "Multicast data Err Frames"
					widget_label cntr_rx_mcast_data_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_bcast_data_err RX_STATS_COUNT "Broadcast data Err Frames"
					widget_label cntr_rx_bcast_data_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_ucast_data_err RX_STATS_COUNT "Unicast data Err Frames"
					widget_label cntr_rx_ucast_data_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_mcast_ctrl_err RX_STATS_COUNT "Multicast Control Err Frames"
					widget_label cntr_rx_mcast_ctrl_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_bcast_ctrl_err RX_STATS_COUNT "Broadcast Control Err Frames"
					widget_label cntr_rx_bcast_ctrl_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_ucast_ctrl_err RX_STATS_COUNT "Unicast Control Err Frames"
					widget_label cntr_rx_ucast_ctrl_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_pause_err RX_STATS_COUNT "Pause Control Err Frames"
					widget_label cntr_rx_pause_err_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_64b RX_STATS_COUNT "64 Byte Frames"
					widget_label cntr_rx_64b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_65to127b RX_STATS_COUNT "65 - 127 Byte Frames"
					widget_label cntr_rx_65to127b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_128to255b RX_STATS_COUNT "128 - 255 Byte Frames"
					widget_label cntr_rx_128to255b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_256to511b RX_STATS_COUNT "256 - 511 Byte Frames"
					widget_label cntr_rx_256to511b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_512to1023b RX_STATS_COUNT "512 - 1023 Byte Frames"
					widget_label cntr_rx_512to1023b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_1024to1518b RX_STATS_COUNT "1024 - 1518 Byte Frames"
					widget_label cntr_rx_1024to1518b_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_1519tomaxb RX_STATS_COUNT "1519 - MAX Byte Frames"
					widget_label cntr_rx_1519tomaxb_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_oversize RX_STATS_COUNT "> MAX Byte Frames"
					widget_label cntr_rx_oversize_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_mcast_data_ok RX_STATS_COUNT "Multicast data OK Frames"
					widget_label cntr_rx_mcast_data_ok_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_bcast_data_ok RX_STATS_COUNT "Broadcast data OK Frames"
					widget_label cntr_rx_bcast_data_ok_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_ucast_data_ok RX_STATS_COUNT "Unicast data OK Frames"
					widget_label cntr_rx_ucast_data_ok_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_mcast_ctrl RX_STATS_COUNT "Multicast Control Frames"
					widget_label cntr_rx_mcast_ctrl_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_bcast_ctrl RX_STATS_COUNT "Broadcast Control Frames"
					widget_label cntr_rx_bcast_ctrl_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_ucast_ctrl RX_STATS_COUNT "Unicast Control Frames"
					widget_label cntr_rx_ucast_ctrl_d RX_STATS_COUNT "0"
					
					widget_label cntr_rx_pause RX_STATS_COUNT "Pause Control Frames"
					widget_label cntr_rx_pause_d RX_STATS_COUNT "0"
		
				
			
	
}

proc widget_group {name group itemsPerRow text} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name group $group
	dashboard_set_property $dash_s10_100g_0 $name itemsPerRow $itemsPerRow
	dashboard_set_property $dash_s10_100g_0 $name title $text
}

proc widget_checkBox {name group text onClick} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name checkBox $group
	dashboard_set_property $dash_s10_100g_0 $name text $text
	dashboard_set_property $dash_s10_100g_0 $name onClick $onClick
}

proc widget_button {name group text onClick} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name button $group
	dashboard_set_property $dash_s10_100g_0 $name text $text
	dashboard_set_property $dash_s10_100g_0 $name onClick $onClick
}

proc widget_label {name group text} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name label $group
	dashboard_set_property $dash_s10_100g_0 $name text $text
}

proc widget_led {name group text color} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name led $group
	dashboard_set_property $dash_s10_100g_0 $name text $text
	dashboard_set_property $dash_s10_100g_0 $name color $color
}

proc widget_text {name group text} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name text $group
	dashboard_set_property $dash_s10_100g_0 $name text $text
}

proc widget_comboBox {name group options} {
	global dash_s10_100g_0
	dashboard_add $dash_s10_100g_0 $name comboBox $group
	dashboard_set_property $dash_s10_100g_0 $name options $options
}

proc proc_continuous_read {} {
	global dash_s10_100g_0
	global MAIN_DICT_s10_100g_0
	
	while {[string match [dashboard_get_property $dash_s10_100g_0 continuous_read checked] "true"]} {
	proc_read_txmac
	proc_read_rxmac
	proc_read_pcs_status
	proc_read_tx_stats
	proc_read_rx_stats
	}
}

proc proc_full_sys_rst {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x1
	after 50
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
}

proc proc_soft_txp_rst {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x2
	after 50
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
}

proc proc_soft_rxp_rst {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4
	after 50
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
}

proc proc_read_txmac {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	
	set txmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_TXMAC_LINKFAULT] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
		if {[expr $txmac_value & 0x00000008]} {
			dashboard_set_property $dash_s10_100g_0 force_remote_fault_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 force_remote_fault_text text "Off"
           }
		if {[expr $txmac_value & 0x00000004]} {
			dashboard_set_property $dash_s10_100g_0 disable_remote_fault_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 disable_remote_fault_text text "Off"
           }
		if {[expr $txmac_value & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 unidir_remote_link_fault_reporting_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 unidir_remote_link_fault_reporting_text text "Off"
           }
		if {[expr $txmac_value & 0x00000001]} {
			dashboard_set_property $dash_s10_100g_0 link_fault_reporting_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 link_fault_reporting_text text "Off"
           }
	
	set txmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_TXMAC_IPGCOLREM] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]					
	dashboard_set_property $dash_s10_100g_0 idle_col_rem_text text "$txmac_value"
						
	set txmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_TXMAC_MAXSIZECONFIG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]					
	dashboard_set_property $dash_s10_100g_0 max_tx_size_config_text text "$txmac_value"					
						
	set txmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_TXMAC_CONTROL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
		if {[expr $txmac_value & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 vlan_detection_tx_text text "Disabled"
			} else {
			dashboard_set_property $dash_s10_100g_0 vlan_detection_tx_text text "Enabled"
           }
}

proc proc_read_rxmac {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	set rxmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_RXMAC_LINKFAULT] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
		if {[expr $rxmac_value & 0x00000001]} {
			dashboard_set_property $dash_s10_100g_0 local_fault_led color red
			} else {
			dashboard_set_property $dash_s10_100g_0 local_fault_led color green
           }
		if {[expr $rxmac_value & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 remote_fault_led color red
			} else {
			dashboard_set_property $dash_s10_100g_0 remote_fault_led color green
           }
	
	set rxmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_RXMAC_CRCCONFIG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]					
	if {[expr $rxmac_value & 0x00000001]} {
			dashboard_set_property $dash_s10_100g_0 mac_crc_config_text text "Retained"
			} else {
			dashboard_set_property $dash_s10_100g_0 mac_crc_config_text text "Removed"
           }
		
	set rxmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_RXMAC_CONTROL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
		if {[expr $rxmac_value & 0x00000010]} {
			dashboard_set_property $dash_s10_100g_0 preamble_check_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 preamble_check_text text "Off"
           }
		if {[expr $rxmac_value & 0x00000008]} {
			dashboard_set_property $dash_s10_100g_0 sfd_check_text text "On"
			} else {
			dashboard_set_property $dash_s10_100g_0 sfd_check_text text "Off"
           }
		if {[expr $rxmac_value & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 vlan_detection_rx_text text "Disabled"
			} else {
			dashboard_set_property $dash_s10_100g_0 vlan_detection_rx_text text "Enabled"
           }
		   
	set rxmac_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_RXMAC_MAXSIZECONFIG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]					
	dashboard_set_property $dash_s10_100g_0 max_rx_size_config_text text "$rxmac_value"
}

proc proc_eio_sloop {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	if {[string match [dashboard_get_property $dash_s10_100g_0 eio_sloop text] "Enable Serial PMA Loopback"]} {
		reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMALOOP] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0xf
		dashboard_set_property $dash_s10_100g_0 eio_sloop text "Disable Serial PMA Loopback"
		proc_read_pcs_status
	} elseif {[string match [dashboard_get_property $dash_s10_100g_0 eio_sloop text] "Disable Serial PMA Loopback"]} {
		reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PMALOOP] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
		dashboard_set_property $dash_s10_100g_0 eio_sloop text "Enable Serial PMA Loopback"
		proc_read_pcs_status
		}
}

proc proc_read_pcs_status {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	proc_read_pcs_status_1
	after 50
	proc_read_pcs_status_1
}

proc proc_read_pcs_status_1 {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_WORDLCK] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x312 WORD LOCK $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 wordlock_l0 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 wordlock_l0 color red
           }
	    if {[expr $pcs_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 wordlock_l1 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 wordlock_l1 color red
           }
	    if {[expr $pcs_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 wordlock_l2 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 wordlock_l2 color red
           }
	    if {[expr $pcs_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 wordlock_l3 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 wordlock_l3 color red
           }
		   
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_FREQLOCK] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x321 RX CDR PLL Locked $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l0 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l0 color red
           }
	    if {[expr $pcs_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l1 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l1 color red
           }
	    if {[expr $pcs_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l2 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l2 color red
           }
	    if {[expr $pcs_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l3 color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxcdrplllocked_l3 color red
           }
		   
	proc_read_fifo_status
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYCLK] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x322 PHY CLK $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 txpcsready_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 txpcsready_stat color red
           }
	    if {[expr $pcs_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 txpll_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 txpll_stat color red
           }
	    if {[expr $pcs_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rxpll_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxpll_stat color red
           }
		   
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_FRMERROR] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x323 Frame Error $pcs_status_value"
	dashboard_set_property $dash_s10_100g_0 frameerror_stat text "$pcs_status_value"
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_FALIGNED] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x326 RX PCS Fully Aligned $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rxpcs_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 rxpcs_stat color red
           }
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_AMLOCK] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x328 Alignment Marker $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 amlock_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 amlock_stat color red
           }
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_LNDSKWED] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x329 Lanes Deskewed $pcs_status_value"
	    if {[expr $pcs_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 lanesdeskewed_stat color green
           } else {
             dashboard_set_property $dash_s10_100g_0 lanesdeskewed_stat color red
           }
		   
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_RXCLKHZ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x341 RX Clock $pcs_status_value"
		dashboard_set_property $dash_s10_100g_0 rxclk_stat text [format %u $pcs_status_value] 
	
	set pcs_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_TXCLKHZ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "0x342 TX Clock $pcs_status_value"
		dashboard_set_property $dash_s10_100g_0 txclk_stat text [format %u $pcs_status_value] 

}

proc proc_read_fifo_status {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "TX FIFO full $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l0 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l1 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l2 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l3 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_full_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x1
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "TX FIFO empty $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l0 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l1 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l2 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l3 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_empty_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x2
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "TX FIFO partial full $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l0 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l1 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l2 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l3 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pfull_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x3
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "TX FIFO partial empty $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l0 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l1 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l2 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l3 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 tx_fifo_pempty_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "RX FIFO full $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l0 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l1 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l2 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l3 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_full_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x5
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "RX FIFO empty $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l0 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l1 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l2 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l3 color red
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_empty_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x6
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "RX FIFO partial full $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l0 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l1 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l2 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l3 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pfull_l3 color green
           }
		   
	reg_write [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x7
	set fifo_status_value [reg_read [dict get $MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	puts "RX FIFO partial empty $fifo_status_value"
	if {[expr $fifo_status_value & 0x00000001]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l0 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l0 color green
           }
	    if {[expr $fifo_status_value & 0x00000002]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l1 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l1 color green
           }
	    if {[expr $fifo_status_value & 0x00000004]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l2 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l2 color green
           }
	    if {[expr $fifo_status_value & 0x00000008]} {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l3 color yellow
           } else {
             dashboard_set_property $dash_s10_100g_0 rx_fifo_pempty_l3 color green
           }

}

proc proc_pkt_gen {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	if {[string match [dashboard_get_property $dash_s10_100g_0 pkt_gen text] "Start Packet Generator"]} {
		dashboard_set_property $dash_s10_100g_0 pkt_gen text "Stop Packet Generator"
		start_pkt_gen
		#reg_write 0x1000 0x10 0x5
		#start_gen
	} elseif {[string match [dashboard_get_property $dash_s10_100g_0 pkt_gen text] "Stop Packet Generator"]} {
		dashboard_set_property $dash_s10_100g_0 pkt_gen text "Start Packet Generator"
		stop_pkt_gen
		#reg_write 0x1000 0x10 0x7
		#stop_gen
	}
}

proc proc_read_tx_stats {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	#Pausing
	reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4
	
	set count [reg_read  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_STATUS] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	if {[expr $count & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "paused"
			} else {
			dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "unpaused"
           }

	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_FRAGMENTS_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_fragments_d text "$count"
	
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_JABBERS_LO          ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_jabbers_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_CRCERR_LO           ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_fcs_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_CRCERR_SIZEOK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_crcerr_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_MCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_mcast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_BCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_bcast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_UCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_ucast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_MCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_mcast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_BCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_bcast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_UCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_ucast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_PAUSE_ERR_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_pause_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_64B_LO              ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_64b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_65to127B_LO         ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_65to127b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_128to255B_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_128to255b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_256to511B_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_256to511b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_512to1023B_LO       ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_512to1023b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_1024to1518B_LO      ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_1024to1518b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_1519toMAXB_LO       ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_1519tomaxb_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_OVERSIZE_LO         ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_oversize_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_MCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_mcast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_BCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_bcast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_UCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_ucast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_MCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_mcast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_BCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_bcast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_UCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_ucast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 TX_REG_PAUSE_LO            ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_tx_pause_d text "$count"
	
	#Pausing
	reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
	
	set count [reg_read  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_STATUS] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	if {[expr $count & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "paused"
			} else {
			dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "unpaused"
           }
}

proc proc_read_rx_stats {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	#Pausing
	reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4	
	
	set count [reg_read  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_STATUS] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	if {[expr $count & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "paused"
			} else {
			dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "unpaused"
           }
		   
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_FRAGMENTS_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_fragments_d text "$count"
	
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_JABBERS_LO          ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_jabbers_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_CRCERR_LO           ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_fcs_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_CRCERR_SIZEOK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_crcerr_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_MCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_mcast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_BCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_bcast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_UCAST_DATA_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_ucast_data_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_MCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_mcast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_BCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_bcast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_UCAST_CTRL_ERR_LO   ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_ucast_ctrl_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_PAUSE_ERR_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_pause_err_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_64B_LO              ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_64b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_65to127B_LO         ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_65to127b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_128to255B_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_128to255b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_256to511B_LO        ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_256to511b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_512to1023B_LO       ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_512to1023b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_1024to1518B_LO      ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_1024to1518b_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_1519toMAXB_LO       ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_1519tomaxb_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_OVERSIZE_LO         ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_oversize_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_MCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_mcast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_BCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_bcast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_UCAST_DATA_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_ucast_data_ok_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_MCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_mcast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_BCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_bcast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_UCAST_CTRL_OK_LO    ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_ucast_ctrl_d text "$count"
					
	set count [expr [stats_read      [dict get $MAIN_DICT_s10_100g_0 RX_REG_PAUSE_LO            ] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]] ]
	dashboard_set_property $dash_s10_100g_0 cntr_rx_pause_d text "$count"
	
	#Pausing
	reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
	
	set count [reg_read  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_STATUS] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR]]
	if {[expr $count & 0x00000002]} {
			dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "paused"
			} else {
			dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "unpaused"
           }
}


proc proc_pause_tx_stats {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	if {[string match [dashboard_get_property $dash_s10_100g_0 pause_tx_stats text] "Pause TX Statistics Counters Collection"]} {
		reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4
		dashboard_set_property $dash_s10_100g_0 pause_tx_stats text "Unpause TX Statistics Counters Collection"
		dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "paused"
	} elseif {[string match [dashboard_get_property $dash_s10_100g_0 pause_tx_stats text] "Unpause TX Statistics Counters Collection"]} {
		reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
		dashboard_set_property $dash_s10_100g_0 pause_tx_stats text "Pause TX Statistics Counters Collection"
		dashboard_set_property $dash_s10_100g_0 tx_stats_pause_d text "unpaused"
	}	
}


proc proc_pause_rx_stats {} {
	global dash_s10_100g_0
	
	global MAIN_DICT_s10_100g_0
	
	if {[string match [dashboard_get_property $dash_s10_100g_0 pause_rx_stats text] "Pause RX Statistics Counters Collection"]} {
		reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x4
		dashboard_set_property $dash_s10_100g_0 pause_rx_stats text "Unpause RX Statistics Counters Collection"
		dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "paused"
	} elseif {[string match [dashboard_get_property $dash_s10_100g_0 pause_rx_stats text] "Unpause RX Statistics Counters Collection"]} {
		reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x0
		dashboard_set_property $dash_s10_100g_0 pause_rx_stats text "Pause RX Statistics Counters Collection"
		dashboard_set_property $dash_s10_100g_0 rx_stats_pause_d text "unpaused"
	}	
}

proc proc_clear_tx_stats_parity {} {
	global dash_s10_100g_0
	global MAIN_DICT_s10_100g_0
	reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x2
	dashboard_set_property $dash_s10_100g_0 tx_stats_parity_led color black
}

proc proc_clear_rx_stats_parity {} {
	global dash_s10_100g_0
	global MAIN_DICT_s10_100g_0
	reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x2
	dashboard_set_property $dash_s10_100g_0 rx_stats_parity_led color black
}

proc proc_reset_tx_stats {} {
	global dash_s10_100g_0
	global MAIN_DICT_s10_100g_0
	reg_write  [dict get $MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x1
	proc_read_tx_stats
}

proc proc_reset_rx_stats {} {
	global dash_s10_100g_0
	global MAIN_DICT_s10_100g_0
	reg_write  [dict get $MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG] [dict get $MAIN_DICT_s10_100g_0 OFFSET_S10CSR] 0x1
	proc_read_rx_stats
}



# ================================================================== 
# 	XCVR RECONFIG
# ==================================================================
dict set MAIN_DICT_s10_100g_0 ADDR_LT_ADAPBLOCK 0x171
dict set MAIN_DICT_s10_100g_0 ADDR_LT_ADAPWRITE 0x149
dict set MAIN_DICT_s10_100g_0 ADDR_LT_ADAPREAD 0x17E
dict set MAIN_DICT_s10_100g_0 ADDR_LT_VOD 0x109
dict set MAIN_DICT_s10_100g_0 ADDR_LT_POST 0x105
dict set MAIN_DICT_s10_100g_0 ADDR_LT_PRE 0x107

# ================================================================== 
# 	General 40GBASE-KR4/CR4 Registers
# ==================================================================
#
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04B0	0x00B0
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04B1	0x00B1
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04B2	0x00B2
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04B5	0x00B5
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04B8	0x00B8
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04BB	0x00BB

# ================================================================== 
# 	Auto-negotiation Registers
# ==================================================================
#
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C0	0x00C0
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C1	0x00C1
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C2	0x00C2
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C3	0x00C3
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C4	0x00C4
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C5	0x00C5
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C6	0x00C6
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C7	0x00C7
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C8	0x00C8
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04C9	0x00C9
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04CA	0x00CA
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04CB	0x00CB

# ================================================================== 
# 	Link training Registers
# ==================================================================
#
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D0	0x00D0
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D1	0x00D1
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D2	0x00D2
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D3	0x00D3
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D4	0x00D4
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D5	0x00D5
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04D6	0x00D6

dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E0	0x00E0
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E1	0x00E1
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E2	0x00E2
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E3	0x00E3
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E4	0x00E4
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E5	0x00E5
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E6	0x00E6
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E7	0x00E7
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E8	0x00E8
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04E9	0x00E9
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04EA	0x00EA
dict set MAIN_DICT_s10_100g_0 ADDR_KR_04EB	0x00EB

# ================================================================== 
# 	PHY-PCS Registers
# ==================================================================
#
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_REVID    0x0300
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_SCRTCH   0x0301
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_IPNAME2  0x0302
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_IPNAME1  0x0303
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_IPNAME0  0x0304
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PMACFG   0x0310
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_WORDLCK  0x0312
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PMALOOP  0x0313
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFSEL  0x0314
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PHYFLAG  0x0315
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_FREQLOCK 0x0321
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PHYCLK   0x0322
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_FRMERROR 0x0323
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_CLRFRMER 0x0324
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_SFTRESET 0x0325
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_FALIGNED 0x0326
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_AMLOCK   0x0328
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_LNDSKWED 0x0329
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_PCSVLANE 0x0330
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_RFCLKHZ  0x0340
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_RXCLKHZ  0x0341
dict set MAIN_DICT_s10_100g_0 ADDR_PHY_TXCLKHZ  0x0342

# ================================================================== 
# 	TX MAC Registers
# ==================================================================
#
#
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_REVID			0x0400
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_SCRATCH			0x0401
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_NAME0			0x0402
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_NAME1			0x0403
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_NAME2			0x0404
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_LINKFAULT		0x0405
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_IPGCOLREM		0x0406
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_MAXSIZECONFIG	0x0407
dict set MAIN_DICT_s10_100g_0 ADDR_TXMAC_CONTROL			0x040A

# ================================================================== 
# 	RX MAC Registers
# ==================================================================
#
#
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_REVID			0x0500
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_SCRATCH			0x0501
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_NAME0			0x0502
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_NAME1			0x0503
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_NAME2			0x0504
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_MAXSIZECONFIG	0x0506
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_CRCCONFIG		0x0507
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_LINKFAULT		0x0508
dict set MAIN_DICT_s10_100g_0 ADDR_RXMAC_CONTROL			0x050A

# ================================================================== 
# 	TX Statistics Registers Base
# ==================================================================
dict set MAIN_DICT_s10_100g_0 TX_BASE_STATS 0x800
dict set MAIN_DICT_s10_100g_0  TX_REG_FRAGMENTS_LO       0x800
dict set MAIN_DICT_s10_100g_0  TX_REG_FRAGMENTS_HI       0x801
dict set MAIN_DICT_s10_100g_0  TX_REG_JABBERS_LO         0x802
dict set MAIN_DICT_s10_100g_0  TX_REG_JABBERS_HI         0x803
dict set MAIN_DICT_s10_100g_0  TX_REG_CRCERR_LO          0x804
dict set MAIN_DICT_s10_100g_0  TX_REG_CRCERR_SIZEOK_HI   0x805
dict set MAIN_DICT_s10_100g_0  TX_REG_CRCERR_SIZEOK_LO   0x806
dict set MAIN_DICT_s10_100g_0  TX_REG_CRCERR_HI          0x807
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_DATA_ERR_LO  0x808
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_DATA_ERR_HI  0x809
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_DATA_ERR_LO  0x80A
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_DATA_ERR_HI  0x80B
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_DATA_ERR_LO  0x80C
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_DATA_ERR_HI  0x80D
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_CTRL_ERR_LO  0x80E
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_CTRL_ERR_HI  0x80F
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_CTRL_ERR_LO  0x810
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_CTRL_ERR_HI  0x811
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_CTRL_ERR_LO  0x812
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_CTRL_ERR_HI  0x813
dict set MAIN_DICT_s10_100g_0  TX_REG_PAUSE_ERR_LO       0x814
dict set MAIN_DICT_s10_100g_0  TX_REG_PAUSE_ERR_HI       0x815
dict set MAIN_DICT_s10_100g_0  TX_REG_64B_LO             0x816
dict set MAIN_DICT_s10_100g_0  TX_REG_64B_HI             0x817
dict set MAIN_DICT_s10_100g_0  TX_REG_65to127B_LO        0x818
dict set MAIN_DICT_s10_100g_0  TX_REG_65to127B_HI        0x819
dict set MAIN_DICT_s10_100g_0  TX_REG_128to255B_LO       0x81A
dict set MAIN_DICT_s10_100g_0  TX_REG_128to255B_HI       0x81B
dict set MAIN_DICT_s10_100g_0  TX_REG_256to511B_LO       0x81C
dict set MAIN_DICT_s10_100g_0  TX_REG_256to511B_HI       0x81D
dict set MAIN_DICT_s10_100g_0  TX_REG_512to1023B_LO      0x81E
dict set MAIN_DICT_s10_100g_0  TX_REG_512to1023B_HI      0x81F
dict set MAIN_DICT_s10_100g_0  TX_REG_1024to1518B_LO     0x820
dict set MAIN_DICT_s10_100g_0  TX_REG_1024to1518B_HI     0x821
dict set MAIN_DICT_s10_100g_0  TX_REG_1519toMAXB_LO      0x822
dict set MAIN_DICT_s10_100g_0  TX_REG_1519toMAXB_HI      0x823
dict set MAIN_DICT_s10_100g_0  TX_REG_OVERSIZE_LO        0x824
dict set MAIN_DICT_s10_100g_0  TX_REG_OVERSIZE_HI        0x825
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_DATA_OK_LO   0x826
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_DATA_OK_HI   0x827
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_DATA_OK_LO   0x828
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_DATA_OK_HI   0x829
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_DATA_OK_LO   0x82A
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_DATA_OK_HI   0x82B
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_CTRL_OK_LO   0x82C
dict set MAIN_DICT_s10_100g_0  TX_REG_MCAST_CTRL_OK_HI   0x82D
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_CTRL_OK_LO   0x82E
dict set MAIN_DICT_s10_100g_0  TX_REG_BCAST_CTRL_OK_HI   0x82F
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_CTRL_OK_LO   0x830
dict set MAIN_DICT_s10_100g_0  TX_REG_UCAST_CTRL_OK_HI   0x831
dict set MAIN_DICT_s10_100g_0  TX_REG_PAUSE_LO          0x832
dict set MAIN_DICT_s10_100g_0  TX_REG_PAUSE_HI          0x833
dict set MAIN_DICT_s10_100g_0  TX_REG_RNT_LO            0x834
dict set MAIN_DICT_s10_100g_0  TX_REG_RNT_HI            0x835

dict set MAIN_DICT_s10_100g_0 TX_REG_STAT_CFG		0x845
dict set MAIN_DICT_s10_100g_0 TX_REG_STAT_STATUS		0x846

# ================================================================== 
# 	RX Statistics Registers Base
# ==================================================================
dict set MAIN_DICT_s10_100g_0 RX_BASE_STATS 0x900
dict set MAIN_DICT_s10_100g_0  RX_REG_FRAGMENTS_LO       0x900
dict set MAIN_DICT_s10_100g_0  RX_REG_FRAGMENTS_HI       0x901
dict set MAIN_DICT_s10_100g_0  RX_REG_JABBERS_LO         0x902
dict set MAIN_DICT_s10_100g_0  RX_REG_JABBERS_HI         0x903
dict set MAIN_DICT_s10_100g_0  RX_REG_CRCERR_LO          0x904
dict set MAIN_DICT_s10_100g_0  RX_REG_CRCERR_SIZEOK_HI   0x905
dict set MAIN_DICT_s10_100g_0  RX_REG_CRCERR_SIZEOK_LO   0x906
dict set MAIN_DICT_s10_100g_0  RX_REG_CRCERR_HI          0x907
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_DATA_ERR_LO  0x908
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_DATA_ERR_HI  0x909
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_DATA_ERR_LO  0x90A
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_DATA_ERR_HI  0x90B
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_DATA_ERR_LO  0x90C
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_DATA_ERR_HI  0x90D
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_CTRL_ERR_LO  0x90E
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_CTRL_ERR_HI  0x90F
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_CTRL_ERR_LO  0x910
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_CTRL_ERR_HI  0x911
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_CTRL_ERR_LO  0x912
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_CTRL_ERR_HI  0x913
dict set MAIN_DICT_s10_100g_0  RX_REG_PAUSE_ERR_LO       0x914
dict set MAIN_DICT_s10_100g_0  RX_REG_PAUSE_ERR_HI       0x915
dict set MAIN_DICT_s10_100g_0  RX_REG_64B_LO             0x916
dict set MAIN_DICT_s10_100g_0  RX_REG_64B_HI             0x917
dict set MAIN_DICT_s10_100g_0  RX_REG_65to127B_LO        0x918
dict set MAIN_DICT_s10_100g_0  RX_REG_65to127B_HI        0x919
dict set MAIN_DICT_s10_100g_0  RX_REG_128to255B_LO       0x91A
dict set MAIN_DICT_s10_100g_0  RX_REG_128to255B_HI       0x91B
dict set MAIN_DICT_s10_100g_0  RX_REG_256to511B_LO       0x91C
dict set MAIN_DICT_s10_100g_0  RX_REG_256to511B_HI       0x91D
dict set MAIN_DICT_s10_100g_0  RX_REG_512to1023B_LO      0x91E
dict set MAIN_DICT_s10_100g_0  RX_REG_512to1023B_HI      0x91F
dict set MAIN_DICT_s10_100g_0  RX_REG_1024to1518B_LO     0x920
dict set MAIN_DICT_s10_100g_0  RX_REG_1024to1518B_HI     0x921
dict set MAIN_DICT_s10_100g_0  RX_REG_1519toMAXB_LO      0x922
dict set MAIN_DICT_s10_100g_0  RX_REG_1519toMAXB_HI      0x923
dict set MAIN_DICT_s10_100g_0  RX_REG_OVERSIZE_LO        0x924
dict set MAIN_DICT_s10_100g_0  RX_REG_OVERSIZE_HI        0x925
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_DATA_OK_LO   0x926
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_DATA_OK_HI   0x927
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_DATA_OK_LO   0x928
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_DATA_OK_HI   0x929
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_DATA_OK_LO   0x92A
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_DATA_OK_HI   0x92B
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_CTRL_OK_LO   0x92C
dict set MAIN_DICT_s10_100g_0  RX_REG_MCAST_CTRL_OK_HI   0x92D
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_CTRL_OK_LO   0x92E
dict set MAIN_DICT_s10_100g_0  RX_REG_BCAST_CTRL_OK_HI   0x92F
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_CTRL_OK_LO   0x930
dict set MAIN_DICT_s10_100g_0  RX_REG_UCAST_CTRL_OK_HI   0x931
dict set MAIN_DICT_s10_100g_0  RX_REG_PAUSE_LO          0x932
dict set MAIN_DICT_s10_100g_0  RX_REG_PAUSE_HI          0x933
dict set MAIN_DICT_s10_100g_0  RX_REG_RNT_LO            0x934
dict set MAIN_DICT_s10_100g_0  RX_REG_RNT_HI            0x935

dict set MAIN_DICT_s10_100g_0 RX_REG_STAT_CFG		0x945
dict set MAIN_DICT_s10_100g_0 RX_REG_STAT_STATUS		0x946