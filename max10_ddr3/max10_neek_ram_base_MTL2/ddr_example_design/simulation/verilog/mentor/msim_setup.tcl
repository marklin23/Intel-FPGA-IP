
# (C) 2001-2018 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ----------------------------------------
# Auto-generated simulation script msim_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     ddr_example_sim
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "mentor.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/mentor/msim_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog <compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run -a
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If ddr_example_sim is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 16.1 196 win32 2018.07.19.11:44:20

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "ddr_example_sim"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/intelfpga_lite/16.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_AC_ROM.hex ./
  file copy -force $QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_inst_ROM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/fiftyfivenm_ver/ 
  vmap       fiftyfivenm_ver  ./libraries/fiftyfivenm_ver/ 
}


# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"               -work altera_ver      
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                        -work lpm_ver         
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                           -work sgate_ver       
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                       -work altera_mf_ver   
    eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                   -work altera_lnsim_ver
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/fiftyfivenm_atoms.v"               -work fiftyfivenm_ver 
    eval  vlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v" -work fiftyfivenm_ver 
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/alt_mem_ddrx_mm_st_converter.v"                                                  
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd_wrap.v"                                                    
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr2_odt_gen.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr3_odt_gen.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_lpddr2_addr_cmd.v"                                                  
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_odt_gen.v"                                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdwr_data_tmg.v"                                                    
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_arbiter.v"                                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_gen.v"                                                        
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_cmd_gen.v"                                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_csr.v"                                                              
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer.v"                                                           
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer_manager.v"                                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_tracking.v"                                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_dataid_manager.v"                                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_fifo.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_list.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdata_path.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_wdata_path.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder.v"                                                      
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_32_syn.v"                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_64_syn.v"                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder.v"                                                      
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_32_syn.v"                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_64_syn.v"                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v"                                      
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_axi_st_converter.v"                                                 
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_input_if.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rank_timer.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_sideband.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_tbp.v"                                                              
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_timing_param.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS     {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller_st_top.v"                                                
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS {"+incdir+$QSYS_SIMDIR/submodules/"} "$QSYS_SIMDIR/submodules/alt_mem_if_nextgen_ddr3_controller_core.sv"                                      
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                               
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                              
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/driver_definitions.sv"                                                           
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/addr_gen.sv"                                                                     
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/burst_boundary_addr_gen.sv"                                                      
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/lfsr.sv"                                                                         
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/lfsr_wrapper.sv"                                                                 
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rand_addr_gen.sv"                                                                
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rand_burstcount_gen.sv"                                                          
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rand_num_gen.sv"                                                                 
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rand_seq_addr_gen.sv"                                                            
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/reset_sync.v"                                                                    
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/scfifo_wrapper.sv"                                                               
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/seq_addr_gen.sv"                                                                 
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/template_addr_gen.sv"                                                            
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/template_stage.sv"                                                               
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/driver_csr.sv"                                                                   
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/avalon_traffic_gen_avl_use_be_avl_use_burstbegin.sv"                             
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/block_rw_stage_avl_use_be_avl_use_burstbegin.sv"                                 
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/driver_avl_use_be_avl_use_burstbegin.sv"                                         
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/driver_fsm_avl_use_be_avl_use_burstbegin.sv"                                     
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/read_compare_avl_use_be_avl_use_burstbegin.sv"                                   
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/single_rw_stage_avl_use_be_avl_use_burstbegin.sv"                                
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_c0.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                         
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_rst.sv"                                                  
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                     
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                             
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                   
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                              
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                    
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0.v"                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_avalon_st_adapter.v"                 
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_cmd_demux.sv"                        
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_cmd_mux.sv"                          
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_router.sv"                           
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_router_001.sv"                       
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_rsp_demux.sv"                        
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_rsp_mux.sv"                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_ac_ROM_reg.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_bitcheck.v"                                                           
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rw_manager_core.sv"                                                              
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_datamux.v"                                                            
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_data_broadcast.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_data_decoder.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_ddr3.v"                                                               
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_di_buffer.v"                                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_di_buffer_wrap.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_dm_decoder.v"                                                         
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/rw_manager_generic.sv"                                                           
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_inst_ROM_reg.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_jumplogic.v"                                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_lfsr12.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_lfsr36.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_lfsr72.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_pattern_fifo.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_ram.v"                                                                
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_ram_csr.v"                                                            
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_read_datapath.v"                                                      
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_write_decoder.v"                                                      
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/sequencer_m10.sv"                                                                
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/sequencer_phy_mgr.sv"                                                            
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/sequencer_pll_mgr.sv"                                                            
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_m10_ac_ROM.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/rw_manager_m10_inst_ROM.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/afi_mux_ddr3_ddrx.v"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_clock_pair_generator.v"                                
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_read_valid_selector.v"                                 
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_addr_cmd_datapath.v"                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_reset_m10.v"                                           
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_memphy_m10.sv"                                         
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_dqdqs_pads_m10.sv"                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_reset_sync.v"                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_fr_cycle_shifter.v"                                    
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_read_datapath_m10.sv"                                  
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_write_datapath_m10.v"                                  
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_simple_ddio_out_m10.sv"                                
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/max10emif_dcfifo.sv"                                                             
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_iss_probe.v"                                           
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_addr_cmd_pads_m10.v"                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_flop_mem.v"                                            
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0.sv"                                                    
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_gpio_lite.sv"                                                             
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_pll0.sv"                                                  
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                       
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                     
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_mm_interconnect_0.v"                                          
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_d0.v"                                                         
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0.v"                                                        
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/alt_mem_if_ddr3_mem_model_top_ddr3_max10_mem_if_dm_pins_en_mem_if_dqsn_en.sv"    
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/alt_mem_if_common_ddr_mem_model_ddr3_max10_mem_if_dm_pins_en_mem_if_dqsn_en.sv"  
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_mem_if_checker_no_ifdef_params.sv"                                        
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/submodules/ddr_example_sim_e0.v"                                                            
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                                   
  eval  vlog -sv $USER_DEFINED_COMPILE_OPTIONS                                      "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                                   
  eval  vlog $USER_DEFINED_COMPILE_OPTIONS                                          "$QSYS_SIMDIR/ddr_example_sim.v"                                                                          
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo "                                 For most designs, this should be overridden"
  echo "                                 to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS  -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS     -- User-defined elaboration options, added to elab/elab_debug aliases."
}
file_copy
h
