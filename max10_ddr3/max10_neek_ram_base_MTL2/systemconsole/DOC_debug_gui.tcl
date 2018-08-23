####################################################################
# Drive On A Chip System Console Debug GUI
# Start Altera System Console application and type "source DOC_debug_gui.tcl" to launch
####################################################################

namespace eval DOC_gui {


	proc dec2hex {value} {
	   # Creates a 32 bit hex number from a signed decimal number
	   # Replace all non-decimal characters
	   regsub -all {[^0-9\.\-]} $value {} newtemp
	   set value [string trim $newtemp]
	   if {$value < 2147483647 && $value > -2147483648} {
		  set tempvalue [format "%#010X" [expr $value]]
		  return [string range $tempvalue 2 9]
	   } elseif {$value < -2147483647} {
		  return "80000000"
	   } else {
		  return "7FFFFFFF"
	   }
	}

	proc dec2hex16 {value} {
	   # Creates a 16 bit hex number from a signed decimal number
	   # Replace all non-decimal characters
	   regsub -all {[^0-9\.\-]} $value {} newtemp
	   set value [string trim $newtemp]
	   if {$value < 32767 && $value > -32768} {
		  set tempvalue [format "%#010X" [expr $value]]
		  return [string range $tempvalue 6 9]
	   } elseif {$value < -32767} {
		  return "8000"
	   } else {
		  return "7FFF"
	   }
	}

	proc hex2dec {hexvalue} {
	   # Creates an unsigned decimal number from a 63 bit hex value
		set total "0000000000000000"
	   set mask "7FFFFFFF"
	   # replace from the end
		set start 15
	   # Replace all non-hex characters
	   regsub -all {[^0-9A-F\.\-]} $hexvalue {} newtemp
	   set hexvalue [string trim $newtemp]
	   # Go from the end to the start
		for {set i [expr [string length $hexvalue] -1]} {$i > -1} {incr i -1} {
		  # Get the next hex digit
			set j [string toupper [string index $hexvalue $i]]
		  # Add it to the big string
			set total [string replace $total $start $start $j]
			incr start -1
		}
		set nlower [string range $total 8 15]
		set nupper [string range $total 0 7]
	   # clear top bit to keep as positive. Also adds in "0x" at the start
	   set nupper "[format "%#010X" [expr "0x$nupper" & "0x$mask"]]"
	   # Now set to 64 bit - use a string to represent the number to avoid integer size limits
	   set total "[expr [format "%u" "0x$nlower"] + (4294967295 * [format "%u" "$nupper"])]"
		return $total
	}

	proc uhex2dec32 {hexvalue} {
	   # Creates an unsigned decimal number from a 32 bit hex value
	   # Replace all non-hex characters
	   regsub -all {[^0-9A-Fa-f\.\-]} $hexvalue {} newtemp
	   set hexvalue [string trim $newtemp]
	   #trim to 8 characters
	   set hexvalue [string range $hexvalue [expr [string length $hexvalue] - 8] [expr [string length $hexvalue] - 1]]
	   return  [format "%#u" [expr "0x$hexvalue"]] 
	} 
	   
	proc shex2dec32 {hexvalue} {
	   # Creates a signed decimal number from a 32 bit hex value
	   # Replace all non-hex characters
	   regsub -all {[^0-9A-Fa-f\.\-]} $hexvalue {} newtemp
	   set hexvalue [string trim $newtemp]
	   #trim to 8 characters
	   set hexvalue [string range $hexvalue [expr [string length $hexvalue] - 8] [expr [string length $hexvalue] - 1]]
	   return  [format "%#i" [expr "0x$hexvalue"]]
	#   return  [format "%#u" [expr "0x$hexvalue"]]
	}

	proc uhex2dec16 {hexvalue} {
	   # Creates an unsigned decimal number from a 16 bit hex value
	   # Replace all non-hex characters
	   regsub -all {[^0-9A-Fa-f\.\-]} $hexvalue {} newtemp
	   set hexvalue [string trim $newtemp]
	   #trim to 4 characters
	   set hexvalue [string range $hexvalue [expr [string length $hexvalue] - 4] [expr [string length $hexvalue] - 1]]
	   set value [format "%#u" [expr "0x$hexvalue"]]
	   return $value
	}

	proc shex2dec16 {hexvalue} {
	   # Creates an unsigned decimal number from a 16 bit hex value
	   # Replace all non-hex characters
	   regsub -all {[^0-9A-Fa-f\.\-]} $hexvalue {} newtemp
	   set hexvalue [string trim $newtemp]
	   #trim to 4 characters
	   set hexvalue [string range $hexvalue [expr [string length $hexvalue] - 4] [expr [string length $hexvalue] - 1]]
	   # Convert to signed number
	   set value [format "%#u" [expr "0x$hexvalue"]]
	   if {$value >  32767} {
		  set value [expr ($value - 65536)]
	   }
	   return $value
	}


	#Convert hex/decimal represenation of single-precision IEE754 number to floating point
	#Used when reading a 32-bit value from hardware which represents floating point
	proc hex2singlef {hexstr} {
		set hexstr [expr $hexstr]
		set hexstr [format "%08X" $hexstr]
		set hextmp [ binary format H8 $hexstr ]
		binary scan $hextmp i itmp
		set ftmp [ binary format I $itmp ]
		binary scan $ftmp f float2
		return $float2
	}

	#Convert floating point value to a hex/decimal represenation of single-precision IEE754
	#Used when writing a TCL floating point to a 32-bit hardware location which represents single floating point
	proc singlef2hex {single} {
		set ftmp [binary format f $single]
		binary scan $ftmp I itmp
		set hextmp [binary format i $itmp]
		binary scan $hextmp H8 hexval
		return 0x$hexval
	}

	proc isnan {x} {
		if { ![string is double $x] || $x != $x } {
			return 1
		} else {
			return 0
		}
	}

	proc add_combo_entry {dash group handle label_text tooltip combo_entries default_entry onchange} {
		dashboard_add $dash $handle group $group
		dashboard_set_property $dash $handle title ""
		dashboard_set_property $dash $handle itemsPerRow 2

		dashboard_add $dash ${handle}_label label $handle
		dashboard_set_property $dash ${handle}_label text $label_text
		dashboard_set_property $dash ${handle}_label preferredWidth 120
		dashboard_set_property $dash ${handle}_label toolTip $tooltip
		
		
		dashboard_add $dash ${handle}_entry comboBox $handle
		dashboard_set_property $dash ${handle}_entry options $combo_entries
		dashboard_set_property $dash ${handle}_entry selected $default_entry
		dashboard_set_property $dash ${handle}_entry preferredWidth 80
		dashboard_set_property $dash ${handle}_entry onChange $onchange
		dashboard_set_property $dash ${handle}_entry toolTip $tooltip
	}


	proc add_text_entry {dash group handle label_text tooltip default_value onchange} {
		dashboard_add $dash $handle group $group
		dashboard_set_property $dash $handle title ""
		dashboard_set_property $dash $handle itemsPerRow 2

		dashboard_add $dash ${handle}_label label $handle
		dashboard_set_property $dash ${handle}_label text $label_text
		dashboard_set_property $dash ${handle}_label preferredWidth 120
		dashboard_set_property $dash ${handle}_label toolTip $tooltip

		dashboard_add $dash ${handle}_entry textField $handle
		dashboard_set_property $dash ${handle}_entry text $default_value
		dashboard_set_property $dash ${handle}_entry toolTip $tooltip
		dashboard_set_property $dash ${handle}_entry preferredWidth 80
	}

	# Time data buffers in HPS DDR - offset by 0x08000000 by adress span expander
	set SYS_CONSOLE_FFT0_IN_PING_BASE_HEX		0x00050000
	set SYS_CONSOLE_FFT0_IN_PONG_BASE_HEX		0x00058000
	set SYS_CONSOLE_FFT1_IN_PING_BASE_HEX		0x00060000
	set SYS_CONSOLE_FFT1_IN_PONG_BASE_HEX		0x00068000

	# FFT output buffers in HPS DDR - offset by 0x08000000 by adress span expander
	set SYS_CONSOLE_FFT0_OUT_PING_BASE_HEX		0x00070000
	set SYS_CONSOLE_FFT0_OUT_PONG_BASE_HEX		0x00078000
	set SYS_CONSOLE_FFT1_OUT_PING_BASE_HEX		0x00080000
	set SYS_CONSOLE_FFT1_OUT_PONG_BASE_HEX		0x00088000
	set SYS_CONSOLE_MAGSQ0_PING_BASE_HEX		0x00090000
	set SYS_CONSOLE_MAGSQ0_PONG_BASE_HEX		0x00094000
	set SYS_CONSOLE_MAGSQ1_PING_BASE_HEX		0x00098000
	set SYS_CONSOLE_MAGSQ1_PONG_BASE_HEX		0x0009c000
	set SYS_CONSOLE_MAGSQ0_PK_PING_BASE_HEX		0x000a0000
	set SYS_CONSOLE_MAGSQ0_PK_PONG_BASE_HEX		0x000a0200
	set SYS_CONSOLE_MAGSQ1_PK_PING_BASE_HEX		0x000a0400
	set SYS_CONSOLE_MAGSQ1_PK_PONG_BASE_HEX		0x000a0600
	set SYS_CONSOLE_FFT0_OUT_PING_BASE 			[expr $SYS_CONSOLE_FFT0_OUT_PING_BASE_HEX]
	set SYS_CONSOLE_FFT0_OUT_PONG_BASE 			[expr $SYS_CONSOLE_FFT0_OUT_PONG_BASE_HEX]
	set SYS_CONSOLE_FFT1_OUT_PING_BASE 			[expr $SYS_CONSOLE_FFT1_OUT_PING_BASE_HEX]
	set SYS_CONSOLE_FFT1_OUT_PONG_BASE 			[expr $SYS_CONSOLE_FFT1_OUT_PONG_BASE_HEX]
	set SYS_CONSOLE_MAGSQ0_PING_BASE 			[expr $SYS_CONSOLE_MAGSQ0_PING_BASE_HEX]
	set SYS_CONSOLE_MAGSQ0_PONG_BASE 			[expr $SYS_CONSOLE_MAGSQ0_PONG_BASE_HEX]
	set SYS_CONSOLE_MAGSQ1_PING_BASE 			[expr $SYS_CONSOLE_MAGSQ1_PING_BASE_HEX]
	set SYS_CONSOLE_MAGSQ1_PONG_BASE 			[expr $SYS_CONSOLE_MAGSQ1_PONG_BASE_HEX]
	set SYS_CONSOLE_MAGSQ0_PK_PING_BASE			[expr $SYS_CONSOLE_MAGSQ0_PK_PING_BASE_HEX]
	set SYS_CONSOLE_MAGSQ0_PK_PONG_BASE			[expr $SYS_CONSOLE_MAGSQ0_PK_PONG_BASE_HEX]
	set SYS_CONSOLE_MAGSQ1_PK_PING_BASE			[expr $SYS_CONSOLE_MAGSQ1_PK_PING_BASE_HEX]
	set SYS_CONSOLE_MAGSQ1_PK_PONG_BASE			[expr $SYS_CONSOLE_MAGSQ1_PK_PONG_BASE_HEX]


	set DOC_DBG_AXIS_NUM 0

	set SYS_CONSOLE_TRACE_BASE_HEX		0x00020000
	set SYS_CONSOLE_DEBUG_RAM_BASE 			[expr 0x00040000]

	set DEBUG_ADDR_SPACE_PER_AXIS       64

	# General Drive Status (Write only)
	set DOC_DBG_DRIVE_STATE             0
	set DOC_DBG_RUNTIME                 1
	set DOC_DBG_DSP_MODE                2
	set DOC_DBG_DEMO_MODE_UN            3
	set DOC_DBG_LATENCY                 4
	set DOC_DBG_DUMP_MODE               5
	set DOC_DBG_TRIG_SEL                6
	set DOC_DBG_TRIG_EDGE               7
	set DOC_DBG_TRIG_VALUE              8
	set DOC_DBG_FFT_SELECT				9

	# Drive Performance Status (Write only)
	set DOC_DBG_SPEED                   10
	set DOC_DBG_SPEED_FILT              11
	set DOC_DBG_POSITION                12
	set DOC_DBG_V_RMS_UN                13
	set DOC_DBG_I_RMS_UN                14
	set DOC_DBG_POWER_INST_UN           15
	set DOC_DBG_POWER_CUM_UN            16

	# Drive Command Inputs (Read-only except for buttons handshake)
	set DOC_DBG_NUM_BUTTONS             8
	set DOC_DBG_BUTTONS                 17
	set DOC_DBG_OL_EN                   [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 1)]
	set DOC_DBG_FFT0_PK_DET_LIM         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 2)]
	set DOC_DBG_FFT1_PK_DET_LIM         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 3)]

	set DOC_DBG_I_PI_TUNE_EN_UN         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 4)]
	set DOC_DBG_I_PI_KP                 [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 5)]
	set DOC_DBG_I_PI_KI                 [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 6)]

	set DOC_DBG_SPEED_PI_TUNE_EN_UN     [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 7)]
	set DOC_DBG_SPEED_PI_KP             [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 8)]
	set DOC_DBG_SPEED_PI_KI             [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 9)]

	set DOC_DBG_SPEED_SETP0             [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 10)]
	set DOC_DBG_SPEED_SETP1_UN          [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 11)]
	set DOC_DBG_SPEED_SW_PERIOD_UN      [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 12)]

	set DOC_DBG_AXIS_SELECT             [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 13)]
	set DOC_DBG_FFT_PING_STATUS         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 14)]
	set DOC_DBG_FFT_PONG_STATUS         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 15)]

	set DOC_DBG_POS_SETP0               [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 16)]
	set DOC_DBG_POS_SETP1_UN            [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 17)]
	set DOC_DBG_POS_SW_PERIOD_UN        [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 18)]

	set DOC_DBG_I_PI_FB_LIM           	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 19)]
	set DOC_DBG_I_PI_OP_LIM           	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 20)]

	set DOC_DBG_SPEED_PI_FB_LIM        	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 21)]
	set DOC_DBG_FILT_DC_GAIN_FL        	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 22)]

	set DOC_DBG_POS_MODE               	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 23)]
	set DOC_DBG_POS_SPEED               [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 24)]

	set DOC_DBG_POS_PI_KP              	[expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 25)]
	set DOC_DBG_POS_SPDFF_KP            [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 26)]

	set DOC_DBG_CMD_WAVE_PERIOD         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 27)]
	set DOC_DBG_CMD_WAVE_OFFSET         [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 28)]
	set DOC_DBG_CMD_WAVE_AMP_POS        [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 29)]
	set DOC_DBG_CMD_WAVE_AMP_SPD        [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 30)]
	set DOC_DBG_CMD_WAVE_TYPE           [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 31)]

	set DOC_DBG_FILT_FN_HZ_FL           [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 32)]
	set DOC_DBG_FILT_FD_HZ_FL           [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 33)]
	set DOC_DBG_FILT_ZN_FL              [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 34)]
	set DOC_DBG_FILT_ZD_FL              [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 35)]
	set DOC_DBG_FILT_EN                 [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 36)]

	set UNUSED_DOC_DBG_FFT_1_PING_STATUS       [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 37)]
	set UNUSED_DOC_DBG_FFT_1_PONG_STATUS       [expr ($DOC_DBG_NUM_BUTTONS + $DOC_DBG_BUTTONS + 38)]


	proc debug_base_addr {dn word_offset} {
			return [expr {$::DOC_gui::SYS_CONSOLE_DEBUG_RAM_BASE + ($dn * $::DOC_gui::DEBUG_ADDR_SPACE_PER_AXIS * 4) + ($word_offset * 4)}];
	}


	proc debug_write_command {dn reg_word_addr value} {
		set retval [debug_base_addr $dn $reg_word_addr]
		master_write_32 $::DOC_gui::jd_path $retval $value
		return $retval;
	}

	proc debug_read_status {dn reg_word_addr} {
		set addrval [debug_base_addr $dn $reg_word_addr]
		set retval [master_read_32 $::DOC_gui::jd_path $addrval 1]
		return [shex2dec32 $retval];
	}

	proc debug_write_command_float {dn reg_word_addr value} {
		return [debug_write_command {$dn $reg_word_addr [singlef2hex $value]}]
	}

	proc debug_read_status_float {dn reg_word_addr} {
		return [hex2singlef [ debug_read_status {dn reg_word_addr}]]
	}

	variable SPEED_FRAC_BITS
	variable speed_frac_bits_scale
	
	set SPEED_FRAC_BITS 0
	set speed_frac_bits_scale [expr (1 << $SPEED_FRAC_BITS) * 1.0]
	puts $speed_frac_bits_scale


	variable jd_path
	set jd_path 0
	variable monitor_path
	variable monitor_path1
	variable monitor_path2

	variable last_time
	variable status_running
	set status_running 0
	set last_time 0
	variable dash
	variable series0
	variable series1
	variable series2
	variable start_count
	variable trace_data
	variable speed
	variable speed_direction
	variable dbg_motor_mode
	variable dbg_dsp_mode
	variable dbg_dump_mode

	variable dump_data_downloaded
	variable connected
	variable speedinterval_updating
	variable fftinterval_updating
	variable positioninterval_updating
	variable enable_FFT

	variable plot_fft0_peaks
	variable plot_fft1_peaks
	
	set connected 0
	set speedinterval_updating 0
	set fftinterval_updating 0
	set positioninterval_updating 0
	set dbg_motor_mode 0
	set dbg_dsp_mode 0
	set dbg_dump_mode 0
	set dbg_speed_request 100

	set dump_data_downloaded 0
	set trace_data 0
	set speed 100
	set speed_direction 1
	
	set myplot_u [list Voltage_U]
	set myplot_v [list Voltage_V]
	set myplot_u [list Voltage_W]
	set myplot_phi_e [list Phi_elec]

	set start_count 0
	set trace_depth 256
	set enable_FFT 0
	set fft_demo_stage 6
	set plot_fft0_peaks 0
	set plot_fft1_peaks 0
    set demo_stage 6	

	
	set dash [ add_service dashboard DOC_gui "Drive On A Chip Debug GUI" "Tools/DOC GUI" ]
	dashboard_set_property $dash self title ""
	dashboard_set_property $dash self visible true
	dashboard_set_property $dash self itemsPerRow 1
	dashboard_set_property $dash self developmentMode true

	# Add some groups for layout

##################### Create Tabbed Group ready for tabs to be added
	dashboard_add $dash mytabGroup tabbedGroup self
	dashboard_set_property $dash mytabGroup expandableX true
	dashboard_set_property $dash mytabGroup expandableY true

##################### Create General Info Tab
	dashboard_add $dash tabgeneralGroup group mytabGroup
	dashboard_set_property $dash tabgeneralGroup title "General"
	dashboard_set_property $dash tabgeneralGroup itemsPerRow 2
	dashboard_set_property $dash tabgeneralGroup expandableX true


##################### Create Extra Info Tab
	dashboard_add $dash extrainfoGroup group mytabGroup
	dashboard_set_property $dash extrainfoGroup title "Control and Diagnostics"
	dashboard_set_property $dash extrainfoGroup itemsPerRow 1
	dashboard_set_property $dash extrainfoGroup expandableX true
	dashboard_set_property $dash extrainfoGroup expandableY true



##################### Create FFT Tab
	
	dashboard_add $dash FFTGroup group mytabGroup
	dashboard_set_property $dash FFTGroup visible false
	if {$enable_FFT == 1} {
		dashboard_set_property $dash FFTGroup visible true
		dashboard_set_property $dash FFTGroup title "Vibration Suppression"
        dashboard_set_property $dash FFTGroup itemsPerRow 1
	    dashboard_set_property $dash FFTGroup expandableX true
	    dashboard_set_property $dash FFTGroup expandableY true
	} else {
		dashboard_set_property $dash FFTGroup visible false
	}



##################### Create Groups in General Info Tab

	dashboard_add $dash buttonsGroup group tabgeneralGroup
	dashboard_set_property $dash buttonsGroup title "Demo Connect"
	dashboard_set_property $dash buttonsGroup expandableX true
	dashboard_set_property $dash buttonsGroup expandableY true
    dashboard_set_property $dash buttonsGroup itemsPerRow 2

##################### Add Dials group

	dashboard_add $dash dialsGroup group tabgeneralGroup
	dashboard_set_property $dash dialsGroup title "Calculate Status"
    dashboard_set_property $dash dialsGroup itemsPerRow 2
	dashboard_set_property $dash dialsGroup expandableY true	
	dashboard_set_property $dash dialsGroup expandableX true	
	
	dashboard_add $dash speedcontrolGroup group tabgeneralGroup
	dashboard_set_property $dash speedcontrolGroup title "Speed Control"
	dashboard_set_property $dash speedcontrolGroup expandableX true
    dashboard_set_property $dash speedcontrolGroup itemsPerRow 1

	dashboard_add $dash positioncontrolGroup group tabgeneralGroup
	dashboard_set_property $dash positioncontrolGroup title "Position Control"
	dashboard_set_property $dash positioncontrolGroup expandableX true
	dashboard_set_property $dash positioncontrolGroup expandableY true
    dashboard_set_property $dash positioncontrolGroup itemsPerRow 1


##################### Add spacer group

	dashboard_add $dash tabgeneralspacer group tabgeneralGroup
	dashboard_set_property $dash tabgeneralspacer title ""
	dashboard_set_property $dash tabgeneralspacer minHeight 300
	dashboard_set_property $dash tabgeneralspacer preferredHeight 300	

##################### Add Buttons to General Info Tab
	
	dashboard_add $dash connectbutton button buttonsGroup
	dashboard_set_property $dash connectbutton text "Connect JTAG"
	dashboard_set_property $dash connectbutton onClick {::DOC_gui::connect 1}
	
	dashboard_add $dash pushbutton4 button buttonsGroup
	dashboard_set_property $dash pushbutton4 text "Reset Motor"
	dashboard_set_property $dash pushbutton4 onClick {::DOC_gui::button 3}

	add_combo_entry $dash buttonsGroup axiscombo "Axis Select:" "Select which motor axis to control" [list 0 1 2 3] 0 {::DOC_gui::axis_update axiscombo}


	dashboard_add $dash pushbutton5 button buttonsGroup
	dashboard_set_property $dash pushbutton5 text "Enable Open Loop Mode"
	dashboard_set_property $dash pushbutton5 onClick {::DOC_gui::openloop_update 0}


##################### Add status text info

	dashboard_add $dash status_label label buttonsGroup
	dashboard_set_property $dash status_label text "Status: Not Connected"
	dashboard_add $dash status_label1 label buttonsGroup
	dashboard_set_property $dash status_label1 text ""
	



##################### Create Groups in FFT Tab
	
	dashboard_add $dash VibrationTextGroup group FFTGroup
	dashboard_set_property $dash VibrationTextGroup title "Vibration Suppression Demonstration"
	dashboard_set_property $dash VibrationTextGroup expandableX true
	dashboard_set_property $dash VibrationTextGroup minHeight 165	
	dashboard_set_property $dash VibrationTextGroup preferredHeight 165
	dashboard_set_property $dash VibrationTextGroup itemsPerRow 1

	dashboard_add $dash fftupdatebutton button VibrationTextGroup
	dashboard_set_property $dash fftupdatebutton text "Start Demo"
	dashboard_set_property $dash fftupdatebutton onClick {::DOC_gui::fftinterval_button 0}

	dashboard_add $dash SPS10text1 text VibrationTextGroup
	#dashboard_add $dash10 SPS10text2 text self
	dashboard_set_property $dash SPS10text1 editable false
	#dashboard_set_property $dash10 SPS10text2 editable false
	dashboard_set_property $dash SPS10text1 htmlCapable true
	#dashboard_set_property $dash10 SPS10text2 htmlCapable true
	dashboard_set_property $dash SPS10text1 expandableX true
    dashboard_set_property $dash SPS10text1 expandableY true
  
	dashboard_set_property $dash SPS10text1 text "\
		<body bgcolor=#F5F5F5><font face=\"Tahoma\" size=\"+4\"> Altera Motor Control <br></font>\
	<font face=\"Verdana\" size=\"5\"> Multi-axis Motion Control<br></font>\
	<font face=\"Arial\" color=\"red\"> Vibration Suppression <br></font></body>	\
	"
	
	
	dashboard_add $dash FFTxyChartGroup0 group FFTGroup
	dashboard_set_property $dash FFTxyChartGroup0 title ""
	dashboard_set_property $dash FFTxyChartGroup0 expandableX true
	dashboard_set_property $dash FFTxyChartGroup0 minHeight 500
	dashboard_set_property $dash FFTxyChartGroup0 preferredHeight 500
	dashboard_set_property $dash FFTxyChartGroup0 itemsPerRow 2

	dashboard_add $dash FFTselectGroup2 group FFTGroup
	dashboard_set_property $dash FFTselectGroup2 title "FFT and Peak Detection"
	dashboard_set_property $dash FFTselectGroup2 expandableX true
	dashboard_set_property $dash FFTselectGroup2 minHeight 125	
	dashboard_set_property $dash FFTselectGroup2 preferredHeight 125
	dashboard_set_property $dash FFTselectGroup2 itemsPerRow 5

	dashboard_add $dash FFTcmdwaveGroup group FFTGroup
	dashboard_set_property $dash FFTcmdwaveGroup title "Command Waveform"
	dashboard_set_property $dash FFTcmdwaveGroup expandableX true
	dashboard_set_property $dash FFTcmdwaveGroup minHeight 125	
	dashboard_set_property $dash FFTcmdwaveGroup preferredHeight 125
	dashboard_set_property $dash FFTcmdwaveGroup itemsPerRow 4

	dashboard_add $dash FFTfiltGroup group FFTGroup
	dashboard_set_property $dash FFTfiltGroup title "2nd Order IIR Filter"
	dashboard_set_property $dash FFTfiltGroup expandableX true
	dashboard_set_property $dash FFTfiltGroup minHeight 125	
	dashboard_set_property $dash FFTfiltGroup preferredHeight 125
	dashboard_set_property $dash FFTfiltGroup itemsPerRow 4

#	dashboard_add $dash FFTtuningGroup2 group FFTGroup
#	dashboard_set_property $dash FFTtuningGroup2 visible false
#	dashboard_set_property $dash FFTtuningGroup2 title "Trace Setup"
#	dashboard_set_property $dash FFTtuningGroup2 expandableX true
#	dashboard_set_property $dash FFTtuningGroup2 minHeight 125	
#	dashboard_set_property $dash FFTtuningGroup2 preferredHeight 125
#	dashboard_set_property $dash FFTtuningGroup2 itemsPerRow 4
	
#	dashboard_add $dash FFToldxyChartGroup0 group FFTGroup
#	dashboard_set_property $dash FFToldxyChartGroup0 visible false
#	dashboard_set_property $dash FFToldxyChartGroup0 title ""
#	dashboard_set_property $dash FFToldxyChartGroup0 expandableX true
#	dashboard_set_property $dash FFToldxyChartGroup0 minHeight 300
#	dashboard_set_property $dash FFToldxyChartGroup0 preferredHeight 300
#	dashboard_set_property $dash FFToldxyChartGroup0 itemsPerRow 2

#	dashboard_add $dash FFTspacerGroup group FFTGroup
#	dashboard_set_property $dash FFTspacerGroup title ""
#	dashboard_set_property $dash FFTspacerGroup minHeight 100
#	dashboard_set_property $dash FFTspacerGroup preferredHeight 100
	

##################### Create Groups in Extra Info Tab

#	dashboard_add $dash tuningGroup2 group extrainfoGroup
#	dashboard_set_property $dash tuningGroup2 title "Trace Setup"
#	dashboard_set_property $dash tuningGroup2 expandableX true
#	dashboard_set_property $dash tuningGroup2 minHeight 125	
#	dashboard_set_property $dash tuningGroup2 preferredHeight 125
#	dashboard_set_property $dash tuningGroup2 itemsPerRow 4

	dashboard_add $dash xyChartGroup0 group extrainfoGroup
	dashboard_set_property $dash xyChartGroup0 title ""
	dashboard_set_property $dash xyChartGroup0 expandableX true
	dashboard_set_property $dash xyChartGroup0 minHeight 1000
	dashboard_set_property $dash xyChartGroup0 preferredHeight 1000
	dashboard_set_property $dash xyChartGroup0 itemsPerRow 2
	
##################### Add FFT Charts

##################### Add Chart to FFT Tab
	
	dashboard_add $dash FFTtime0XY xyChart FFTxyChartGroup0
	dashboard_set_property $dash FFTtime0XY maximumItemCount 4096
	dashboard_set_property $dash FFTtime0XY title "Time Data TBD"
	dashboard_set_property $dash FFTtime0XY labelX "Time (ms)"
	dashboard_set_property $dash FFTtime0XY labelY "Data (units TBD)"
	dashboard_set_property $dash FFTtime0XY preferredWidth 600
	dashboard_set_property $dash FFTtime0XY showLegend true
	dashboard_set_property $dash FFTtime0XY expandableX true
	dashboard_set_property $dash FFTtime0XY expandableY true

	dashboard_add $dash FFTfft0XY xyChart FFTxyChartGroup0
	dashboard_set_property $dash FFTfft0XY maximumItemCount 4096
	dashboard_set_property $dash FFTfft0XY title "FFT Plot"
	dashboard_set_property $dash FFTfft0XY labelX "Frequency (Hz)"
	dashboard_set_property $dash FFTfft0XY labelY "Value"
	dashboard_set_property $dash FFTfft0XY preferredWidth 600
	dashboard_set_property $dash FFTfft0XY showLegend true
	dashboard_set_property $dash FFTfft0XY expandableX true
	dashboard_set_property $dash FFTfft0XY expandableY true

	dashboard_add $dash FFTtime1XY xyChart FFTxyChartGroup0
	dashboard_set_property $dash FFTtime1XY maximumItemCount 4096
	dashboard_set_property $dash FFTtime1XY title "Time Data TBD"
	dashboard_set_property $dash FFTtime1XY labelX "Time (ms)"
	dashboard_set_property $dash FFTtime1XY labelY "Data (units TBD)"
	dashboard_set_property $dash FFTtime1XY preferredWidth 600
	dashboard_set_property $dash FFTtime1XY showLegend true
	dashboard_set_property $dash FFTtime1XY expandableX true
	dashboard_set_property $dash FFTtime1XY expandableY true

	dashboard_add $dash FFTfft1XY xyChart FFTxyChartGroup0
	dashboard_set_property $dash FFTfft1XY maximumItemCount 4096
	dashboard_set_property $dash FFTfft1XY title "FFT Plot"
	dashboard_set_property $dash FFTfft1XY labelX "Frequency (Hz)"
	dashboard_set_property $dash FFTfft1XY labelY "Value"
	dashboard_set_property $dash FFTfft1XY preferredWidth 600
	dashboard_set_property $dash FFTfft1XY showLegend true
	dashboard_set_property $dash FFTfft1XY expandableX true
	dashboard_set_property $dash FFTfft1XY expandableY true

#	dashboard_add $dash FFTtuningGroup1c group FFToldxyChartGroup0
#	dashboard_set_property $dash FFTtuningGroup1c title "Position Control Loop"
#	dashboard_set_property $dash FFTtuningGroup1c expandableX true
#	dashboard_set_property $dash FFTtuningGroup1c minHeight 125	
#	dashboard_set_property $dash FFTtuningGroup1c preferredHeight 125
#	dashboard_set_property $dash FFTtuningGroup1c itemsPerRow 2


#	dashboard_add $dash FFTtuningGroup1b group FFToldxyChartGroup0
#	dashboard_set_property $dash FFTtuningGroup1b title "Speed Control Loop"
#	dashboard_set_property $dash FFTtuningGroup1b expandableX true
#	dashboard_set_property $dash FFTtuningGroup1b minHeight 125	
#	dashboard_set_property $dash FFTtuningGroup1b preferredHeight 125
#	dashboard_set_property $dash FFTtuningGroup1b itemsPerRow 2

#	dashboard_add $dash FFTtuningGroup1a group FFToldxyChartGroup0
#	dashboard_set_property $dash FFTtuningGroup1a title "Current Control Loop"
#	dashboard_set_property $dash FFTtuningGroup1a expandableX true
#	dashboard_set_property $dash FFTtuningGroup1a minHeight 125	
#	dashboard_set_property $dash FFTtuningGroup1a preferredHeight 125
#	dashboard_set_property $dash FFTtuningGroup1a itemsPerRow 2


#	dashboard_add $dash FFTxyChartGroup0spacer group FFToldxyChartGroup0
#	dashboard_set_property $dash FFTxyChartGroup0spacer title ""

	
##################### Add Charts


##################### Add Voltage SVPWM Chart to General Info Tab

	dashboard_add $dash VoltageXY xyChart xyChartGroup0
	dashboard_set_property $dash VoltageXY maximumItemCount 4096
	dashboard_set_property $dash VoltageXY title "Space Vector Modulation PWM"
	dashboard_set_property $dash VoltageXY labelX "Time (ms)"
	dashboard_set_property $dash VoltageXY labelY "Voltage (V)"
	dashboard_set_property $dash VoltageXY preferredWidth 600
	dashboard_set_property $dash VoltageXY showLegend true
	dashboard_set_property $dash VoltageXY expandableX true
	dashboard_set_property $dash VoltageXY expandableY true
#uncomment for 12.0
  #dashboard_set_property $dash VoltageXY range [list 0 2048 ]

  	dashboard_add $dash tuningGroup2 group xyChartGroup0
	dashboard_set_property $dash tuningGroup2 title "Trace Setup"
	dashboard_set_property $dash tuningGroup2 expandableY true
#	dashboard_set_property $dash VoltageXY expandableY true
#	dashboard_set_property $dash tuningGroup2 minHeight 125	
#	dashboard_set_property $dash tuningGroup2 preferredHeight 125
	dashboard_set_property $dash tuningGroup2 preferredWidth 500
	dashboard_set_property $dash tuningGroup2 expandableX false
	dashboard_set_property $dash tuningGroup2 itemsPerRow 2
  
	dashboard_add $dash CurrentXY xyChart xyChartGroup0
	dashboard_set_property $dash CurrentXY maximumItemCount 4096
	dashboard_set_property $dash CurrentXY title "Feedback Current (mA)"
	dashboard_set_property $dash CurrentXY labelX "Time (ms)"
	dashboard_set_property $dash CurrentXY labelY "Current (mA)"
	dashboard_set_property $dash CurrentXY preferredWidth 600
	dashboard_set_property $dash CurrentXY showLegend true
	dashboard_set_property $dash CurrentXY expandableX true
	dashboard_set_property $dash CurrentXY expandableY true

	dashboard_add $dash CurrentXYspacer group xyChartGroup0
	dashboard_set_property $dash CurrentXYspacer title ""


	dashboard_add $dash DQCurrentXY xyChart xyChartGroup0
	dashboard_set_property $dash DQCurrentXY maximumItemCount 4096
	dashboard_set_property $dash DQCurrentXY title "Direct & Quadrature Current (mA)"
	dashboard_set_property $dash DQCurrentXY labelX "Time (ms)"
	dashboard_set_property $dash DQCurrentXY labelY "Current (mA)"
	dashboard_set_property $dash DQCurrentXY preferredWidth 600
	dashboard_set_property $dash DQCurrentXY showLegend true
	dashboard_set_property $dash DQCurrentXY expandableX true
	dashboard_set_property $dash DQCurrentXY expandableY true

	dashboard_add $dash tuningGroup1a group xyChartGroup0
	dashboard_set_property $dash tuningGroup1a title "Current Control Loop"
	dashboard_set_property $dash tuningGroup1a preferredWidth 500
	dashboard_set_property $dash tuningGroup1a expandableX false
	dashboard_set_property $dash tuningGroup1a expandableY true
	dashboard_set_property $dash tuningGroup1a itemsPerRow 2

	dashboard_add $dash SpeedXY xyChart xyChartGroup0
	dashboard_set_property $dash SpeedXY maximumItemCount 4096
	dashboard_set_property $dash SpeedXY title "Requested vs Actual Speed"
	dashboard_set_property $dash SpeedXY labelX "Time (ms)"
	dashboard_set_property $dash SpeedXY labelY "Speed (rpm)"
	dashboard_set_property $dash SpeedXY preferredWidth 600
	dashboard_set_property $dash SpeedXY showLegend true
	dashboard_set_property $dash SpeedXY expandableX true
	dashboard_set_property $dash SpeedXY expandableY true

	dashboard_add $dash tuningGroup1b group xyChartGroup0
	dashboard_set_property $dash tuningGroup1b title "Speed Control Loop"
	dashboard_set_property $dash tuningGroup1b preferredWidth 500
	dashboard_set_property $dash tuningGroup1b expandableX false
	dashboard_set_property $dash tuningGroup1b expandableY true
	dashboard_set_property $dash tuningGroup1b itemsPerRow 2

	dashboard_add $dash PosXY xyChart xyChartGroup0
	dashboard_set_property $dash PosXY maximumItemCount 4096
	dashboard_set_property $dash PosXY title "Position Control"
	dashboard_set_property $dash PosXY labelX "Time (ms)"
	dashboard_set_property $dash PosXY labelY "Position (deg)"
	dashboard_set_property $dash PosXY preferredWidth 600
	dashboard_set_property $dash PosXY showLegend true
	dashboard_set_property $dash PosXY expandableX true
	dashboard_set_property $dash PosXY expandableY true

	dashboard_add $dash tuningGroup1c group xyChartGroup0
	dashboard_set_property $dash tuningGroup1c title "Position Control Loop"
	dashboard_set_property $dash tuningGroup1c preferredWidth 500
	dashboard_set_property $dash tuningGroup1c expandableX false
	dashboard_set_property $dash tuningGroup1c expandableY true
	dashboard_set_property $dash tuningGroup1c itemsPerRow 2

	dashboard_add $dash speedadjustGroup group speedcontrolGroup
	dashboard_set_property $dash speedadjustGroup title "Speed Status"
	dashboard_set_property $dash speedadjustGroup expandableX true
	dashboard_set_property $dash speedadjustGroup minHeight 100	
	dashboard_set_property $dash speedadjustGroup preferredHeight 250
	dashboard_set_property $dash speedadjustGroup itemsPerRow 2

	dashboard_add $dash tuningGroup3 group speedcontrolGroup
	dashboard_set_property $dash tuningGroup3 title "Speed Demo Setup"
	dashboard_set_property $dash tuningGroup3 expandableX true
	dashboard_set_property $dash tuningGroup3 expandableY true
	dashboard_set_property $dash tuningGroup3 minHeight 100	
    dashboard_set_property $dash tuningGroup3 itemsPerRow 2

	dashboard_add $dash positionadjustGroup group positioncontrolGroup
	dashboard_set_property $dash positionadjustGroup title "Position Status"
	dashboard_set_property $dash positionadjustGroup expandableX true
	dashboard_set_property $dash positionadjustGroup minHeight 100	
	dashboard_set_property $dash positionadjustGroup preferredHeight 250
	dashboard_set_property $dash positionadjustGroup itemsPerRow 2

	dashboard_add $dash dial2a dial positionadjustGroup
	dashboard_set_property $dash dial2a expandableX true
	dashboard_set_property $dash dial2a expandableY true
	dashboard_set_property $dash dial2a title "Position Request (deg)"
	dashboard_set_property $dash dial2a min -360
	dashboard_set_property $dash dial2a max 360
	dashboard_set_property $dash dial2a tickSize [ expr 360 / 4 ]
	dashboard_set_property $dash dial2a preferredHeight 200
	dashboard_set_property $dash dial2a preferredWidth 270

	dashboard_add $dash dial2 dial positionadjustGroup
	dashboard_set_property $dash dial2 expandableX true
	dashboard_set_property $dash dial2 expandableY true
	dashboard_set_property $dash dial2 title "Position (deg)"
	dashboard_set_property $dash dial2 min -360
	dashboard_set_property $dash dial2 max 360
	dashboard_set_property $dash dial2 tickSize [ expr 360 / 4 ]
	dashboard_set_property $dash dial2 preferredHeight 200
	dashboard_set_property $dash dial2 preferredWidth 270


	dashboard_add $dash tuningGroup4 group positioncontrolGroup
	dashboard_set_property $dash tuningGroup4 title "Position Demo Setup"
	dashboard_set_property $dash tuningGroup4 expandableX true
	dashboard_set_property $dash tuningGroup4 minHeight 100	
	dashboard_set_property $dash tuningGroup4 preferredHeight 125
	dashboard_set_property $dash tuningGroup4 itemsPerRow 2



##################### Add Dials to Dials group


	#dashboard_add $dash pushbutton1 button dialsGroup
	#dashboard_set_property $dash pushbutton1 text "Change Calculate Mode"
	#dashboard_set_property $dash pushbutton1 onClick {::DOC_gui::button 0}

	dashboard_add $dash dial0 dial dialsGroup
	dashboard_set_property $dash dial0 expandableX true
	dashboard_set_property $dash dial0 expandableY true
	dashboard_set_property $dash dial0 title "Calculate Latency (us)"
	dashboard_set_property $dash dial0 max 50
	dashboard_set_property $dash dial0 tickSize [ expr 50.0 / 10 ]
	dashboard_set_property $dash dial0 preferredHeight 200
	dashboard_set_property $dash dial0 preferredWidth 270


	add_text_entry $dash tuningGroup1a I_Kp_text "Kp :" "Current Loop Proportional Gain" "999" dummy_callback
	add_text_entry $dash tuningGroup1a I_Ki_text "Ki :" "Current Loop Integral Gain" "999" dummy_callback

	add_text_entry $dash tuningGroup1a I_FB_Lim_text "Current Command Limit:" "Applied as Speed Loop Output Limit, Speed Loop Integrator Limit and Current Loop Error Limit" "999" dummy_callback
	add_text_entry $dash tuningGroup1a I_OP_Lim_text "Output Voltage Limit:" "Applied as Current Loop Output Limit and Current Loop Integrator Limit" "999" dummy_callback

	dashboard_add $dash tuneupdatebutton1a button tuningGroup1a
	dashboard_set_property $dash tuneupdatebutton1a text "Update Parameters"
	dashboard_set_property $dash tuneupdatebutton1a onClick {::DOC_gui::tune_update 0}

	add_text_entry $dash tuningGroup1b Speed_Kp_text "Speed Kp :" "Speed Loop Proportional Gain" "999" dummy_callback
	add_text_entry $dash tuningGroup1b Speed_Ki_text "Speed Ki :" "Speed Loop Integral Gain" "999" dummy_callback

	dashboard_add $dash tuneupdatebutton1b button tuningGroup1b
	dashboard_set_property $dash tuneupdatebutton1b text "Update Parameters"
	dashboard_set_property $dash tuneupdatebutton1b onClick {::DOC_gui::tune_update 0}

	add_text_entry $dash tuningGroup1c Position_Kp_text "Position Kp :" "Position Loop Proportional Gain" "999" dummy_callback
	add_text_entry $dash tuningGroup1c Position_SpeedFF_Kp_text "Position Ki :" "Position Loop Integral Gain" "999" dummy_callback

	dashboard_add $dash tuneupdatebutton1c button tuningGroup1c
	dashboard_set_property $dash tuneupdatebutton1c text "Update Parameters"
	dashboard_set_property $dash tuneupdatebutton1c onClick {::DOC_gui::tune_update 0}


##################################################################
#####Copy of tuning group for FFT tab
#	add_text_entry $dash FFTtuningGroup1a FFTI_Kp_text "Kp :" "Current Loop Proportional Gain" "999" dummy_callback
#	add_text_entry $dash FFTtuningGroup1a FFTI_Ki_text "Ki :" "Current Loop Integral Gain" "999" dummy_callback

#	add_text_entry $dash FFTtuningGroup1a FFTI_OP_Lim_text "Output Limit:" "Current Loop Output Saturation Limit" "999" dummy_callback
#	add_text_entry $dash FFTtuningGroup1a FFTI_FB_Lim_text "Feedback Limit:" "Current Loop Feedback Saturation Limit" "999" dummy_callback

#	add_text_entry $dash FFTtuningGroup1b FFTSpeed_Kp_text "Speed Kp :" "Speed Loop Proportional Gain" "999" dummy_callback
#	add_text_entry $dash FFTtuningGroup1b FFTSpeed_Ki_text "Speed Ki :" "Speed Loop Integral Gain" "999" dummy_callback

#	add_text_entry $dash FFTtuningGroup1c FFTPosition_Kp_text "Position Kp :" "Position Loop Proportional Gain" "999" dummy_callback
#	add_text_entry $dash FFTtuningGroup1c FFTPosition_SpeedFF_Kp_text "Position Ki :" "Position Loop Integral Gain" "999" dummy_callback

#	dashboard_add $dash FFTtuneupdatebuttona button FFTtuningGroup1a
#	dashboard_set_property $dash FFTtuneupdatebuttona text "Update Parameters"
#	dashboard_set_property $dash FFTtuneupdatebuttona onClick {::DOC_gui::FFTtune_update 0}

#	dashboard_add $dash FFTtuneupdatebuttonb button FFTtuningGroup1b
#	dashboard_set_property $dash FFTtuneupdatebuttonb text "Update Parameters"
#	dashboard_set_property $dash FFTtuneupdatebuttonb onClick {::DOC_gui::FFTtune_update 0}

#	dashboard_add $dash FFTtuneupdatebuttonc button FFTtuningGroup1c
#	dashboard_set_property $dash FFTtuneupdatebuttonc text "Update Parameters"
#	dashboard_set_property $dash FFTtuneupdatebuttonc onClick {::DOC_gui::FFTtune_update 0}
#######################################################


	add_combo_entry $dash tuningGroup2 triggersigcombo "Trigger Signal :" "tooltip" [list Always Vu Vv Vw Iu Iw Iv SpeedCommand Speed IdCommand Id IqCommand Iq Position PositionCommand] 0 {::DOC_gui::trace_update 1}
	add_combo_entry $dash tuningGroup2 triggeredgecombo "Trigger Edge :" "Trigger occurs " [list Level RisingEdge FallingEdge BothEdges ] 0 {::DOC_gui::trace_update 1}

	add_text_entry $dash tuningGroup2 triggervaltext "Trigger Value :" "Trace will trigger when the selected signal matches this value and trigger edge setting" "100" {::DOC_gui::trace_update 1}
	add_combo_entry $dash tuningGroup2 tracedepthcombo "Trace Depth :" "Number of samples of trace to download" [list 128 256 512 1024 2048] 0 {::DOC_gui::trace_update 1}


	add_text_entry $dash tuningGroup2 tracefilenametext "Trace Filename :" "Trace will dump the output data to a csv file of this name for later analysis" "dump_data" {::DOC_gui::trace_update 1}

#	dashboard_add $dash triggerspacer label tuningGroup2
#	dashboard_set_property $dash triggerspacer text ""

	dashboard_add $dash triggerupdatebutton button tuningGroup2
	dashboard_set_property $dash triggerupdatebutton text "Update Trigger"
	dashboard_set_property $dash triggerupdatebutton toolTip "Update Trigger Value"
	dashboard_set_property $dash triggerupdatebutton onClick {::DOC_gui::trace_update 1}

	dashboard_add $dash mybutton3 button tuningGroup2
	dashboard_set_property $dash mybutton3 text "Start Trace"
	dashboard_set_property $dash mybutton3 toolTip "Start Trace & Update Trigger Value"
	dashboard_set_property $dash mybutton3 onClick {::DOC_gui::start_trace 1}


##################################################################
#####Copy of tuning group for FFT tab
#	add_combo_entry $dash FFTtuningGroup2 FFTtriggersigcombo "Trigger Signal :" "tooltip" [list Always Vu Vv Vw Iu Iw Iv SpeedCommand Speed IdCommand Id IqCommand Iq Position PositionCommand] 0 {::DOC_gui::FFTtrace_update 1}
#	add_combo_entry $dash FFTtuningGroup2 FFTtriggeredgecombo "Trigger Edge :" "Trigger occurs " [list Level RisingEdge FallingEdge BothEdges ] 0 {::DOC_gui::FFTtrace_update 1}

#	add_text_entry $dash FFTtuningGroup2 FFTtriggervaltext "Trigger Value :" "Trace will trigger when the selected signal matches this value and trigger edge setting" "100" {::DOC_gui::FFTtrace_update 1}
#	dashboard_add $dash FFTtriggerupdatebutton button FFTtuningGroup2
#	dashboard_set_property $dash FFTtriggerupdatebutton text "Update Trigger"
#	dashboard_set_property $dash FFTtriggerupdatebutton toolTip "Update Trigger Value"
#	dashboard_set_property $dash FFTtriggerupdatebutton onClick {::DOC_gui::FFTtrace_update 1}

#	add_combo_entry $dash FFTtuningGroup2 FFTtracedepthcombo "Trace Depth :" "Number of samples of trace to download" [list 256 512 1024 2048 4096] 0 {::DOC_gui::FFTtrace_update 1}
#	add_text_entry $dash FFTtuningGroup2 FFTtracefilenametext "Trace Filename :" "Trace will dump the output data to a csv file of this name for later analysis" "dump_data" {::DOC_gui::FFTtrace_update 1}

#	dashboard_add $dash FFTmybutton3 button FFTtuningGroup2
#	dashboard_set_property $dash FFTmybutton3 text "Start Trace"
#	dashboard_set_property $dash FFTmybutton3 toolTip "Start Trace & Update Trigger Value"
#	dashboard_set_property $dash FFTmybutton3 onClick {::DOC_gui::start_trace 1}

	add_combo_entry $dash FFTselectGroup2 FFT0measuresigcombo "FFT0, Signal:" "tooltip" [list Iq Id Iq_command Vq_unfilt Vd_unfilt Vq Vd Speed SpeedCommand Position PositionCommand] 0 {::DOC_gui::FFTsetting_update 1}
	add_combo_entry $dash FFTselectGroup2 FFT0scalecombo "Time Scale:" "tooltip" [list Linear Log] 0 {::DOC_gui::FFTsetting_update 1}
	add_text_entry $dash FFTselectGroup2 FFT0pkdetlimlow "Peak Detect Limit Low (Hz):" "Unit: Hz. Enter number as unsigned integer" "500" {::DOC_gui::FFTcmdwave_update 1}
	add_text_entry $dash FFTselectGroup2 FFT0pkdetlimhigh "Peak Detect Limit High (Hz):" "Unit: Hz. Enter number as unsigned integer" "7500" {::DOC_gui::FFTcmdwave_update 1}
	dashboard_add $dash FFTfft0pkupdate button FFTselectGroup2
	dashboard_set_property $dash FFTfft0pkupdate text "Update Limits"
	dashboard_set_property $dash FFTfft0pkupdate onClick {::DOC_gui::FFTpk_update 1}

	add_combo_entry $dash FFTselectGroup2 FFT1measuresigcombo "FFT1, Signal:" "tooltip" [list Iq Id Iq_command Vq_unfilt Vd_unfilt Vq Vd Speed SpeedCommand Position PositionCommand] 0 {::DOC_gui::FFTsetting_update 1}
	add_combo_entry $dash FFTselectGroup2 FFT1scalecombo "Time Scale:" "tooltip" [list Linear Log] 0 {::DOC_gui::FFTsetting_update 1}
	add_text_entry $dash FFTselectGroup2 FFT1pkdetlimlow "Peak Detect Limit Low (Hz):" "Unit: Hz. Enter number as unsigned integer" "500" {::DOC_gui::FFTcmdwave_update 1}
	add_text_entry $dash FFTselectGroup2 FFT1pkdetlimhigh "Peak Detect Limit High (Hz):" "Unit: Hz. Enter number as unsigned integer" "7500" {::DOC_gui::FFTcmdwave_update 1}


	add_combo_entry $dash FFTcmdwaveGroup FFTcmd_wave_type "Waveform Type:" "Selects the type of waveform" [list Sine Triangle Square Sawtooth] 0 {::DOC_gui::FFTcmdwave_update 1}
	add_text_entry $dash FFTcmdwaveGroup FFTcmd_wave_period "Period (samples):" "Unit: 16kHz cycles. Enter number as unsigned integer" "4096" {::DOC_gui::FFTcmdwave_update 1}
	#add_text_entry $dash FFTcmdwaveGroup FFTcmd_wave_offset "Time Offset (samples):" "Unit: 16kHz cycles. Enter number as unsigned integer" "0" {::DOC_gui::FFTcmdwave_update 1}
	add_text_entry $dash FFTcmdwaveGroup FFTcmd_wave_amp_pos_fl "Position Amplitude (deg):" "Unit: degrees. Enter number in float format" "10" {::DOC_gui::FFTcmdwave_update 1}
	add_text_entry $dash FFTcmdwaveGroup FFTcmd_wave_amp_spd_fl "Speed Amplitude (rpm):" "Unit: rpm. Enter number in float format" "100" {::DOC_gui::FFTcmdwave_update 1}
	add_combo_entry $dash FFTcmdwaveGroup FFTcmd_wave_en "On/Off :" "Enable or Disable the waveform" [list OFF ON] 0 {::DOC_gui::FFTcmdwave_update 1}
	#add_combo_entry $dash FFTcmdwaveGroup FFTcmd_wave_fft_sync "Sync to FFT :" "Selects whether to sync waveform start to FFT start" [list No Yes] 0 {::DOC_gui::FFTcmdwave_update 1}
	dashboard_add $dash FFTcmdwaveupdate button FFTcmdwaveGroup
	dashboard_set_property $dash FFTcmdwaveupdate text "Update Waveform"
	dashboard_set_property $dash FFTcmdwaveupdate toolTip "Update command waveform parameters"
	dashboard_set_property $dash FFTcmdwaveupdate onClick {::DOC_gui::FFTcmdwave_update 1}

	add_text_entry $dash FFTfiltGroup FFTfilt_fd_hz_fl "Fd (Hz) :" "Enter number in float format" "1.0e0" {::DOC_gui::FFTfilt_update 1}
	add_text_entry $dash FFTfiltGroup FFTfilt_zd_fl "Zd (Non Dimensional) :" "Enter number in float format" "1.0e0" {::DOC_gui::FFTfilt_update 1}

	add_combo_entry $dash FFTfiltGroup FFTfilt_en "On/Off :" "Enable or Disable the filter" [list OFF ON] 0 {::DOC_gui::FFTfilt_update 1}
	add_text_entry $dash FFTfiltGroup FFTfilt_dc_gain_fl "Input Gain :" "Enter number in float format" "1.0e0" {::DOC_gui::FFTfilt_update 1}

	add_text_entry $dash FFTfiltGroup FFTfilt_fn_hz_fl "Fn (Hz) :" "Enter number in float format" "1.0e0" {::DOC_gui::FFTfilt_update 1}
	add_text_entry $dash FFTfiltGroup FFTfilt_zn_fl "Zn (Non Dimensional) :" "Enter number in float format" "1.0e0" {::DOC_gui::FFTfilt_update 1}

	dashboard_add $dash FFTfiltupdate button FFTfiltGroup
	dashboard_set_property $dash FFTfiltupdate text "Update Filter"
	dashboard_set_property $dash FFTfiltupdate toolTip "Update filter parameters"
	dashboard_set_property $dash FFTfiltupdate onClick {::DOC_gui::FFTfilt_update 1}

#######################################################

	add_combo_entry $dash tuningGroup3 speedrequestcombo "Speed Request (rpm):" "Setpoint for Speed Loop" [list -2000 -1000 -800 -600 -500 -300 -200 -100 "No Selection" 0 100 200 300 400 500 600 800 1000 2000] 9 {::DOC_gui::speed_update2 speedrequestcombo}


	add_text_entry $dash tuningGroup3 speedval1text "Speed Value 1 (rpm):" "Speed Value" "-500" dummy_callback
	add_text_entry $dash tuningGroup3 speedval2text "Speed Value 2 (rpm):" "Speed Value" "1000" dummy_callback
	add_text_entry $dash tuningGroup3 speedintervaltimetext "Speed Interval (ms):" "Speed change interval in milliseconds" "2000" dummy_callback
	
#	add_combo_entry $dash speedadjustGroup speedrequestcombo "Speed Request (rpm):" "Setpoint for Speed Loop" [list -3000 -2000 -1000 -800 -600 -500 -300 -200 -100 "No Selection" 0 100 200 300 400 500 600 800 1000 2000 3000] 9 {::DOC_gui::speed_update2 speedrequestcombo}

	dashboard_add $dash dialspeedadjust dial speedadjustGroup
	dashboard_set_property $dash dialspeedadjust title "Speed Request(rpm)"
	dashboard_set_property $dash dialspeedadjust expandableX true
	dashboard_set_property $dash dialspeedadjust expandableY true
	dashboard_set_property $dash dialspeedadjust min -3000
	dashboard_set_property $dash dialspeedadjust max 3000
	dashboard_set_property $dash dialspeedadjust tickSize [ expr 3000 / 6 ]
	dashboard_set_property $dash dialspeedadjust preferredHeight 200
	dashboard_set_property $dash dialspeedadjust preferredWidth 270
	
	dashboard_add $dash dial1 dial speedadjustGroup
	dashboard_set_property $dash dial1 expandableX true
	dashboard_set_property $dash dial1 expandableY true
	dashboard_set_property $dash dial1 title "Speed (rpm)"
	dashboard_set_property $dash dial1 min -3000
	dashboard_set_property $dash dial1 max 3000
	dashboard_set_property $dash dial1 tickSize [ expr 3000 / 6 ]
	dashboard_set_property $dash dial1 preferredHeight 200
	dashboard_set_property $dash dial1 preferredWidth 270

	dashboard_add $dash speedupdatebutton button tuningGroup3
	dashboard_set_property $dash speedupdatebutton text "Run Speed Demo"
	dashboard_set_property $dash speedupdatebutton onClick {::DOC_gui::speedinterval_button 0}

#	dashboard_add $dash pushbutton5 button tuningGroup3
#	dashboard_set_property $dash pushbutton5 text "Enable Open Loop Mode"
#	dashboard_set_property $dash pushbutton5 onClick {::DOC_gui::openloop_update 0}

	add_text_entry $dash tuningGroup4 positionval1text "Position Value 1 (deg):" "Position Value" "-360" dummy_callback
	add_text_entry $dash tuningGroup4 positionval2text "Position Value 2 (deg):" "Position Value" "360" dummy_callback
	add_text_entry $dash tuningGroup4 positionspeedtext "Speed Limit (rpm):" "Position Speed" "50" dummy_callback
	add_text_entry $dash tuningGroup4 positionintervaltimetext "Position Interval (ms):" "Position change interval in seconds" "4000" dummy_callback

	dashboard_add $dash positionupdatebutton button tuningGroup4
	dashboard_set_property $dash positionupdatebutton text "Run Position Demo"
	dashboard_set_property $dash positionupdatebutton onClick {::DOC_gui::positioninterval_button 0}
  
	proc update {next} {
		variable dash
		variable connected
		variable speed
		variable speed_direction
		variable series0
		variable series1
		variable series2
		variable status_running
		
		if {$connected == 1} {
			if {$status_running == 0} { 
				get_status $next
			}
		}

		if {$::DOC_gui::start_count == 1} {after 100 [ namespace code "update [ expr $next + 1 ]" ]}
	}

	proc update_motor {} {
		variable dump_data_downloaded
		variable dbg_speed_request
		variable speed
		variable speed_direction

		if {$speed >= 1000} {
			set speed_direction 0
		}
		
		if {$speed <= -0000} {
			set speed_direction 1
		}

		if {$speed_direction == 1} {
			set speed [expr $speed + 100]
		} else {
			set speed [expr $speed - 100]
		}
	}

	
	proc get_delta_time last_time {
		upvar 1 $last_time lastt

		set cur_time [clock clicks -milliseconds]
		if {$lastt == 0} {
			set lastt $cur_time
		}
	
		set delta_time [expr $cur_time - $lastt]

		set lastt $cur_time
		return $delta_time
	}		


	proc start_dump {} {
		variable dump_data_downloaded

 		debug_write_command 0 $::DOC_gui::DOC_DBG_DUMP_MODE 0
		set dump_data_downloaded 0
	}


	proc start_trace {a} {
		variable dash
		variable jd_path
		variable trace_data

		if {$trace_data == 0} {
			set trace_data 1
			::DOC_gui::trace_update 1
			dashboard_set_property $dash mybutton3 text "Disable Trace"
			#dashboard_set_property $dash FFTmybutton3 text "Disable Trace"
		} else {
			set trace_data 0
			dashboard_set_property $dash mybutton3 text "Enable Trace"
			#dashboard_set_property $dash FFTmybutton3 text "Enable Trace"
		}			
	}

	proc download_trace_decode16 {num_traces traces} {
		upvar 1 $traces tr
		set num_trace 0

		set dump [master_read_16 $::DOC_gui::jd_path $::DOC_gui::SYS_CONSOLE_TRACE_BASE_HEX [expr $::DOC_gui::trace_depth * $num_traces]]

		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
		set dumps($num_trace) {}
		}
		
		set num_trace 0
		
		set num_trace 0
		foreach valuestr $dump {
			set dumps($num_trace) [concat $dumps($num_trace) [shex2dec16 $valuestr]]
			if {$num_trace < [expr $num_traces - 1]} {
				incr num_trace
			} else {
					set num_trace 0
			}
		}
  
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace) 
		}
	
	}		


	proc download_trace_decode8_working {address trace_info traces} {
		upvar 1 $traces tr
		variable last_time;
		set num_trace 0
		
		set num_traces [llength $trace_info]
		send_message info "reading [expr $::DOC_gui::trace_depth * $num_traces * 2] bytes"
		send_message info "start reading [get_delta_time last_time]ms"	

		set dump [master_read_memory $::DOC_gui::jd_path $address [expr $::DOC_gui::trace_depth * $num_traces * 2]]

		send_message info "done reading [get_delta_time last_time]ms"	
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			set dumps($num_trace) [list]
		}

		set low_byte 0
		set low_byte_val ""
		set num_trace 0
		foreach valuestr $dump {
			set bit_width [lindex $trace_info $num_trace 1] 
			# Build each 16-bit value from 2 bytes
			if {$low_byte != [expr {($bit_width / 8)-1}]} {
				#puts "[string range $valuestr 2 3]$low_byte_val"
				set low_byte_val [string range $valuestr 2 3]$low_byte_val
				incr low_byte
			} else {
				set low_byte 0
				lappend dumps($num_trace) [shex2dec$bit_width $valuestr$low_byte_val]
				if {$num_trace < [expr {$num_traces - 1}]} {
					incr num_trace
				} else {
					set num_trace 0
				}
				set low_byte_val ""
			}			
		}
	  
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace)
		}
	}		

	proc download_trace_decode8_original {address trace_info traces} {
		upvar 1 $traces tr
		set num_trace 0
		
		set num_traces [llength $trace_info]

		set dump [master_read_memory $::DOC_gui::jd_path $address  [expr $::DOC_gui::trace_depth * $num_traces * 2]]

		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			set dumps($num_trace) {}
		}

		set low_byte 0
		set low_byte_val ""
		set num_trace 0
		foreach valuestr $dump {
			set bit_width [lindex [lindex $trace_info $num_trace] 1] 
			# Build each 16-bit value from 2 bytes
			if {$low_byte != [expr ($bit_width / 8)-1]} {
				set low_byte_val [string range $valuestr 2 3]$low_byte_val
				incr low_byte
			} else {
				set low_byte 0
				set dumps($num_trace) [concat $dumps($num_trace) [shex2dec$bit_width $valuestr$low_byte_val]]
				if {$num_trace < [expr $num_traces - 1]} {
					incr num_trace
				} else {
						set num_trace 0
				}
				set low_byte_val ""
			}			
		}
	  
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace)
		}
		
	}		



	proc download_trace_decode8 {address trace_depth trace_info traces} {
		upvar 1 $traces tr
		variable last_time;
		set num_trace 0
		
		set num_traces [llength $trace_info]

		set bytes_per_trace 0
		foreach trace $trace_info {
			incr bytes_per_trace [expr [lindex $trace 1]]
		}
		set bytes_per_trace [expr $bytes_per_trace / 8]
		set dump [master_read_memory $::DOC_gui::jd_path $address [expr $trace_depth * $bytes_per_trace]]

		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			set dumps($num_trace) [list]
		}
	
		set low_byte 8
		set low_byte_mult 1
		set low_byte_val 0
		set num_trace 0
		foreach valuestr $dump {
			set bit_width [lindex $trace_info $num_trace 1] 
			set is_a_float [lindex $trace_info $num_trace 4] 
			set low_byte_val [expr {($valuestr * $low_byte_mult) + $low_byte_val} ]
			
			# Build each 16-bit value from 2 bytes
			if {$low_byte != $bit_width } {
				incr low_byte 8
				set low_byte_mult [expr {$low_byte_mult * 256}]
			} else {
				# We are using signed 16bit integers so use the top bit as sign to adjust 
				if {$low_byte_val >= [::tcl::mathfunc::pow 2 [expr {$bit_width-1}]] } {
					set low_byte_val [expr {$low_byte_val - [::tcl::mathfunc::pow 2 $bit_width] }]
				}
				if {$is_a_float == 1 } {
					set low_byte_val [hex2singlef [expr int($low_byte_val)]]
					if {[isnan $low_byte_val] == 1} {
						set low_byte_val 0.000000
						#puts "Substituted NaN for $low_byte_val"
					}
				}
				lappend dumps($num_trace) $low_byte_val
				set low_byte_mult 1
				set low_byte_val 0
				set low_byte 8
				if {$num_trace < [expr {$num_traces - 1}]} {
					incr num_trace
				} else {
					set num_trace 0
				}
			}
		}			
   
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace)
		}

	}		

	proc download_trace_fft_decode8 {address trace_depth trace_info traces} {
		upvar 1 $traces tr
		variable last_time;
		set num_trace 0
		
		set num_traces [llength $trace_info]
	
		for {set loop_read 0} {$loop_read < 1} {incr loop_read} {
			set dump [master_read_memory $::DOC_gui::jd_path $address [expr $trace_depth * $num_traces * 4]]
		}	

		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			set dumps($num_trace) {}
		}

		set low_byte 8
		set low_byte_mult 1
		set low_byte_val 0
		set num_trace 0
		foreach valuestr $dump {
			set bit_width [lindex $trace_info $num_trace 1] 
			set low_byte_val [expr {($valuestr * $low_byte_mult) + $low_byte_val} ]
			
			# Build each 16-bit value from 2 bytes
			if {$low_byte != $bit_width } {
				#puts "[string range $valuestr 2 3]$low_byte_val"
				incr low_byte 8
				set low_byte_mult [expr {$low_byte_mult * 256}]
			} else {
				if {$low_byte_val >= [::tcl::mathfunc::pow 2 [expr {$bit_width-1}]] } {
					set low_byte_val [expr {$low_byte_val - [::tcl::mathfunc::pow 2 $bit_width] }]
				}
				lappend dumps($num_trace) $low_byte_val
				set low_byte_mult 1
				set low_byte_val 0
				set low_byte 8
				if {$num_trace < [expr {$num_traces - 1}]} {
					incr num_trace
				} else {
					set num_trace 0
				}
			}
		}			
  
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace)
		}
	
	}		



	proc download_trace_fft_decode8_working {address trace_info traces} {
		upvar 1 $traces tr
		variable last_time;
		set num_trace 0
		
		set num_traces [llength $trace_info]
	
		for {set loop_read 0} {$loop_read < 1} {incr loop_read} {
			set dump [master_read_memory $::DOC_gui::jd_path $address [expr 2048 * $num_traces * 4]]
		}	
	
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			set dumps($num_trace) {}
		}

		set low_byte 0
		set low_byte_val ""
		set num_trace 0
		foreach valuestr $dump {
			set bit_width [lindex [lindex $trace_info $num_trace] 1] 
			# Build each 16-bit value from 2 bytes
			if {$low_byte != [expr ($bit_width / 8)-1]} {
				set low_byte_val [string range $valuestr 2 3]$low_byte_val
				incr low_byte
			} else {
				set low_byte 0
				set dumps($num_trace) [concat $dumps($num_trace) [shex2dec$bit_width $valuestr$low_byte_val]]
				if {$num_trace < [expr $num_traces - 1]} {
					incr num_trace
				} else {
					set num_trace 0
				}
				set low_byte_val ""
			}			
		}
	  
		set tr {}
		for {set num_trace 0} {$num_trace < $num_traces} {incr num_trace} {
			lappend tr $dumps($num_trace)
		}
		
	}		

	proc format_plot_data2 {traces trace_info time_incr max_trace_num plottraces} {

		upvar $plottraces ptraces
		set ptraces [list]		
		set trace_num 0
		foreach trace $traces {
			set ptrace [list [lindex [lindex $trace_info $trace_num] 0]]
			set bitwidth [lindex [lindex $trace_info $trace_num] 1]
			set offset [lindex [lindex $trace_info $trace_num] 2]
			set divisor [lindex [lindex $trace_info $trace_num] 3]

			set next 0
			set count 0
			foreach value $trace {
				set nextTuple [list $next [expr {($value-$offset)/$divisor}]]
				lappend ptrace $nextTuple
				set next [expr {$next + $time_incr}]
				incr count
				if {($count > $max_trace_num) && ($max_trace_num > 0)} {
					#send_message info "Truncated trace at $max_trace_num entries"
					break
				}
			}
			lappend ptraces $ptrace
			incr trace_num
		}		
	}


	proc format_plot_data_marker {traces trace_name time data_val max_trace_num do_logtime plottraces} {
		upvar $plottraces ptraces
		set ptraces [list]
				
		set trace_num 0
		foreach trace $traces {
			set ptrace [list $trace_name]
			if {$do_logtime != 0} {
				set nextTuple [list [expr log10($time)] 0]
				lappend ptrace $nextTuple
				set nextTuple [list [expr log10($time)] $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list [expr log10(8000)] $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list 0 $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list [expr log10($time)] $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list [expr log10($time)] 100]
				lappend ptrace $nextTuple

			} else {
				set nextTuple [list $time 0]
				lappend ptrace $nextTuple
				set nextTuple [list $time $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list 8000 $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list 0 $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list $time $data_val]
				lappend ptrace $nextTuple
				set nextTuple [list $time 100]
				lappend ptrace $nextTuple
			}

			lappend ptraces $ptrace
			#set trace_num [expr $trace_num + 1]
			incr trace_num
		}		
	}

	
	proc format_plot_data2_logtime {traces trace_info time_incr max_trace_num plottraces} {
		upvar $plottraces ptraces
		set ptraces [list]
		set trace_num 0
		foreach trace $traces {
			set ptrace [list [lindex [lindex $trace_info $trace_num] 0]]
			set bitwidth [lindex [lindex $trace_info $trace_num] 1]
			set offset [lindex [lindex $trace_info $trace_num] 2]
			set divisor [lindex [lindex $trace_info $trace_num] 3]
			set count 0
			set next 1
			foreach value $trace {
				set nextTuple [list [expr log10($next)] [expr {($value-$offset)/$divisor}]]
				lappend ptrace $nextTuple
				set next [expr {$next + $time_incr}]
				incr count
				if {($count > $max_trace_num) && ($max_trace_num > 0)} {
					break
				}
			}
			lappend ptraces $ptrace
			incr trace_num
		}		

	}

	proc dump_plot_data {plottraces} {
		variable dash
		set someFile [dashboard_get_property $dash tracefilenametext_entry text].csv
		if { [catch {open $someFile w} fid] } {
			puts stderr "$fid"
		} else {
			set dump_file [open $someFile w]
			set num_traces [llength $plottraces]
			set num_values 0
			
			#Find the longest data trace
			foreach j $plottraces {
				set num_values_per [llength $j]	
				if {$num_values < $num_values_per} {set num_values $num_values_per}
			}
				
			set i 0
			set line 0
			for { set i 0 } { $i < $num_values } { incr i } {
				set outline ""
				foreach j $plottraces {
					if {$line == 0} {
							set outline "${outline}[lindex $j $i]"
					} else {
							set outline "${outline}[lindex [lindex $j $i] 1]"
					}
					set outline "${outline},"
				}
				incr line;
				puts $dump_file $outline
			}
			close $dump_file
		}
	}

	
	proc plot_data {xychart_handle plottraces} {
		variable dash
		foreach ptrace $plottraces {
    	dashboard_set_property $dash $xychart_handle series $ptrace
		}
	}


	proc get_status {next} {
		variable dash
		variable dump_data_downloaded
		variable dbg_dump_mode
		variable trace_data
		variable speedinterval_updating
		variable fftinterval_updating
		variable positioninterval_updating
		variable speed;
		variable last_time;
		variable enable_FFT
		variable fft_demo_stage
		variable status_running;
		variable SPEED_FRAC_BITS
		variable speed_frac_bits_scale
		variable plot_fft0_peaks
		variable plot_fft1_peaks
		
	
		set status_running 1

		if {1} {
			set dbg_motor_mode [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_DRIVE_STATE]
			set dbg_dsp_mode [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_DSP_MODE]
			set dbg_runtime [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_RUNTIME]
			set dbg_dump_mode [debug_read_status 0 $::DOC_gui::DOC_DBG_DUMP_MODE]
			set dbg_speed_monitor [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED]
			set dbg_position_monitor [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POSITION]
			set dbg_latency_monitor [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_LATENCY]
			set dbg_speed_setp0 [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0]

			###send_message info "finished polling status [get_delta_time last_time]ms"
			set dbg_open_loop_en [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_OL_EN]

			if {$dbg_motor_mode == 0} {
				set dbg_motor_mode_str "InitDSM"
			} elseif {$dbg_motor_mode == 1} {
				set dbg_motor_mode_str "Pre-Charge"
			} elseif {$dbg_motor_mode == 2} {
				set dbg_motor_mode_str "Pre-Run"
			} elseif {$dbg_motor_mode == 3} {
				set dbg_motor_mode_str "Running"
			} elseif {$dbg_motor_mode == 4} {
				set dbg_motor_mode_str "Error"
			} elseif {$dbg_motor_mode == 5} {
				set dbg_motor_mode_str "Startup Power Check"
			} elseif {$dbg_motor_mode == 6} {
				set dbg_motor_mode_str "EnDat Init"
			} else {
				set dbg_motor_mode_str "DSMStart"
			}
			
			if {$speedinterval_updating == 1} {
				set demo_mode_str "Speed Demo"
			} elseif {$positioninterval_updating == 1} {
				set demo_mode_str "Position Demo"
			} else {
				set demo_mode_str "Constant Speed"
			}

			if {$dbg_dsp_mode == 0} {
				set dbg_dsp_mode_str "Software Fixed-Point"
			} elseif {$dbg_dsp_mode == 1} {
				set dbg_dsp_mode_str "DSPBA Fixed-Point"
			} elseif {$dbg_dsp_mode == 2} {
				set dbg_dsp_mode_str "DSPBA Floating-Point"
			} else {
				set dbg_dsp_mode_str "Software Floating-Point"
			}

			if {1} {
		#		dashboard_set_property $dash status_label text "Status:-  Demo Mode: $demo_mode_str   DSP Mode: $dbg_dsp_mode_str   SpeedRequest: $dbg_speed_setp0 rpm    Motor: $dbg_motor_mode_str   Runtime: $dbg_runtime s"
		#		dashboard_set_property $dash status_label text "Status:-  Demo Mode: $demo_mode_str   DSP Mode: $dbg_dsp_mode_str   SpeedRequest: $dbg_speed_setp0 rpm    Motor: $dbg_motor_mode_str   Runtime: $dbg_runtime s   Incr: $next  Polling rate: $polling_delay ms"

				# # BEN: Need to give 'plot peaks' a default value otherwise they are undefined. Choose 'Don't plot peaks' as default. 
				# set plot_fft0_peaks 0
				# set plot_fft1_peaks 0

				# set dbg_demo_mode $fft_demo_stage
				# set SINGLE_COMBINED_VIBRATION_GRAPH 0

				# if {$dbg_demo_mode == 0} {
					# # Display html text describing all Vibration demo steps in equal size font
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 3. Try to improve by increasing speed control P-gain – faster response but causes resonance if inertia attached - see peak in FFT<br>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 4. Apply notch filter at frequency of resonance (see effect on Iq FFT) – we keep the faster response but resonance is suppressed!<br>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 5. Return to constant speed command – unwanted speed changes have been reduced
					# </font>\</body>\
					# "
					# set plot_fft0_peaks 0
					# set plot_fft1_peaks 0
				# } elseif {$dbg_demo_mode == 1} {
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 90 110]
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					# } else {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 90 110]
					  # dashboard_set_property $dash FFTtime1XY range {}
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					  # dashboard_set_property $dash FFTfft1XY range [list 0 100]
					# }
					# # Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5>
					# <body bgcolor=\"white\"><font face=\"verdana\" size=\"6\" color=\"black\">\
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?
					# </font>\</body>\
					# "
					# set plot_fft0_peaks 0
					# set plot_fft1_peaks 0
				# } elseif {$dbg_demo_mode == 2} {
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 0 200]
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					# } else {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 0 200]
					  # dashboard_set_property $dash FFTtime1XY range {}
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					  # dashboard_set_property $dash FFTfft1XY range [list 0 100]
					# }
					# # Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=\"white\"><font face=\"verdana\" size=\"6\" color=\"black\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br>\
					# </font>\</body>\
					# </font>\
					# "
				# } elseif {$dbg_demo_mode == 3} {
					# # Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br></font>\
					# <body bgcolor=\"white\"><font face=\"verdana\" size=\"6\" color=\"black\">\
					# 3. Try to improve by increasing speed control P-gain – faster response but causes resonance if inertia attached - see peak in FFT<br>\
					# </font>\</body>\
					# "
					# set plot_fft0_peaks 0
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 4} {
					# # Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 3. Try to improve by increasing speed control P-gain – faster response but causes resonance if inertia attached - see peak in FFT<br>\
					# <body bgcolor=\"white\"><font face=\"verdana\" size=\"6\" color=\"black\">\
					# 4. Apply notch filter at frequency of resonance (see effect on Iq FFT) – we keep the faster response but resonance is suppressed!
					# </font>\</body>\
					# "
					# set plot_fft0_peaks 0
					# set plot_fft1_peaks 0
				# } elseif {$dbg_demo_mode == 5} {
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 90 110]
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					# } else {
					  # # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
					  # dashboard_set_property $dash FFTtime0XY range [list 90 110]
					  # dashboard_set_property $dash FFTtime1XY range {}
					  # # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
					  # dashboard_set_property $dash FFTfft0XY range [list 0 100]
					  # dashboard_set_property $dash FFTfft1XY range [list 0 100]
					# }
					# # Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 3. Try to improve by increasing speed control P-gain – faster response but causes resonance if inertia attached - see peak in FFT<br>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
					# 4. Apply notch filter at frequency of resonance (see effect on Iq FFT) – we keep the faster response but resonance is suppressed!<br>\
					# <body bgcolor=\"white\"><font face=\"verdana\" size=\"6\" color=\"black\">\
					# 5. Return to constant speed command – unwanted speed changes have been reduced
					# </font>\</body>\
					# "
				# } elseif {$dbg_demo_mode == 6} { # Vibration step 6: reset and show text describing all steps in equal size font
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					# # set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# # set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
					# dashboard_set_property $dash FFTfft0XY range [list 0 140]
					# } else {
					# # set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# dashboard_set_property $dash FFTtime1XY range {}
					# # set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
					# dashboard_set_property $dash FFTfft0XY range [list 0 140]
					# dashboard_set_property $dash FFTfft1XY range [list 0 140]
					# }
					# # Display html text describing all Vibration demo steps in equal size font
					# dashboard_set_property $dash SPS10text1 text "\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\ 
					# 1. Gears have constant speed command, but actual speed changes due to motor 'cogging' - can we reduce these changes?<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 2. Add step changes to speed command to look at speed control response - with inertia attached, there is too much overshoot<br></font>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 3. Try to improve by increasing speed control P-gain – faster response but causes resonance if inertia attached - see peak in FFT<br>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 4. Apply notch filter at frequency of resonance (see effect on Iq FFT) – we keep the faster response but resonance is suppressed!<br>\
					# <body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
					# 5. Return to constant speed command – unwanted speed changes have been reduced
					# </font>\</body>\
					# "
				# } elseif {$dbg_demo_mode == 7} {
					# # BEN: Scaling settings previously set in  mode 6 (Vibration reset); mode 6 happens fast and sometimes System Console does not notice it and hence does not apply the scaling.
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					# # set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# # set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
					# dashboard_set_property $dash FFTfft0XY range [list 0 140]
					# } else {
					# # set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# dashboard_set_property $dash FFTtime1XY range {}
					# # set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
					# dashboard_set_property $dash FFTfft0XY range [list 0 140]
					# dashboard_set_property $dash FFTfft1XY range [list 0 140]
					# }
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - Basic: Gears, position independent<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 8} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - SlowMesh: Gears, speed/position locked<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 9} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - Competition: Gears, guess the mathematical sequence...<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 10} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - MoveTogether: Actuators, coordinated move<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 11} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - MoveOpposite: Actuators, coordinated move<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 12} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - Stationary1: Actuator 1 stationary<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 13} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - Stationary2: Actuator 2 stationary<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 14} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - SlowFast: Actuators, coordinated move<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 15} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - FastRolling: Gears pass with one stopped<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 16} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - Fast2: Gears roll past each other<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 17} {
					# # Display html text describing demo in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Demo $dbg_demo_mode - EtherCAT: Interactive control<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } elseif {$dbg_demo_mode == 31} { # Calibration mode: For presentation purposes, show text describing all steps of Vibration Demo in equal size font
					# if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
					# # set vertical axis scaling on fft0 and fft1 time and fft plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# dashboard_set_property $dash FFTfft0XY range {}
					# } else {
					# # set vertical axis scaling on fft0 and fft1 time and fft plots to auto-scaling
					# dashboard_set_property $dash FFTtime0XY range {}
					# dashboard_set_property $dash FFTtime1XY range {}
					# dashboard_set_property $dash FFTfft0XY range {}
					# dashboard_set_property $dash FFTfft1XY range {}
					# }
					# # Display html text describing mode in 'Vibration' (FFT) analysis tab
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Mode $dbg_demo_mode - Motor Calibration<br>\
					# </font>\
					# "
					# set plot_fft0_peaks 1
					# set plot_fft1_peaks 1
				# } else {
					# dashboard_set_property $dash SPS10text1 text "\
					# <font size=\"+4\">\
					# Undefined Demo mode $dbg_demo_mode - ?????<br>\
					# </font>\
					# "
				# }

				if {$dbg_open_loop_en == 0} {
					dashboard_set_property $dash pushbutton5 text "Enable Open Loop Test Mode"
					dashboard_set_property $dash pushbutton5 toolTip "Disables PI controller and runs motor open loop"
				} else {
					dashboard_set_property $dash pushbutton5 text "Disable Open Loop Test Mode"
					dashboard_set_property $dash pushbutton5 toolTip "Enables PI controller and runs motor closed loop"
				}

				dashboard_set_property $dash dialspeedadjust value $dbg_speed_setp0
				dashboard_set_property $dash dial0 value [expr $dbg_latency_monitor / 100.0]
				dashboard_set_property $dash dial1 value $dbg_speed_monitor

				if {$positioninterval_updating == 1} {
					dashboard_set_property $dash dial2 value [ expr $dbg_position_monitor * 360 / 65536]
				} else {
					dashboard_set_property $dash dial2 value 0
				}
			
			}
		} else {
				#cheat the trace to think data is already ready
		 		set dbg_dump_mode 1
		 		set dump_data_downloaded 0
		}

		set polling_delay [get_delta_time last_time]
		set download_only 0
		set download_and_format 0
		set plotting_data 0
		
		#FFT HANDSHAKE
		# To speed things up and ensure synch betwen the two channels we now have a single status that is
		# incremented when a chanel is ready. We have two channels so we wait for status == 2

		set dbg_fft_status [debug_read_status 0 $::DOC_gui::DOC_DBG_FFT_PING_STATUS]

		if {($enable_FFT == 1)&&($dbg_fft_status > 2)||($dbg_fft_status == 1)}	{
			send_message info "FFT Status Debug = $dbg_fft_status"
		}
		
		if {(($dbg_fft_status == 2)&&($trace_data == 1)&&($enable_FFT == 1)) || (($dbg_dump_mode == 1)&&($trace_data == 1)&&($enable_FFT == 0))}	{
			if {$dump_data_downloaded == 0} {
				set general_time_traces {}
				set general_time_info [list [list Vu 16 1563 7.8125 0] [list Vv 16 1563 7.8125 0] [list Vw 16 1563 7.8125 0] [list Iu 16 0 5.1200 0] [list Iw 16 0 5.1200 0] [list Iv 16 0 5.1200 0] [list SpeedCommand 16 0 $speed_frac_bits_scale 0] [list SpeedEncoder 16 0 $speed_frac_bits_scale 0] [list Id 16 0 5.1200 0] [list Id_com 16 0 5.1200 0] [list Iq 16 0 5.1200 0] [list Iq_com 16 0 5.1200 0] [list Pos 32 0 182.0444 0] [list PosCommand 32 0 182.0444 0]]
#				set trace_info [list [list VoltU 16 1563 3.9075] [list VoltV 16 1563 3.9075] [list VoltW 16 1563 3.9075] [list Iu 16 0 1] [list Iw 16 0 1] [list Iv 16 0 1] [list SpeedCommand 16 0 1] [list SpeedEncoder 16 0 1] [list Id 16 0 1] [list Id_com 16 0 1] [list Iq 16 0 1] [list Iq_com 16 0 1] [list Pos 32 0 182.0444] [list PosCommand 32 0 182.0444]]
				download_trace_decode8 $::DOC_gui::SYS_CONSOLE_TRACE_BASE_HEX $::DOC_gui::trace_depth $general_time_info general_time_traces

				if {$enable_FFT == 1} {
					set fft_info [list [list Iq 16 0 5.1200 0 mA] [list Id 16 0 5.1200 0 mA] [list Iq_command 16 0 5.1200 0 mA] [list Vq_unfilt 16 0 7.8125 0 V] [list Vd_unfilt 16 0 7.8125 0 V] [list Vq 16 0 7.8125 0 V] [list Vd 16 0 7.8125 0 V] [list Speed 16 0 $speed_frac_bits_scale 0 rpm] [list SpeedCommand 16 0 $speed_frac_bits_scale 0 rpm] [list Position 16 0 182.0444 0 deg] [list PositionCommand 16 0 182.0444 0 deg]]
					#set fft0_data_name [lindex  [dashboard_get_property $::DOC_gui::dash FFT0measuresigcombo_entry options] [dashboard_get_property $dash FFT0measuresigcombo_entry selected]]
					set fft0_data_name [lindex  $fft_info [dashboard_get_property $dash FFT0measuresigcombo_entry selected] 0]
					set fft0_log_scaling [dashboard_get_property $dash FFT0scalecombo_entry selected]
					set fft0_time_info [lindex  $fft_info [dashboard_get_property $dash FFT0measuresigcombo_entry selected]]
					set fft0_time_info [list [lreplace $fft0_time_info 0 0 "Time Data"] ]
					set fft0_data_units [lindex $fft0_time_info 0 5]
					set fft0_scaling 1
					#Set actual scaling for magnitude calc
					set fft0_scaling [lindex $fft0_time_info 0 3]

					set fft1_data_name [lindex  $fft_info [dashboard_get_property $dash FFT1measuresigcombo_entry selected] 0]
					set fft1_log_scaling [dashboard_get_property $dash FFT1scalecombo_entry selected]
					set fft1_time_info [lindex  $fft_info [dashboard_get_property $dash FFT1measuresigcombo_entry selected]]
					set fft1_time_info [list [lreplace $fft1_time_info 0 0 "Time Data"] ]
					set fft1_data_units [lindex $fft1_time_info 0 5]
					set fft1_scaling 1
					#Set actual scaling for magnitude calc
					set fft1_scaling [lindex $fft1_time_info 0 3]

					set fft0_time_traces {}
					set fft0_time_plots {}
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_FFT0_IN_PING_BASE_HEX 4096 $fft0_time_info fft0_time_traces

					set fft1_time_traces {}
					set fft1_time_plots {}
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_FFT1_IN_PING_BASE_HEX 4096 $fft1_time_info fft1_time_traces

					set fft0_freq_raw_traces {}
					set fft0_freq_raw_info [list [list "FFT0 Real Raw" 32 0 1] [list "FFT0 Imag Raw" 32 0 1] ]
					set fft0_freq_info [list [list "FFT0 Real Scale" 32 0 1] [list "FFT0 Imag Scale" 32 0 1] ]
					set fft0_freq_info [list [list "FFT0 Magnitude" 32 0 1] ]
					set fft0_freq_hps_info [list [list "HPS FFT0 Magnitude" 32 0 1] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_FFT0_OUT_PING_BASE_HEX 4096 $fft0_freq_raw_info fft0_freq_raw_traces

					set fft1_freq_raw_traces {}
					set fft1_freq_raw_info [list [list "FFT1 Real Raw" 32 0 1] [list "FFT1 Imag Raw" 32 0 1]  ]
					set fft1_freq_info [list [list "FFT1 Real Scale" 32 0 1] [list "FFT1 Imag Scale" 32 0 1] ]
					set fft1_freq_info [list [list "FFT1 Magnitude" 32 0 1] ]
					set fft1_freq_hps_info [list [list "HPS FFT1 Magnitude" 32 0 1] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_FFT1_OUT_PING_BASE_HEX 4096 $fft1_freq_raw_info fft1_freq_raw_traces
				}

				set download_only [get_delta_time last_time]

				if {$enable_FFT == 1} {

					set fft0_mag_float_freq_info [list [list "FFT0 Mag2" 32 0 1 1] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_MAGSQ0_PING_BASE_HEX 2048 $fft0_mag_float_freq_info fft0_freq_mag_traces_float

					set fft1_mag_float_freq_info [list [list "FFT1 Mag2" 32 0 1 1] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_MAGSQ1_PING_BASE_HEX 2048 $fft1_mag_float_freq_info fft1_freq_mag_traces_float
					
					set fft0_peak_freq_info [list [list "FFT0 Peak Mag" 32 0 1 1] [list "FFT0 Peak Freq" 32 0 1 0] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_MAGSQ0_PK_PING_BASE_HEX 64 $fft0_peak_freq_info fft0_freq_peak_traces

					set fft1_peak_freq_info [list [list "FFT1 Peak Mag" 32 0 1 1] [list "FFT1 Peak Freq" 32 0 1 0] ]
					download_trace_decode8 $::DOC_gui::SYS_CONSOLE_MAGSQ1_PK_PING_BASE_HEX 64 $fft1_peak_freq_info fft1_freq_peak_traces
				}
				
				set plottraces {}
				set time_incr 0.0625
				format_plot_data2 $general_time_traces $general_time_info $time_incr 0 general_time_plots;

				if {$enable_FFT == 1} {
					format_plot_data2 $fft0_time_traces $fft0_time_info $time_incr 0 fft0_time_plots;
					
					format_plot_data2 $fft1_time_traces $fft1_time_info $time_incr 0 fft1_time_plots;
					
					#Unformatted version for Dump
					set fft0_time_raw_traces {}
					set fft0_time_raw_info [list [list "Data0 $fft0_data_name Raw" 16 0 1.0] ]
					format_plot_data2 $fft0_time_traces $fft0_time_raw_info $time_incr 0 fft0_time_raw_plots;

					set fft1_time_raw_traces {}
					set fft1_time_raw_info [list [list "Data1 $fft1_data_name Raw" 16 0 1.0] ]
					format_plot_data2 $fft1_time_traces $fft1_time_raw_info $time_incr 0 fft1_time_raw_plots;

					set fft0_freq_raw_plots {}
					set fft1_freq_raw_plots {}

					format_plot_data2 $fft0_freq_raw_traces $fft0_freq_raw_info [expr 1.953125 * 2] 0 fft0_freq_raw_plots;
					format_plot_data2 $fft1_freq_raw_traces $fft1_freq_raw_info [expr 1.953125 * 2] 0 fft1_freq_raw_plots;

					set fft0_mag_freq_raw_plots {}
					set fft1_mag_freq_raw_plots {}

					format_plot_data2 $fft0_freq_mag_traces_float $fft0_mag_float_freq_info [expr 1.953125 * 2] 0 fft0_freq_mag_raw_plots;
					format_plot_data2 $fft1_freq_mag_traces_float $fft1_mag_float_freq_info [expr 1.953125 * 2] 0 fft1_freq_mag_raw_plots;

					#Peak plot
					set fft0_freq_peak_plots {}
					set fft1_freq_peak_plots {}

					format_plot_data2 $fft0_freq_peak_traces $fft0_peak_freq_info [expr 1.953125 * 2] 0 fft0_freq_peak_plots;
					format_plot_data2 $fft1_freq_peak_traces $fft1_peak_freq_info [expr 1.953125 * 2] 0 fft1_freq_peak_plots;


					set fft0_freq_traces [list]
					set index 0
					set other_values [lindex $fft0_freq_raw_traces 1]
					set fft0_scaling_offset [expr log10 (16 / $fft0_scaling)]
					
					foreach value [lindex $fft0_freq_raw_traces 0] {
						set other_value [lindex $other_values $index]
						set two_power_17 1.0
						set value [expr {$value / $two_power_17}]
						set other_value [expr {$other_value / $two_power_17}]
						#set sqrtval [expr sqrt ([expr [expr $value * $value] + [expr $other_value * $other_value] ]) ]
						set sqrtval [expr [expr $value * $value] + [expr $other_value * $other_value] ]
						if {$sqrtval == 0} {set sqrtval 1}
						lappend fft0_freq_traces [expr ((log10 ($sqrtval) * 0.5) + $fft0_scaling_offset) * 20]
						#lappend fft0_freq_traces $sqrtval
						incr index
					}
					set fft0_freq_traces [list $fft0_freq_traces]

					foreach value [lindex $fft0_freq_mag_traces_float 0] {
						if {$value <= 0} {set value 1}
						lappend fft0_freq_mag_traces [expr ((log10 ($value) * 0.5) + $fft0_scaling_offset) * 20]
						incr index
					}
					set fft0_freq_mag_traces [list $fft0_freq_mag_traces]
					
					set fft0_peak_mag [lindex $fft0_freq_peak_traces 0 63]
					set fft0_peak_sample [lindex $fft0_freq_peak_traces 1 63]
					set fft0_peak_frequency [expr $fft0_peak_sample * [expr 1.953125 * 2]]
					if {$fft0_peak_mag != 0} {
						set fft0_peak_mag_db [expr ((log10 ($fft0_peak_mag) * 0.5) + $fft0_scaling_offset) * 20]
					} else {
						set fft0_peak_mag_db 0
					}

					if {$fft0_peak_mag != Inf} {
						set legend_str [format "Peak: %d Hz  Magnitude: %d dB" [expr int($fft0_peak_frequency)] [expr int($fft0_peak_mag_db)] ] 
					} else {
						send_message info "FFT0: Peak Sample = $fft0_peak_sample  Peak Freq = $fft0_peak_frequency Hz  Mag = $fft0_peak_mag  Magdb = $fft0_peak_mag_db"
						set legend_str [format "Peak: %d Hz  Magnitude: Inf dB" [expr int($fft0_peak_frequency)] ] 
					}
					
					if {$fft0_log_scaling == 1} {
						format_plot_data2_logtime $fft0_freq_traces $fft0_freq_info [expr 1.953125 * 2] 2048 fft0_freq_plots;
						format_plot_data2_logtime $fft0_freq_mag_traces $fft0_freq_hps_info [expr 1.953125 * 2] 2048 fft0_freq_mag_plots;
						format_plot_data_marker $fft0_freq_mag_traces "Peak Magnitude" $fft0_peak_frequency $fft0_peak_mag_db 2048 1 fft0_freq_mag_peak_plots
						dashboard_set_property $dash FFTfft0XY labelX "Frequency (Log10 Hz) : $legend_str"
					} else {
						format_plot_data2 $fft0_freq_traces $fft0_freq_info [expr 1.953125 * 2] 2048 fft0_freq_plots;
						format_plot_data2 $fft0_freq_mag_traces $fft0_freq_hps_info [expr 1.953125 * 2] 2048 fft0_freq_mag_plots;
						format_plot_data_marker $fft0_freq_mag_traces "Peak Magnitude" $fft0_peak_frequency $fft0_peak_mag_db 2048 0 fft0_freq_mag_peak_plots
						dashboard_set_property $dash FFTfft0XY labelX "Frequency (Hz) : $legend_str"
					}

					set fft1_freq_traces [list]
					set index 0
					set other_values [lindex $fft1_freq_raw_traces 1]

					set fft1_scaling_offset [expr log10 (16 / $fft1_scaling)]

					foreach value [lindex $fft1_freq_raw_traces 0] {
						set other_value [lindex $other_values $index]
						set two_power_17 1.0
						set value [expr {$value / $two_power_17}]
						set other_value [expr {$other_value / $two_power_17}]
						#set sqrtval [expr sqrt ([expr [expr $value * $value] + [expr $other_value * $other_value] ]) ]
						set sqrtval [expr [expr $value * $value] + [expr $other_value * $other_value] ]
						if {$sqrtval == 0} {set sqrtval 1}
						#lappend fft1_freq_traces [expr log10 ($sqrtval) * 0.5 * 20]
						lappend fft1_freq_traces [expr ((log10 ($sqrtval) * 0.5) + $fft1_scaling_offset) * 20]
						#lappend fft1_freq_traces $sqrtval
						incr index
					}
					set fft1_freq_traces [list $fft1_freq_traces]
					
					foreach value [lindex $fft1_freq_mag_traces_float 0] {
						if {$value <= 0} {set value 1}
						lappend fft1_freq_mag_traces [expr ((log10 ($value) * 0.5) + $fft1_scaling_offset) * 20]
						incr index
					}
					set fft1_freq_mag_traces [list $fft1_freq_mag_traces]
					
					set fft1_peak_mag [lindex $fft1_freq_peak_traces 0 63]
					set fft1_peak_sample [lindex $fft1_freq_peak_traces 1 63]
					set fft1_peak_frequency [expr $fft1_peak_sample * [expr 1.953125 * 2]]

					if {$fft1_peak_mag != 0} {
						set fft1_peak_mag_db [expr ((log10 ($fft1_peak_mag) * 0.5) + $fft1_scaling_offset) * 20]
					} else {
						set fft1_peak_mag_db 0
					}

					if {$fft1_peak_mag != Inf} {
						set legend_str [format "Peak: %d Hz  Magnitude: %d dB" [expr int($fft1_peak_frequency)] [expr int($fft1_peak_mag_db)] ] 
					} else {
						send_message info "FFT1: Peak Sample = $fft1_peak_sample  Peak Freq = $fft1_peak_frequency Hz  Mag = $fft1_peak_mag  Magdb = $fft1_peak_mag_db"
						set legend_str [format "Peak: %d Hz  Magnitude: Inf dB" [expr int($fft1_peak_frequency)] ] 
					}
					
					
					if {$fft1_log_scaling == 1} {
						format_plot_data2_logtime $fft1_freq_traces $fft1_freq_info [expr 1.953125 * 2] 2048 fft1_freq_plots;
						format_plot_data2_logtime $fft1_freq_mag_traces $fft1_freq_hps_info [expr 1.953125 * 2] 2048 fft1_freq_mag_plots;
						format_plot_data_marker $fft1_freq_mag_traces "Peak Magnitude" $fft1_peak_frequency $fft1_peak_mag_db 2048 1 fft1_freq_mag_peak_plots
						dashboard_set_property $dash FFTfft1XY labelX "Frequency (Log10 Hz) : $legend_str"

					} else {
						format_plot_data2 $fft1_freq_traces $fft1_freq_info [expr 1.953125 * 2] 2048 fft1_freq_plots;
						format_plot_data2 $fft1_freq_mag_traces $fft1_freq_hps_info [expr 1.953125 * 2] 2048 fft1_freq_mag_plots;
						format_plot_data_marker $fft1_freq_mag_traces "Peak Magnitude" $fft1_peak_frequency $fft1_peak_mag_db 2048 0 fft1_freq_mag_peak_plots
						dashboard_set_property $dash FFTfft1XY labelX "Frequency (Hz) : $legend_str"
					}

				}		
				
				set download_and_format [get_delta_time last_time]

				if {1} {
					
					plot_data VoltageXY [list [lindex $general_time_plots 0] [lindex $general_time_plots 1] [lindex $general_time_plots 2]];
					plot_data CurrentXY [list [lindex $general_time_plots 3] [lindex $general_time_plots 4] [lindex $general_time_plots 5]];
					plot_data SpeedXY [list [lindex $general_time_plots 6] [lindex $general_time_plots 7] ];
					plot_data DQCurrentXY [list [lindex $general_time_plots 8] [lindex $general_time_plots 9] [lindex $general_time_plots 10] [lindex $general_time_plots 11]];
					plot_data PosXY [list [lindex $general_time_plots 12] [lindex $general_time_plots 13]];

					if {$enable_FFT == 1} {
						dashboard_set_property $dash FFTtime0XY title "Time Plot - $fft0_data_name"
						dashboard_set_property $dash FFTtime0XY labelY "$fft0_data_name ($fft0_data_units)"
						plot_data FFTtime0XY [list [lindex $fft0_time_plots 0] ];
						dashboard_set_property $dash FFTfft0XY title "FFT Plot - $fft0_data_name"
						dashboard_set_property $dash FFTfft0XY labelY "FFT Magnitude (dB $fft0_data_units)"
						#TCL mag calculation version
						#plot_data FFTfft0XY [list [lindex $fft0_freq_plots 0] ];
						#HPS mag calculation version
						plot_data FFTfft0XY [list [lindex $fft0_freq_mag_plots 0] [lindex $fft0_freq_mag_peak_plots 0]];

						dashboard_set_property $dash FFTtime1XY title "Time Plot - $fft1_data_name"
						dashboard_set_property $dash FFTtime1XY labelY "$fft1_data_name ($fft1_data_units)"
						plot_data FFTtime1XY [list [lindex $fft1_time_plots 0]];
						#plot_data FFTfft1XY [list [lindex $fft1_freq_plots 0] [lindex $fft1_freq_mag_plots 0]];
						#TCL mag calculation version
						#plot_data FFTfft1XY [list [lindex $fft1_freq_plots 0] ];
						#HPS mag calculation version
						plot_data FFTfft1XY [list [lindex $fft1_freq_mag_plots 0] [lindex $fft1_freq_mag_peak_plots 0]];
						dashboard_set_property $dash FFTfft1XY title "FFT Plot - $fft1_data_name"
						dashboard_set_property $dash FFTfft1XY labelY "FFT Magnitude (dB $fft1_data_units)"

					}

					if {$enable_FFT == 1} {
						dump_plot_data [list [lindex $fft0_freq_raw_plots 0] [lindex $fft0_freq_raw_plots 1] [lindex $fft0_time_raw_plots 0] \
											 [lindex $fft0_freq_plots 0] [lreplace [lindex $fft0_time_plots 0] 0 0 "$fft0_data_name ($fft0_data_units)"]\
											 [lindex $fft1_freq_raw_plots 0] [lindex $fft1_freq_raw_plots 1] [lindex $fft1_time_raw_plots 0] \
											 [lindex $fft1_freq_plots 0] [lreplace [lindex $fft1_time_plots 0] 0 0 "$fft1_data_name ($fft1_data_units)"]\
											 [lindex $general_time_plots 0] [lindex $general_time_plots 1] [lindex $general_time_plots 2]\
											 [lindex $general_time_plots 3] [lindex $general_time_plots 4] [lindex $general_time_plots 5]\
											 [lindex $general_time_plots 6] [lindex $general_time_plots 7]\
											 [lindex $general_time_plots 8] [lindex $general_time_plots 9] [lindex $general_time_plots 10] [lindex $general_time_plots 11]\
											 [lindex $general_time_plots 12] [lindex $general_time_plots 13]\
											 [lindex $fft0_freq_mag_plots 0]\
											 [lindex $fft1_freq_mag_plots 0]\
											 [lindex $fft0_freq_peak_plots 0]\
											 [lindex $fft0_freq_peak_plots 1]\
											 [lindex $fft1_freq_peak_plots 0]\
											 [lindex $fft1_freq_peak_plots 1]\
											 \
											 ];  ##dump all fft data to a file
					} else {
						dump_plot_data [list [lindex $general_time_plots 0] [lindex $general_time_plots 1] [lindex $general_time_plots 2]\
											 [lindex $general_time_plots 3] [lindex $general_time_plots 4] [lindex $general_time_plots 5]\
											 [lindex $general_time_plots 6] [lindex $general_time_plots 7]\
											 [lindex $general_time_plots 8] [lindex $general_time_plots 9] [lindex $general_time_plots 10] [lindex $general_time_plots 11]\
											 [lindex $general_time_plots 12] [lindex $general_time_plots 13]\
											 \
											 ];  ##dump all data to a file
					}
											 
					set plotting_data [get_delta_time last_time]
				}
				#re-enable the FFT output buffer by writing to the reset bit
				if {$dbg_fft_status == 2} {
					debug_write_command 0 $::DOC_gui::DOC_DBG_FFT_PING_STATUS 0
				}

				start_dump;
				###send_message info "finished plotting data  [get_delta_time last_time]ms"
			}
		}
#		dashboard_set_property $dash status_label text "Status:-  Demo Mode: $demo_mode_str   DSP Mode: $dbg_dsp_mode_str   SpeedRequest: $dbg_speed_setp0 rpm    Motor: $dbg_motor_mode_str   Runtime: $dbg_runtime s   Incr: $next "
#		dashboard_set_property $dash status_label text "Status:-  Demo Mode: $demo_mode_str   Motor: $dbg_motor_mode_str   Runtime: $dbg_runtime s   Incr: $next "
		dashboard_set_property $dash status_label text "Status:-  Demo Mode: $demo_mode_str   Motor: $dbg_motor_mode_str"
		dashboard_set_property $dash status_label1 text "Runtime: $dbg_runtime s   Incr: $next "
#		dashboard_set_property $dash pushbutton1 text "Change DSP Mode ($dbg_dsp_mode_str)"

		set status_running 0

	}

 
	proc start_counter {a} {
		variable start_count
		variable dump_data_downloaded
		variable dash
		variable series0
		variable series1
		variable series2

		if {$start_count == 0} {
			set start_count 1
			update 0
		} else {
			set start_count 0
		}			
	}

	proc connect {a} {
		variable monitor_path
		variable connected
		variable dash
		variable trace_data
		variable start_count
		variable enable_FFT
		variable speedinterval_updating
		variable fftinterval_updating
		variable positioninterval_updating
		variable SYS_CONSOLE_DEBUG_RAM_BASE
		variable SYS_CONSOLE_TRACE_BASE_HEX
		variable speed_frac_bits_scale
		variable SPEED_FRAC_BITS

		if {$connected == 0} {

			set devices [ get_service_paths device]
			set device [lindex $devices 0]
			
			set masters [get_service_paths master]
			set j 0
			set found_master 0
			foreach master $masters {
				#alternative method to get info on master type
				if [regexp -nocase {usb_debug_master_0.([a-z0-9_]+)} $master mstrall mstr1] {
					send_message info "Connecting to USB Master $master"
					set found_master 1
					break;
				}
				incr j
			}			
			if {$found_master == 0} {
				foreach master $masters {
					#alternative method to get info on master type
					if [regexp -nocase {jtag_master.([a-z0-9_]+)} $master mstrall mstr1] {
						send_message info "Connecting to JTAG Master $master"
						set found_master 1
						break;
					} elseif [regexp -nocase {phy_[0-9]/master} $master mstrall mstr1] {
						send_message info "Connecting to JTAG Master $master"
						set found_master 1
						break;
					} elseif [regexp -nocase {alt_jtagavalon_wrapper_[0-9]} $master mstrall mstr1] {
						send_message info "Connecting to JTAG Master $master"
						set found_master 1
						break;
					} elseif [regexp -nocase {jtagmem_[0-9]} $master mstrall mstr1] {
						send_message info "Connecting to JTAG Master $master"
						set found_master 1
						break;
					}
					incr j
				}		
			}
			set ::DOC_gui::jd_path $master
			send_message info "Connecting to JTAG Master $master"
			open_service master $::DOC_gui::jd_path
			set retval [master_read_32 $::DOC_gui::jd_path 0x10000000 1]
			send_message info "Checking for System ID at 0x1000_0000 : Value = $retval"
			set retval [shex2dec32 $retval]
			set version_major [ expr (($retval & 0x00F00000)>>20)]
			set version_minor [ expr (($retval & 0x000F0000)>>16)]
			set powerboard_id [ expr (($retval & 0x0000F000)>>12)]
			set device_family [ expr (($retval & 0x00000F00)>>8)]
			set design_id [ expr (($retval & 0x000000FF))]
			send_message info "Version = $version_major.$version_minor  Device Family = $device_family  Powerboard Id = $powerboard_id  Design Id = $design_id"
			if {$device_family == 0} {
				set device_family_str "Cyclone IV DE2115"
				set SYS_CONSOLE_DEBUG_RAM_BASE		[uhex2dec32 0x03800000]	
				set SYS_CONSOLE_TRACE_BASE_HEX		0x04000000		
				set SPEED_FRAC_BITS 1
			} elseif {$device_family == 1} {
				set device_family_str "Cyclone VE Dev Kit"
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[uhex2dec32 0x0C000000]
				set SYS_CONSOLE_TRACE_BASE_HEX		0x04040000		
				set SPEED_FRAC_BITS 1
			} elseif {$device_family == 2} {
				set device_family_str "Cyclone V SX SoC Dev Kit"
				set SYS_CONSOLE_TRACE_BASE_HEX		0x00020000
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[expr 0x00040000]
				set SPEED_FRAC_BITS 4
			} elseif {$device_family == 3} {
				set device_family_str "MAX10 Demo"
				set SYS_CONSOLE_TRACE_BASE_HEX		0x04040000		
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[expr 0x09000000]
				set SPEED_FRAC_BITS 1
			} elseif {$device_family == 4} {
				set device_family_str "Cyclone V SX SoCKit"
				set SYS_CONSOLE_TRACE_BASE_HEX		0x00020000
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[expr 0x00040000]
				set SPEED_FRAC_BITS 4
			} elseif {$device_family == 5} {
				set device_family_str "Cyclone V SX SoC Dev Kit execute from QSPI"
				set SYS_CONSOLE_TRACE_BASE_HEX		0x00010000
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[expr 0x00020000]
				set SPEED_FRAC_BITS 4
			} elseif {$device_family == 8} {
				set device_family_str "Cyclone IV MercuryCode v1.0"
				#Setup for DevBoards CIV board
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[uhex2dec32 0x03800000]
				set SYS_CONSOLE_TRACE_BASE_HEX		0x04000000		
				set SPEED_FRAC_BITS 1
			} elseif {$device_family == 9} {
				set device_family_str "Cyclone VE MercuryCode v1.01"
				#Setup for DevBoards CVE board
				set SYS_CONSOLE_DEBUG_RAM_BASE 			[uhex2dec32 0x03800000]
				set SYS_CONSOLE_TRACE_BASE_HEX		0x04000000	
				set SPEED_FRAC_BITS 1
			} else {
				set device_family_str "Unknown"
			}
			#All design variants now use 4 fractional bits
			set SPEED_FRAC_BITS 4
			set speed_frac_bits_scale [expr (1 << $SPEED_FRAC_BITS) * 1.0]
			#send_message info "Setting Speed Fractional Bits = $SPEED_FRAC_BITS"
			
			if {$powerboard_id == 0} {
				set powerboard_id_str "FalconEye v1.4 Single-axis"
			} elseif {$powerboard_id == 1} {
				set powerboard_id_str "FalconEye v2.0 HSMC Single-axis"
			} elseif {$powerboard_id == 2} {
				set powerboard_id_str "FalconEye v2.0 EBV Single-axis"
			} elseif {$powerboard_id == 3} {
				set powerboard_id_str "Altera ALT12 Multi-axes"
			} else {
				set powerboard_id_str "Unknown"
			}
			
	#		send_message info "FPGA Board: $device_family_str    Power Board: $powerboard_id_str    Version: $version_major.$version_minor  "
			send_message info "FPGA Board     : $device_family_str"
			send_message info "Power Board    : $powerboard_id_str"
			send_message info "Design Version : $version_major.$version_minor  "
			
			if {$device_family == 2 || $device_family == 4} {
				set enable_FFT 1
				dashboard_set_property $dash tracedepthcombo_entry options [list 256 512 1024 2048 4096]
				dashboard_set_property $dash FFTGroup visible true
				
			}

			set connected 1
			dashboard_set_property $dash connectbutton text "Disconnect JTAG"
			init_debug 1;

			#start status polling
			if {$start_count == 0} {::DOC_gui::start_counter 1}

		} else {

			#stop trace if enabled
			if {$trace_data == 1} {::DOC_gui::start_trace 1}

			#stop status polling
			if {$start_count == 1} {::DOC_gui::start_counter 1}

			#Disable position demo if enabled
			if {$positioninterval_updating == 1} {
				::DOC_gui::positioninterval_button 1
			}
		
			#Disable speed demo if enabled
			if {$speedinterval_updating == 1} {
				::DOC_gui::speedinterval_button 1
			}
	
			#set ::DOC_gui::jd_path [lindex [get_service_paths master] 0]
			close_service master $::DOC_gui::jd_path
			set connected 0
			dashboard_set_property $dash connectbutton text "Connect JTAG"
		}
		
	}


	proc stop_counter {a} {
		variable start_count
		variable dash
		set start_count 0
		dashboard_set_property $dash mylabel text "Graph Stopped"
	}

	proc button {a} {
		debug_write_command 0 [expr {$::DOC_gui::DOC_DBG_BUTTONS + $a}] 1
	}

	proc speed_update {speed} {
		variable dash
		set speed [lindex  [dashboard_get_property $::DOC_gui::dash mycombo options] [dashboard_get_property $dash mycombo selected]]
		send_message info "Updating speed setpoint to $speed"
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 $speed
	}

	proc speed_update2 {combohandle} {
		variable dash
		set speed [lindex  [dashboard_get_property $::DOC_gui::dash ${combohandle}_entry options] [dashboard_get_property $dash ${combohandle}_entry selected]]
		# Now need to update the actual speed!!
		if {[string compare -nocase $speed "No Selection"] == 0} {
		} else {
			send_message info "Updating speed setpoint to $speed"
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 $speed
		}
	}

	proc axis_update {combohandle} {
		variable dash
		set axis [lindex  [dashboard_get_property $::DOC_gui::dash ${combohandle}_entry options] [dashboard_get_property $dash ${combohandle}_entry selected]]
		# Now need to update the actual axis!!
		send_message info "updating axis to $axis"
		set ::DOC_gui::DOC_DBG_AXIS_NUM $axis
 		debug_write_command 0 $::DOC_gui::DOC_DBG_AXIS_SELECT $axis
 		debug_write_command 1 $::DOC_gui::DOC_DBG_AXIS_SELECT $axis
 		debug_write_command 2 $::DOC_gui::DOC_DBG_AXIS_SELECT $axis
 		debug_write_command 3 $::DOC_gui::DOC_DBG_AXIS_SELECT $axis
 		#debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 $speed
		init_debug 1
	}


	proc speedinterval_button {dummy} {
		variable dash
		variable speedinterval_updating
		variable positioninterval_updating

		#Disable position demo if enabled
		if {$positioninterval_updating == 1} {
			::DOC_gui::positioninterval_button 1
		}

		if {$speedinterval_updating == 0} {
			set speedinterval_updating 1
			dashboard_set_property $dash speedupdatebutton text "Stop Speed Demo"
			#dashboard_set_property $dash speedupdatebutton1 text "Running Speed Demo..."
			dashboard_set_property $dash speedupdatebutton toolTip "Stop the speed demo running"
			speedinterval_update 0
		} else {
			set speedinterval_updating 0
			dashboard_set_property $dash speedupdatebutton text "Run Speed Demo"
			#dashboard_set_property $dash speedupdatebutton1 text "Run Speed Demo"
			dashboard_set_property $dash speedupdatebutton toolTip "Alternates between Speed 1 & 2 at Speed Interval"
		}
	}

	proc speedinterval_update {next} {
		variable dash
		variable speedinterval_updating

		if {$next == 2} {set next 0}

		set speed1_value [dashboard_get_property $dash speedval1text_entry text]
		set speed2_value [dashboard_get_property $dash speedval2text_entry text]
		set interval_value [dashboard_get_property $dash speedintervaltimetext_entry text]

		#send_message info "Speed update to $next [expr \$speed[expr $next +1]_value] speed - speed0:$speed1_value speed1:$speed2_value"
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 [expr \$speed[expr $next +1]_value]
		if {$speedinterval_updating == 1} {after [expr $interval_value] [ namespace code "speedinterval_update [ expr $next + 1 ]" ]}
	}

  
	 proc fftinterval_button {dummy} {
		variable dash
		variable fftinterval_updating
		variable speedinterval_updating
		variable positioninterval_updating
		variable demo_stage
		
		#Disable position demo if enabled
		if {$positioninterval_updating == 1} {
			::DOC_gui::positioninterval_button 1
		}

		#Disable speed demo if enabled
		if {$speedinterval_updating == 1} {
			::DOC_gui::speedinterval_button 1
		}

		if {$demo_stage != 6} {
			set fftinterval_updating 1
			dashboard_set_property $dash fftupdatebutton text "Advance Demo"
			#dashboard_set_property $dash fftupdatebutton1 text "Running FFT Demo..."
			dashboard_set_property $dash fftupdatebutton toolTip "Stop the fft demo running"
			#dashboard_set_property $dash fftupdatebutton1 toolTip "Stop the fft demo running"
			set demo_stage [expr $demo_stage + 1]
			fftdemo_update $demo_stage
#			if {$demo_stage == 7} {
#				set demo_stage 0
#			}
		} else {
			set fftinterval_updating 0
			dashboard_set_property $dash fftupdatebutton text "Advance Demo"
			#dashboard_set_property $dash fftupdatebutton1 text "Run FFT Demo"
			dashboard_set_property $dash fftupdatebutton toolTip "Scripted vibration suppression demo"
			#dashboard_set_property $dash fftupdatebutton1 toolTip "Scripted vibration suppression demo"
			set demo_stage 0
			fftdemo_update $demo_stage
		}
	}


	 proc fftdemo_update {next} {
		variable dash
		variable fftinterval_updating
		variable trace_data
		variable fft_demo_stage
		variable plot_fft0_peaks
		variable plot_fft1_peaks

		set interval_value 10000

		#if {$next == 6} {set next 1}
		#if {$next == 0} {set next 1}

		#if {$fftinterval_updating == 1} {after [expr $interval_value] [ namespace code "fftdemo_update [ expr $next + 1 ]" ]}
		
		set demo_stage $next
		#if fft has been disabled set the demo_stage to the reset state 6
		if {$fftinterval_updating == 0} {set demo_stage 6}

		set fft_demo_stage $demo_stage
		send_message info "Demo Stage $demo_stage"

		#KMSFFT

		# BEN: Need to give 'plot peaks' a default value otherwise they are undefined. Choose 'Don't plot peaks' as default. 
		set plot_fft0_peaks 0
		set plot_fft1_peaks 0

		set dbg_demo_mode $fft_demo_stage
		set SINGLE_COMBINED_VIBRATION_GRAPH 0

		if {$dbg_demo_mode == 0} {
			# Display html text describing all Vibration demo steps in equal size font
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			3. Increase speed control proportional gain. Response is faster but noisy. High gain around 1kHz could cause instability.<br>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			4. Apply notch filter centred at 1kHz. We keep a fast response but noise is suppressed.<br>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			5. Return to constant speed command. Unwanted speed changes have been reduced.
			</font>\</body>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0

		} elseif {$dbg_demo_mode == 1} {
			#Switch to FFT tab
			dashboard_set_property $dash FFTGroup visible true
			
			dashboard_set_property $dash triggersigcombo_entry selected 0
			dashboard_set_property $dash triggeredgecombo_entry selected 0
			dashboard_set_property $dash triggervaltext_entry text "0"
			trace_update 1

			# 7 is Speed, 0 is Iq
			dashboard_set_property $dash FFT0measuresigcombo_entry selected 7
			dashboard_set_property $dash FFT1measuresigcombo_entry selected 0
			dashboard_set_property $dash FFT0scalecombo_entry selected 0
			dashboard_set_property $dash FFT1scalecombo_entry selected 0
			FFTsetting_update 1

			#turn off tracing
			set trace_data 0
			start_trace 1
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 100
			dashboard_set_property $dash FFTcmd_wave_period_entry text "3500"
			dashboard_set_property $dash FFTcmd_wave_amp_pos_fl_entry text "0.0" 
			dashboard_set_property $dash FFTcmd_wave_amp_spd_fl_entry text "10.0"
			dashboard_set_property $dash FFTcmd_wave_en_entry selected 0
			dashboard_set_property $dash FFTcmd_wave_type_entry selected 2
			#dashboard_set_property $dash FFTcmd_wave_fft_sync_entry selected 0
			FFTcmdwave_update 0

			dashboard_set_property $dash Speed_Kp_text_entry text "20000"
			dashboard_set_property $dash Speed_Ki_text_entry text "500"
			tune_update 0

			dashboard_set_property $dash FFTfilt_fn_hz_fl_entry text "1000.0"
			dashboard_set_property $dash FFTfilt_fd_hz_fl_entry text "1000.0"
			dashboard_set_property $dash FFTfilt_zn_fl_entry text "10"
			dashboard_set_property $dash FFTfilt_zd_fl_entry text "100"
			dashboard_set_property $dash FFTfilt_dc_gain_fl_entry text "1.0"
			dashboard_set_property $dash FFTfilt_en_entry selected 0
			FFTfilt_update 0


			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			  # set vertical axis scaling on fft0 and fft1 time plots in rpm
			  dashboard_set_property $dash FFTtime0XY range [list 90 110]
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			} else {
			  # set vertical axis scaling on fft0 and fft1 time plots in rpm
			  dashboard_set_property $dash FFTtime0XY range [list 90 110]
			  dashboard_set_property $dash FFTtime1XY range {}
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			  dashboard_set_property $dash FFTfft1XY range [list 0 100]
			}
			# Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5>
			<body bgcolor=\"white\"><font face=\"verdana\" size=\"5\" color=\"black\">\
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.
			</font>\</body>\
			"
			set plot_fft0_peaks 0
			set plot_fft1_peaks 0
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0

		} elseif {$dbg_demo_mode == 2} {
			#// Vibration Demo 2/5: Add square wave to speed commands
			dashboard_set_property $dash triggersigcombo_entry selected 7
			dashboard_set_property $dash triggeredgecombo_entry selected 2
			dashboard_set_property $dash triggervaltext_entry text "5"
			trace_update 1
			
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 0
			dashboard_set_property $dash FFTcmd_wave_en_entry selected 1
			FFTcmdwave_update 0

			set plot_fft0_peaks 0
			set plot_fft1_peaks 0
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0

			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			  # set vertical axis scaling on fft0 and fft1 time plots to in rpm
			  dashboard_set_property $dash FFTtime0XY range [list 0 200]
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			} else {
			  # set vertical axis scaling on fft0 and fft1 time plots to in rpm
			  dashboard_set_property $dash FFTtime0XY range [list -20 20]
			  dashboard_set_property $dash FFTtime1XY range {}
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			  dashboard_set_property $dash FFTfft1XY range [list 0 100]
			}
			# Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=\"white\"><font face=\"verdana\" size=\"5\" color=\"black\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br>\
			</font>\</body>\
			</font>\
			"
		} elseif {$dbg_demo_mode == 3} {
			#// Vibration Demo 3/5: Increase speed control gains on gear 2, faster response but causes resonance
			dashboard_set_property $dash triggersigcombo_entry selected 7
			dashboard_set_property $dash triggeredgecombo_entry selected 2
			dashboard_set_property $dash triggervaltext_entry text "5"
			trace_update 1
			dashboard_set_property $dash FFTcmd_wave_en_entry selected 1
			FFTcmdwave_update 0

			dashboard_set_property $dash Speed_Kp_text_entry text "600000"
			dashboard_set_property $dash Speed_Ki_text_entry text "6000"
			tune_update 0

			dashboard_set_property $dash FFT0scalecombo_entry selected 0
			dashboard_set_property $dash FFT1scalecombo_entry selected 0
			FFTsetting_update 1

			# Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br></font>\
			<body bgcolor=\"white\"><font face=\"verdana\" size=\"5\" color=\"black\">\
			3. Increase speed control proportional gain. Response is faster but noisy. High gain around 1kHz could cause instability.<br>\
			</font>\</body>\
			"

			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 2000
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 2000
			FFTpk_update 0

			} elseif {$dbg_demo_mode == 4} {
			#// Vibration Demo 4/5: Enable suppression filter on gear 2, resonance suppressed
			dashboard_set_property $dash triggersigcombo_entry selected 7
			dashboard_set_property $dash triggeredgecombo_entry selected 2
			dashboard_set_property $dash triggervaltext_entry text "10 	5"
			trace_update 1

			dashboard_set_property $dash FFTcmd_wave_en_entry selected 1
			FFTcmdwave_update 0

			dashboard_set_property $dash Speed_Kp_text_entry text "600000"
			dashboard_set_property $dash Speed_Ki_text_entry text "6000"
			tune_update 0

			dashboard_set_property $dash FFTfilt_en_entry selected 1
			FFTfilt_update 0

			# Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			3. Increase speed control proportional gain. Response is faster but noisy. High gain around 1kHz could cause instability.<br>\
			<body bgcolor=\"white\"><font face=\"verdana\" size=\"5\" color=\"black\">\
			4. Apply notch filter centred at 1kHz. We keep a fast response but noise is suppressed.
			</font>\</body>\
			"
			set plot_fft0_peaks 0
			set plot_fft1_peaks 0
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0
		} elseif {$dbg_demo_mode == 5} {
			#// Vibration Demo 5/5: Return to constant speed: speed deviations on gear 2 are now less than on gear 1
			dashboard_set_property $dash triggersigcombo_entry selected 0
			dashboard_set_property $dash triggeredgecombo_entry selected 0
			dashboard_set_property $dash triggervaltext_entry text "0"
			trace_update 1
			
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 100
			dashboard_set_property $dash FFTcmd_wave_en_entry selected 0
			FFTcmdwave_update 0

			dashboard_set_property $dash Speed_Kp_text_entry text "600000"
			dashboard_set_property $dash Speed_Ki_text_entry text "6000"
			tune_update 0

			dashboard_set_property $dash FFTfilt_en_entry selected 1
			FFTfilt_update 0

			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			  # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
			  dashboard_set_property $dash FFTtime0XY range [list 90 110]
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			} else {
			  # set vertical axis scaling on fft0 and fft1 time plots to 0..200rpm
			  dashboard_set_property $dash FFTtime0XY range [list 90 110]
			  dashboard_set_property $dash FFTtime1XY range {}
			  # set vertical axis scaling on fft0 and fft1 fft plots to 0..100 dB (rpm)
			  dashboard_set_property $dash FFTfft0XY range [list 0 100]
			  dashboard_set_property $dash FFTfft1XY range [list 0 100]
			}
			# Display html text in Vibration (FFT) tab, with description of current step highlighted, any previous steps in standard font for reference
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			3. Increase speed control proportional gain. Response is faster but noisy. High gain around 1kHz could cause instability.<br>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"3\" color=\"gray\">\
			4. Apply notch filter centred at 1kHz. We keep a fast response but noise is suppressed.<br>\
			<body bgcolor=\"white\"><font face=\"verdana\" size=\"5\" color=\"black\">\
			5. Return to constant speed command. Unwanted speed changes have been reduced.
			</font>\</body>\
			"

			set plot_fft0_peaks 0
			set plot_fft1_peaks 0
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0

		} elseif {$dbg_demo_mode == 6} { # Vibration step 6: reset and show text describing all steps in equal size font
			#// Finish vibration demo: Undo changes to gear 2: reduce gains to defaults and disable filter
			dashboard_set_property $dash triggersigcombo_entry selected 0
			dashboard_set_property $dash triggeredgecombo_entry selected 0
			dashboard_set_property $dash triggervaltext_entry text "0"
			trace_update 1

			dashboard_set_property $dash FFTcmd_wave_en_entry selected 0
			FFTcmdwave_update 0
			dashboard_set_property $dash Speed_Kp_text_entry text "20000"
			dashboard_set_property $dash Speed_Ki_text_entry text "500"
			tune_update 0
			dashboard_set_property $dash FFTfilt_en_entry selected 0
			FFTfilt_update 0

			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
			dashboard_set_property $dash FFT0pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT0pkdetlimhigh_entry text 7500
			dashboard_set_property $dash FFT1pkdetlimlow_entry text 500
			dashboard_set_property $dash FFT1pkdetlimhigh_entry text 7500
			FFTpk_update 0

			#turn off tracing
			#set trace_data 1
			#start_trace 1
			
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0 100

			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			# set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			# set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
			dashboard_set_property $dash FFTfft0XY range [list 0 140]
			} else {
			# set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			dashboard_set_property $dash FFTtime1XY range {}
			# set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
			dashboard_set_property $dash FFTfft0XY range [list 0 140]
			dashboard_set_property $dash FFTfft1XY range [list 0 140]
			}
			# Display html text describing all Vibration demo steps in equal size font
			dashboard_set_property $dash SPS10text1 text "\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\ 
			1. Apply constant speed command. Actual speed changes due to motor 'cogging'. We wish to reduce these changes.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			2. Change to step speed command. Step response is slow, may pause at zero speed due to friction.<br></font>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			3. Increase speed control proportional gain. Response is faster but noisy. High gain around 1kHz could cause instability.<br>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			4. Apply notch filter centred at 1kHz. We keep a fast response but noise is suppressed.<br>\
			<body bgcolor=#F5F5F5><font face=\"verdana\" size=\"4\" color=\"black\">\
			5. Return to constant speed command. Unwanted speed changes have been reduced.
			</font>\</body>\
			"
		} elseif {$dbg_demo_mode == 7} {
			# BEN: Scaling settings previously set in  mode 6 (Vibration reset); mode 6 happens fast and sometimes System Console does not notice it and hence does not apply the scaling.
			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			# set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			# set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
			dashboard_set_property $dash FFTfft0XY range [list 0 140]
			} else {
			# set vertical axis scaling on fft0 and fft1 time plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			dashboard_set_property $dash FFTtime1XY range {}
			# set vertical axis scaling on fft0 and fft1 fft plots to 0..140 dB (rpm)
			dashboard_set_property $dash FFTfft0XY range [list 0 140]
			dashboard_set_property $dash FFTfft1XY range [list 0 140]
			}
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - Basic: Gears, position independent<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 8} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - SlowMesh: Gears, speed/position locked<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 9} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - Competition: Gears, guess the mathematical sequence...<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 10} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - MoveTogether: Actuators, coordinated move<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 11} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - MoveOpposite: Actuators, coordinated move<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 12} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - Stationary1: Actuator 1 stationary<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 13} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - Stationary2: Actuator 2 stationary<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 14} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - SlowFast: Actuators, coordinated move<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 15} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - FastRolling: Gears pass with one stopped<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 16} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - Fast2: Gears roll past each other<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 17} {
			# Display html text describing demo in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Demo $dbg_demo_mode - EtherCAT: Interactive control<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} elseif {$dbg_demo_mode == 31} { # Calibration mode: For presentation purposes, show text describing all steps of Vibration Demo in equal size font
			if {$SINGLE_COMBINED_VIBRATION_GRAPH==1} {
			# set vertical axis scaling on fft0 and fft1 time and fft plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			dashboard_set_property $dash FFTfft0XY range {}
			} else {
			# set vertical axis scaling on fft0 and fft1 time and fft plots to auto-scaling
			dashboard_set_property $dash FFTtime0XY range {}
			dashboard_set_property $dash FFTtime1XY range {}
			dashboard_set_property $dash FFTfft0XY range {}
			dashboard_set_property $dash FFTfft1XY range {}
			}
			# Display html text describing mode in 'Vibration' (FFT) analysis tab
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Mode $dbg_demo_mode - Motor Calibration<br>\
			</font>\
			"
			set plot_fft0_peaks 1
			set plot_fft1_peaks 1
		} else {
			dashboard_set_property $dash SPS10text1 text "\
			<font size=\"+4\">\
			Undefined Demo mode $dbg_demo_mode - ?????<br>\
			</font>\
			"
		}

	}
  
  
	proc positioninterval_button {dummy} {
		variable dash
		variable positioninterval_updating
		variable speedinterval_updating

		#Disable speed demo if enabled
		if {$speedinterval_updating == 1} {
			::DOC_gui::speedinterval_button 1
		}

		if {$positioninterval_updating == 0} {
			set positioninterval_updating 1
			dashboard_set_property $dash positionupdatebutton text "Stop Position Demo"
#			dashboard_set_property $dash positionupdatebutton1 text "Running Position Demo..."
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_MODE 1
			positioninterval_update 0
		} else {
			set positioninterval_updating 0
			dashboard_set_property $dash positionupdatebutton text "Run Position Demo"
#			dashboard_set_property $dash positionupdatebutton1 text "Run Position Demo"
			debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_MODE 0
		}

	}

	proc positioninterval_update {next} {
		variable dash
		variable positioninterval_updating

		if {$next == 2} {set next 0}

		set position1_value [dashboard_get_property $dash positionval1text_entry text]
		set position2_value [dashboard_get_property $dash positionval2text_entry text]
		set speed_value [dashboard_get_property $dash positionspeedtext_entry text]
		set interval_value [dashboard_get_property $dash positionintervaltimetext_entry text]
		set actual_pos [::tcl::mathfunc::round [expr [expr \$position[expr $next +1]_value ] * [expr 65536 / 360.0]]]
		#send_message info "Position update to $next [expr \$position[expr $next +1]_value] position - position0:$position1_value position1:$position2_value  Actual = $actual_pos"
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_SPEED $speed_value
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_SETP0 $actual_pos

		#Update display dial so it covers full range of position demo
		if {$position1_value < $position2_value} {
			#standard case, position 1 is smaller than position 2
			if {$position1_value < 0} {
				dashboard_set_property $dash dial2 min [expr int($position1_value * 1.25)]
				dashboard_set_property $dash dial2a min [expr int($position1_value * 1.25)]
			} else {
				dashboard_set_property $dash dial2 min [expr int($position1_value * 0.8)]
				dashboard_set_property $dash dial2a min [expr int($position1_value * 0.8)]
			}
			if {$position2_value < 0} {
				dashboard_set_property $dash dial2 max [expr int($position2_value * 0.8)]
				dashboard_set_property $dash dial2a max [expr int($position2_value * 0.8)]
			} else {
				dashboard_set_property $dash dial2 max [expr int($position2_value * 1.25)]
				dashboard_set_property $dash dial2a max [expr int($position2_value * 1.25)]
			}
		} elseif {$position1_value > $position2_value} {
			#position 1 is bigger than position 2
			if {$position2_value < 0} {
				dashboard_set_property $dash dial2 min [expr int($position2_value * 1.25)]
				dashboard_set_property $dash dial2a min [expr int($position2_value * 1.25)]
			} else {
				dashboard_set_property $dash dial2 min [expr int($position2_value * 0.8)]
				dashboard_set_property $dash dial2a min [expr int($position2_value * 0.8)]
			}
			if {$position1_value < 0} {
				dashboard_set_property $dash dial2 max [expr int($position1_value * 0.8)]
				dashboard_set_property $dash dial2a max [expr int($position1_value * 0.8)]
			} else {
				dashboard_set_property $dash dial2 max [expr int($position1_value * 1.25)]
				dashboard_set_property $dash dial2a max [expr int($position1_value * 1.25)]
			}
		} else {
			#if positions equal, leave range as previous
		}

		dashboard_set_property $dash dial2 tickSize [ expr 360 / 4 ]
		dashboard_set_property $dash dial2a tickSize [ expr 360 / 4 ]
		dashboard_set_property $dash dial2a value [expr \$position[expr $next +1]_value ]
		

		if {$positioninterval_updating == 1} {after [expr $interval_value * 1] [ namespace code "positioninterval_update [ expr $next + 1 ]" ]}
	}


	proc toggledemo_button {dummy} {
		variable positioninterval_updating
		variable speedinterval_updating

		#Disable speed demo if enabled
		if {$speedinterval_updating == 1} {
			#go to position demo mode
			::DOC_gui::positioninterval_button 1
		} elseif {$positioninterval_updating == 1} {
			#back to no demo mode
			::DOC_gui::positioninterval_button 1
		} else {
			#go to speed demo mode
			::DOC_gui::speedinterval_button 1
		}	
	}
  	



	proc trace_update {dummy} {
		variable dash

		set trigger_data_select [dashboard_get_property $dash triggersigcombo_entry selected]
		set trigger_edge [dashboard_get_property $dash triggeredgecombo_entry selected]
		set trigger_value [dashboard_get_property $dash triggervaltext_entry text]
		if {[catch {expr $trigger_value}]} {
			set trigger_value 0
			dashboard_set_property $dash triggervaltext_entry text "0"
		}
		set trace_depth [lindex  [dashboard_get_property $::DOC_gui::dash tracedepthcombo_entry options] [dashboard_get_property $dash tracedepthcombo_entry selected]]
		set ::DOC_gui::trace_depth $trace_depth
		# Now need to update the actual speed!!
		#set dbg_speed_setp0 [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_SETP0]
		#send_message info "Trace setting updated to signal:$trigger_data_select edge:$trigger_edge value:$trigger_value depth:$trace_depth"
 		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_SEL $trigger_data_select
 		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_EDGE $trigger_edge
 		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_VALUE $trigger_value
	}

	
	proc FFTtrace_update {dummy} {
		variable dash
		set trigger_data_select [dashboard_get_property $dash FFTtriggersigcombo_entry selected]
		set trigger_edge [dashboard_get_property $dash FFTtriggeredgecombo_entry selected]
		set trigger_value [dashboard_get_property $dash FFTtriggervaltext_entry text]
		if {[catch {expr $trigger_value}]} {
			set trigger_value 0
			dashboard_set_property $dash FFTtriggervaltext_entry text "0"
		}
		set trace_depth [lindex  [dashboard_get_property $::DOC_gui::dash FFTtracedepthcombo_entry options] [dashboard_get_property $dash FFTtracedepthcombo_entry selected]]
		set ::DOC_gui::trace_depth $trace_depth
		puts "Trace setting updated to signal:$trigger_data_select edge:$trigger_edge value:$trigger_value depth:$trace_depth"
		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_SEL $trigger_data_select
		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_EDGE $trigger_edge
		debug_write_command 0 $::DOC_gui::DOC_DBG_TRIG_VALUE $trigger_value
	}

	proc FFTsetting_update {dummy} {
		variable dash
		set fft0_data_select [dashboard_get_property $dash FFT0measuresigcombo_entry selected]
		set fft1_data_select [dashboard_get_property $dash FFT1measuresigcombo_entry selected]
		set fft0_data_name [lindex  [dashboard_get_property $::DOC_gui::dash FFT0measuresigcombo_entry options] [dashboard_get_property $dash FFT0measuresigcombo_entry selected]]
		set fft1_data_name [lindex  [dashboard_get_property $::DOC_gui::dash FFT1measuresigcombo_entry options] [dashboard_get_property $dash FFT1measuresigcombo_entry selected]]
		set fft0_scale_select [dashboard_get_property $dash FFT0scalecombo_entry selected]
		set fft1_scale_select [dashboard_get_property $dash FFT1scalecombo_entry selected]
		set fft_sel [expr ($fft0_data_select & 0xff) | (($fft1_data_select & 0xff)<<8) | (($fft0_scale_select & 0xff)<<16) | (($fft1_scale_select & 0xff)<<24)]

		puts "FFT setting updated to signal0:${fft0_data_select}=${fft0_data_name} signal1:${fft1_data_select}=${fft1_data_name} RegVal=$fft_sel"
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FFT_SELECT $fft_sel		
	}

	
	proc FFTpk_update {dummy} {
		variable dash

		set fft0_pkdetlimlow [dashboard_get_property $dash FFT0pkdetlimlow_entry text]
		set fft0_pkdetlimhigh [dashboard_get_property $dash FFT0pkdetlimhigh_entry text]
		set fft1_pkdetlimlow [dashboard_get_property $dash FFT1pkdetlimlow_entry text]
		set fft1_pkdetlimhigh [dashboard_get_property $dash FFT1pkdetlimhigh_entry text]

		set fft0_pkdetlimlowcounts [expr int ($fft0_pkdetlimlow * 2048 / 8000)]
		set fft0_pkdetlimhighcounts [expr int ( (8000 - $fft0_pkdetlimhigh) * 2048 / 8000)]
		
		set fft1_pkdetlimlowcounts [expr int ($fft1_pkdetlimlow * 2048 / 8000)]
		set fft1_pkdetlimhighcounts [expr int ((8000 - $fft1_pkdetlimhigh) * 2048 / 8000)]
		
		#puts "FFT0 PK counts: low = $fft0_pkdetlimlowcounts high = $fft0_pkdetlimhighcounts"
		#puts "FFT1 PK counts: low = $fft1_pkdetlimlowcounts high = $fft1_pkdetlimhighcounts"
		
		#set fft0_pk_lim [expr ((($fft0_pkdetlimhigh & 0xFFFF)<<16)|($fft0_pkdetlimlow & 0xFFFF))]
		set fft0_pk_lim [expr ((($fft0_pkdetlimhighcounts & 0xFFFF)<<16)|($fft0_pkdetlimlowcounts & 0xFFFF))]
		debug_write_command 0 $::DOC_gui::DOC_DBG_FFT0_PK_DET_LIM $fft0_pk_lim

		#set fft1_pk_lim [expr ((($fft1_pkdetlimhigh & 0xFFFF)<<16)|($fft1_pkdetlimlow & 0xFFFF))]
		set fft1_pk_lim [expr ((($fft1_pkdetlimhighcounts & 0xFFFF)<<16)|($fft1_pkdetlimlowcounts & 0xFFFF))]
		debug_write_command 0 $::DOC_gui::DOC_DBG_FFT1_PK_DET_LIM $fft1_pk_lim
	}



	
	proc FFTcmdwave_update {dummy} {
		variable dash
		set cmd_wave_period [dashboard_get_property $dash FFTcmd_wave_period_entry text]
		#set cmd_wave_offset [dashboard_get_property $dash FFTcmd_wave_offset_entry text]
		set cmd_wave_offset 0

		set cmd_wave_amp_pos_fl [dashboard_get_property $dash FFTcmd_wave_amp_pos_fl_entry text]
		set cmd_wave_amp_spd_fl [dashboard_get_property $dash FFTcmd_wave_amp_spd_fl_entry text]
		set cmd_wave_en [dashboard_get_property $dash FFTcmd_wave_en_entry selected]
		set cmd_wave_type [dashboard_get_property $dash FFTcmd_wave_type_entry selected]
		#set cmd_wave_fft_sync [dashboard_get_property $dash FFTcmd_wave_fft_sync_entry selected]
		set cmd_wave_fft_sync 0
		set wave_type [expr ((($cmd_wave_fft_sync & 0xFF)<<16)|(($cmd_wave_en & 0xFF)<<8)|($cmd_wave_type & 0xFF))]
		puts "period: $cmd_wave_period  offset:$cmd_wave_offset  pos amp:$cmd_wave_amp_pos_fl  spd amp:$cmd_wave_amp_spd_fl  wave en:$cmd_wave_en  wave type:$cmd_wave_type  fft sync:$cmd_wave_fft_sync typeenc:$wave_type"

		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_PERIOD $cmd_wave_period
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_OFFSET $cmd_wave_offset

		set fft0_pkdetlimlow [dashboard_get_property $dash FFT0pkdetlimlow_entry text]
		set fft0_pkdetlimhigh [dashboard_get_property $dash FFT0pkdetlimhigh_entry text]
		set fft1_pkdetlimlow [dashboard_get_property $dash FFT1pkdetlimlow_entry text]
		set fft1_pkdetlimhigh [dashboard_get_property $dash FFT1pkdetlimhigh_entry text]

		set fft0_pk_lim [expr ((($fft0_pkdetlimhigh & 0xFFFF)<<16)|($fft0_pkdetlimlow & 0xFFFF))]
		debug_write_command 0 $::DOC_gui::DOC_DBG_FFT0_PK_DET_LIM $fft0_pk_lim

		set fft1_pk_lim [expr ((($fft1_pkdetlimhigh & 0xFFFF)<<16)|($fft1_pkdetlimlow & 0xFFFF))]
		debug_write_command 0 $::DOC_gui::DOC_DBG_FFT1_PK_DET_LIM $fft1_pk_lim
		
		
		set actual_pos $cmd_wave_amp_pos_fl
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_AMP_POS [singlef2hex $actual_pos]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_AMP_SPD [singlef2hex $cmd_wave_amp_spd_fl]

		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_TYPE $wave_type
		
		puts "period = [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_PERIOD]  \
		spd pos = [format "%E" [hex2singlef [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_AMP_SPD]]]"
	}



	proc FFTfilt_update {dummy} {
		variable dash
		set filt_fn_hz_fl [dashboard_get_property $dash FFTfilt_fn_hz_fl_entry text]
		set filt_fd_hz_fl [dashboard_get_property $dash FFTfilt_fd_hz_fl_entry text]
		set filt_zn_fl [dashboard_get_property $dash FFTfilt_zn_fl_entry text]
		set filt_zd_fl [dashboard_get_property $dash FFTfilt_zd_fl_entry text]
		set filt_dc_gain_fl [dashboard_get_property $dash FFTfilt_dc_gain_fl_entry text]
		set filt_en [dashboard_get_property $dash FFTfilt_en_entry selected]
		puts "fn_hz: $filt_fn_hz_fl  fd_hz:$filt_fd_hz_fl  zn_fl:$filt_zn_fl  zd_fl:$filt_zd_fl  dc_gain_fl:$filt_dc_gain_fl filt en:$filt_en"

		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_FN_HZ_FL [singlef2hex $filt_fn_hz_fl]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_FD_HZ_FL [singlef2hex $filt_fd_hz_fl]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_ZN_FL [singlef2hex $filt_zn_fl]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_ZD_FL [singlef2hex $filt_zd_fl]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_DC_GAIN_FL [singlef2hex $filt_dc_gain_fl]
		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_EN $filt_en
	}
	
	
	proc openloop_update {dummy} {
		variable dash

		set enable_ol [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_OL_EN]

		if {$enable_ol == 0} {
			set enable_ol 1
		} else {
			set enable_ol 0
		}
		
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_OL_EN $enable_ol
	}

	
	proc tune_update {dummy} {
		variable dash

		set I_Kp [dashboard_get_property $dash I_Kp_text_entry text]
	 	set I_Ki [dashboard_get_property $dash I_Ki_text_entry text]
 	
		set I_FB_Lim [dashboard_get_property $dash I_FB_Lim_text_entry text]
	 	set I_OP_Lim [dashboard_get_property $dash I_OP_Lim_text_entry text]
 	
		set Speed_Kp [dashboard_get_property $dash Speed_Kp_text_entry text]
	 	set Speed_Ki [dashboard_get_property $dash Speed_Ki_text_entry text]

		set Position_Kp [dashboard_get_property $dash Position_Kp_text_entry text]
	 	set Position_SpeedFF_Kp [dashboard_get_property $dash Position_SpeedFF_Kp_text_entry text]


		puts "PI tuning updated to I_Ki:$I_Ki I_Kp:$I_Kp I_OP_Lim:$I_OP_Lim I_FB_Lim:$I_FB_Lim Speed_Ki:$Speed_Ki  Speed_Kp:$Speed_Kp"
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KP $I_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KI $I_Ki

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_FB_LIM $I_FB_Lim
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_OP_LIM $I_OP_Lim

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KP $Speed_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KI $Speed_Ki

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_PI_KP $Position_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_SPDFF_KP $Position_SpeedFF_Kp
	}


	proc FFTtune_update {dummy} {
		variable dash

		set I_Kp [dashboard_get_property $dash FFTI_Kp_text_entry text]
	 	set I_Ki [dashboard_get_property $dash FFTI_Ki_text_entry text]
 	
		set I_FB_Lim [dashboard_get_property $dash FFTI_FB_Lim_text_entry text]
	 	set I_OP_Lim [dashboard_get_property $dash FFTI_OP_Lim_text_entry text]
 	
		set Speed_Kp [dashboard_get_property $dash FFTSpeed_Kp_text_entry text]
	 	set Speed_Ki [dashboard_get_property $dash FFTSpeed_Ki_text_entry text]

		set Position_Kp [dashboard_get_property $dash FFTPosition_Kp_text_entry text]
	 	set Position_SpeedFF_Kp [dashboard_get_property $dash FFTPosition_SpeedFF_Kp_text_entry text]

		puts "PI tuning updated to I_Ki:$I_Ki I_Kp:$I_Kp I_OP_Lim:$I_OP_Lim I_FB_Lim:$I_FB_Lim Speed_Ki:$Speed_Ki  Speed_Kp:$Speed_Kp"
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KP $I_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KI $I_Ki

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_FB_LIM $I_FB_Lim
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_OP_LIM $I_OP_Lim

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KP $Speed_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KI $Speed_Ki

 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_PI_KP $Position_Kp
 		debug_write_command $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_SPDFF_KP $Position_SpeedFF_Kp
	}
	
	
	
	proc init_debug {a} {
		variable enable_FFT
		
		::DOC_gui::trace_update 1;
		dashboard_set_property $::DOC_gui::dash speedrequestcombo_entry selected 9

		set I_Kp [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KP]
		set I_Ki [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_KI]

		dashboard_set_property $::DOC_gui::dash I_Ki_text_entry text $I_Ki
		dashboard_set_property $::DOC_gui::dash I_Kp_text_entry text $I_Kp

		set I_FB_Lim [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_FB_LIM]
		set I_OP_Lim [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_I_PI_OP_LIM]

		dashboard_set_property $::DOC_gui::dash I_FB_Lim_text_entry text $I_FB_Lim
		dashboard_set_property $::DOC_gui::dash I_OP_Lim_text_entry text $I_OP_Lim

		set Speed_Kp [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KP]
		set Speed_Ki [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_SPEED_PI_KI]

		dashboard_set_property $::DOC_gui::dash Speed_Ki_text_entry text $Speed_Ki
		dashboard_set_property $::DOC_gui::dash Speed_Kp_text_entry text $Speed_Kp

		set Position_Kp [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_PI_KP]
		set Position_SpeedFF_Kp [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_POS_SPDFF_KP]

		dashboard_set_property $::DOC_gui::dash Position_Kp_text_entry text $Position_Kp
		dashboard_set_property $::DOC_gui::dash Position_SpeedFF_Kp_text_entry text $Position_SpeedFF_Kp

		puts "Position_Kp = $Position_Kp    Position_SpeedFF_Kp = $Position_SpeedFF_Kp"
		
		#ashboard_set_property $::DOC_gui::dash FFTI_Ki_text_entry text $I_Ki
		#dashboard_set_property $::DOC_gui::dash FFTI_Kp_text_entry text $I_Kp
		#dashboard_set_property $::DOC_gui::dash FFTI_FB_Lim_text_entry text $I_FB_Lim
		#dashboard_set_property $::DOC_gui::dash FFTI_OP_Lim_text_entry text $I_OP_Lim
		#dashboard_set_property $::DOC_gui::dash FFTSpeed_Ki_text_entry text $Speed_Ki
		#dashboard_set_property $::DOC_gui::dash FFTSpeed_Kp_text_entry text $Speed_Kp
		#dashboard_set_property $::DOC_gui::dash FFTPosition_Kp_text_entry text $Position_Kp
		#dashboard_set_property $::DOC_gui::dash FFTPosition_SpeedFF_Kp_text_entry text $Position_SpeedFF_Kp

		if {$enable_FFT == 1} {
			##################################################################
			##### Now go and get all the FFT Monitor Tab GUI settings

			puts "Init FFT"
			
			#Update FFT Signal being monitored from debug ram
			set fft_sel [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FFT_SELECT]
			
			set fft0_data_select [expr ($fft_sel & 0xff)]
			set fft1_data_select [expr (($fft_sel & 0xff00)>>8)]
			set fft0_scale_select [expr ($fft_sel & 0xff0000)>>16]
			set fft1_scale_select [expr ($fft_sel & 0xff000000)>24]
			
			dashboard_set_property $::DOC_gui::dash FFT0measuresigcombo_entry selected $fft0_data_select
			dashboard_set_property $::DOC_gui::dash FFT1measuresigcombo_entry selected $fft1_data_select

			dashboard_set_property $::DOC_gui::dash FFT0scalecombo_entry selected $fft0_scale_select
			dashboard_set_property $::DOC_gui::dash FFT1scalecombo_entry selected $fft1_scale_select

			#Command Waveform x 7
			set cmd_wave_period [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_PERIOD]
			dashboard_set_property $::DOC_gui::dash FFTcmd_wave_period_entry text $cmd_wave_period
			
			#set cmd_wave_offset [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_OFFSET]
			#dashboard_set_property $::DOC_gui::dash FFTcmd_wave_offset_entry text $cmd_wave_offset
			
			set cmd_wave_amp_pos_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_AMP_POS]
			dashboard_set_property $::DOC_gui::dash FFTcmd_wave_amp_pos_fl_entry text [format %g [hex2singlef $cmd_wave_amp_pos_fl]]
			
			set cmd_wave_amp_spd_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_AMP_SPD]
			dashboard_set_property $::DOC_gui::dash FFTcmd_wave_amp_spd_fl_entry text [format %g [hex2singlef $cmd_wave_amp_spd_fl]]
			
			set cmd_wave_type [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_CMD_WAVE_TYPE]
			#Extract the bit fields
			set cmd_wave_en [expr ($cmd_wave_type & 0xff00)>>8]
			set cmd_wave_fft_sync [expr ($cmd_wave_type & 0xff0000)>>16]
			set cmd_wave_type [expr ($cmd_wave_type & 0xff)]
			
			dashboard_set_property $::DOC_gui::dash FFTcmd_wave_en_entry selected $cmd_wave_en
			#dashboard_set_property $::DOC_gui::dash FFTcmd_wave_fft_sync_entry selected $cmd_wave_fft_sync
			dashboard_set_property $::DOC_gui::dash FFTcmd_wave_type_entry selected $cmd_wave_type

			#Filter settings x 6

			set filt_fn_hz_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_FN_HZ_FL]
			dashboard_set_property $::DOC_gui::dash FFTfilt_fn_hz_fl_entry text [format %g [hex2singlef $filt_fn_hz_fl]]

			set filt_fd_hz_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_FD_HZ_FL]
			dashboard_set_property $::DOC_gui::dash FFTfilt_fd_hz_fl_entry text [format %g [hex2singlef $filt_fd_hz_fl]]

			set filt_zn_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_ZN_FL]
			dashboard_set_property $::DOC_gui::dash FFTfilt_zn_fl_entry text [format %g [hex2singlef $filt_zn_fl]]

			set filt_zd_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_ZD_FL]
			dashboard_set_property $::DOC_gui::dash FFTfilt_zd_fl_entry text [format %g [hex2singlef $filt_zd_fl]]

			set filt_dc_gain_fl [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_DC_GAIN_FL]
			dashboard_set_property $::DOC_gui::dash FFTfilt_dc_gain_fl_entry text [format %g [hex2singlef $filt_dc_gain_fl]]

			set filt_en [debug_read_status $::DOC_gui::DOC_DBG_AXIS_NUM $::DOC_gui::DOC_DBG_FILT_EN]
			dashboard_set_property $::DOC_gui::dash FFTfilt_en_entry selected $filt_en
		}	
	}


}
