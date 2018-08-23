set_global_assignment -entity "i2c_master" -library "lib_i2c_master" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "i2c_master" -library "lib_i2c_master" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "i2c_master" -library "lib_i2c_master" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_i2c_master" -name SPD_FILE [file join $::quartus(sip_path) "../i2c_master.spd"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "../../i2c_master.qsys"]

set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "i2c_master.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_csr.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_clk_cnt.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_condt_det.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_condt_gen.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_fifo.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_mstfsm.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_rxshifter.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_txshifter.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_spksupp.v"]
set_global_assignment -library "lib_i2c_master" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_i2c_txout.v"]
