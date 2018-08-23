
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

# ACDS 16.1 196 win32 2018.07.31.10:53:06
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     ddr
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "aldec.do", and modify the text as directed.
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
# source $QSYS_SIMDIR/aldec/rivierapro_setup.tcl
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
# vlog -sv2k5 <your compilation options> <design and testbench files>
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
# run
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If ddr is one of several IP cores in your
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

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "ddr"
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

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_AC_ROM.hex ./
  file copy -force $QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_inst_ROM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                  ./libraries/altera_ver      
vmap       altera_ver       ./libraries/altera_ver      
ensure_lib                  ./libraries/lpm_ver         
vmap       lpm_ver          ./libraries/lpm_ver         
ensure_lib                  ./libraries/sgate_ver       
vmap       sgate_ver        ./libraries/sgate_ver       
ensure_lib                  ./libraries/altera_mf_ver   
vmap       altera_mf_ver    ./libraries/altera_mf_ver   
ensure_lib                  ./libraries/altera_lnsim_ver
vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver
ensure_lib                  ./libraries/fiftyfivenm_ver 
vmap       fiftyfivenm_ver  ./libraries/fiftyfivenm_ver 
ensure_lib                                                                ./libraries/altera_common_sv_packages                                     
vmap       altera_common_sv_packages                                      ./libraries/altera_common_sv_packages                                     
ensure_lib                                                                ./libraries/error_adapter_0                                               
vmap       error_adapter_0                                                ./libraries/error_adapter_0                                               
ensure_lib                                                                ./libraries/a0                                                            
vmap       a0                                                             ./libraries/a0                                                            
ensure_lib                                                                ./libraries/ng0                                                           
vmap       ng0                                                            ./libraries/ng0                                                           
ensure_lib                                                                ./libraries/avalon_st_adapter_004                                         
vmap       avalon_st_adapter_004                                          ./libraries/avalon_st_adapter_004                                         
ensure_lib                                                                ./libraries/avalon_st_adapter_001                                         
vmap       avalon_st_adapter_001                                          ./libraries/avalon_st_adapter_001                                         
ensure_lib                                                                ./libraries/avalon_st_adapter                                             
vmap       avalon_st_adapter                                              ./libraries/avalon_st_adapter                                             
ensure_lib                                                                ./libraries/mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter
vmap       mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter ./libraries/mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter
ensure_lib                                                                ./libraries/rsp_mux_003                                                   
vmap       rsp_mux_003                                                    ./libraries/rsp_mux_003                                                   
ensure_lib                                                                ./libraries/rsp_mux                                                       
vmap       rsp_mux                                                        ./libraries/rsp_mux                                                       
ensure_lib                                                                ./libraries/rsp_demux_004                                                 
vmap       rsp_demux_004                                                  ./libraries/rsp_demux_004                                                 
ensure_lib                                                                ./libraries/rsp_demux_001                                                 
vmap       rsp_demux_001                                                  ./libraries/rsp_demux_001                                                 
ensure_lib                                                                ./libraries/rsp_demux                                                     
vmap       rsp_demux                                                      ./libraries/rsp_demux                                                     
ensure_lib                                                                ./libraries/cmd_mux_004                                                   
vmap       cmd_mux_004                                                    ./libraries/cmd_mux_004                                                   
ensure_lib                                                                ./libraries/cmd_mux_001                                                   
vmap       cmd_mux_001                                                    ./libraries/cmd_mux_001                                                   
ensure_lib                                                                ./libraries/cmd_mux                                                       
vmap       cmd_mux                                                        ./libraries/cmd_mux                                                       
ensure_lib                                                                ./libraries/cmd_demux_003                                                 
vmap       cmd_demux_003                                                  ./libraries/cmd_demux_003                                                 
ensure_lib                                                                ./libraries/cmd_demux                                                     
vmap       cmd_demux                                                      ./libraries/cmd_demux                                                     
ensure_lib                                                                ./libraries/dma_0_control_port_slave_burst_adapter                        
vmap       dma_0_control_port_slave_burst_adapter                         ./libraries/dma_0_control_port_slave_burst_adapter                        
ensure_lib                                                                ./libraries/mm_master_bfm_0_m0_limiter                                    
vmap       mm_master_bfm_0_m0_limiter                                     ./libraries/mm_master_bfm_0_m0_limiter                                    
ensure_lib                                                                ./libraries/router_009                                                    
vmap       router_009                                                     ./libraries/router_009                                                    
ensure_lib                                                                ./libraries/router_006                                                    
vmap       router_006                                                     ./libraries/router_006                                                    
ensure_lib                                                                ./libraries/router_005                                                    
vmap       router_005                                                     ./libraries/router_005                                                    
ensure_lib                                                                ./libraries/router_004                                                    
vmap       router_004                                                     ./libraries/router_004                                                    
ensure_lib                                                                ./libraries/router_003                                                    
vmap       router_003                                                     ./libraries/router_003                                                    
ensure_lib                                                                ./libraries/router                                                        
vmap       router                                                         ./libraries/router                                                        
ensure_lib                                                                ./libraries/mem_if_ddr3_emif_0_avl_agent                                  
vmap       mem_if_ddr3_emif_0_avl_agent                                   ./libraries/mem_if_ddr3_emif_0_avl_agent                                  
ensure_lib                                                                ./libraries/mm_master_bfm_0_m0_agent                                      
vmap       mm_master_bfm_0_m0_agent                                       ./libraries/mm_master_bfm_0_m0_agent                                      
ensure_lib                                                                ./libraries/mem_if_ddr3_emif_0_avl_translator                             
vmap       mem_if_ddr3_emif_0_avl_translator                              ./libraries/mem_if_ddr3_emif_0_avl_translator                             
ensure_lib                                                                ./libraries/mm_master_bfm_0_m0_translator                                 
vmap       mm_master_bfm_0_m0_translator                                  ./libraries/mm_master_bfm_0_m0_translator                                 
ensure_lib                                                                ./libraries/c0                                                            
vmap       c0                                                             ./libraries/c0                                                            
ensure_lib                                                                ./libraries/s0                                                            
vmap       s0                                                             ./libraries/s0                                                            
ensure_lib                                                                ./libraries/m0                                                            
vmap       m0                                                             ./libraries/m0                                                            
ensure_lib                                                                ./libraries/p0                                                            
vmap       p0                                                             ./libraries/p0                                                            
ensure_lib                                                                ./libraries/pll0                                                          
vmap       pll0                                                           ./libraries/pll0                                                          
ensure_lib                                                                ./libraries/p2b_adapter                                                   
vmap       p2b_adapter                                                    ./libraries/p2b_adapter                                                   
ensure_lib                                                                ./libraries/b2p_adapter                                                   
vmap       b2p_adapter                                                    ./libraries/b2p_adapter                                                   
ensure_lib                                                                ./libraries/transacto                                                     
vmap       transacto                                                      ./libraries/transacto                                                     
ensure_lib                                                                ./libraries/p2b                                                           
vmap       p2b                                                            ./libraries/p2b                                                           
ensure_lib                                                                ./libraries/b2p                                                           
vmap       b2p                                                            ./libraries/b2p                                                           
ensure_lib                                                                ./libraries/fifo                                                          
vmap       fifo                                                           ./libraries/fifo                                                          
ensure_lib                                                                ./libraries/timing_adt                                                    
vmap       timing_adt                                                     ./libraries/timing_adt                                                    
ensure_lib                                                                ./libraries/jtag_phy_embedded_in_jtag_master                              
vmap       jtag_phy_embedded_in_jtag_master                               ./libraries/jtag_phy_embedded_in_jtag_master                              
ensure_lib                                                                ./libraries/rst_controller                                                
vmap       rst_controller                                                 ./libraries/rst_controller                                                
ensure_lib                                                                ./libraries/mm_interconnect_0                                             
vmap       mm_interconnect_0                                              ./libraries/mm_interconnect_0                                             
ensure_lib                                                                ./libraries/sysid_qsys_0                                                  
vmap       sysid_qsys_0                                                   ./libraries/sysid_qsys_0                                                  
ensure_lib                                                                ./libraries/pio_0                                                         
vmap       pio_0                                                          ./libraries/pio_0                                                         
ensure_lib                                                                ./libraries/onchip_memory2_0                                              
vmap       onchip_memory2_0                                               ./libraries/onchip_memory2_0                                              
ensure_lib                                                                ./libraries/mm_master_bfm_0                                               
vmap       mm_master_bfm_0                                                ./libraries/mm_master_bfm_0                                               
ensure_lib                                                                ./libraries/mm_bridge_0                                                   
vmap       mm_bridge_0                                                    ./libraries/mm_bridge_0                                                   
ensure_lib                                                                ./libraries/mem_if_ddr3_emif_0                                            
vmap       mem_if_ddr3_emif_0                                             ./libraries/mem_if_ddr3_emif_0                                            
ensure_lib                                                                ./libraries/master_0                                                      
vmap       master_0                                                       ./libraries/master_0                                                      
ensure_lib                                                                ./libraries/dma_0                                                         
vmap       dma_0                                                          ./libraries/dma_0                                                         

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"              -work altera_ver      
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                       -work lpm_ver         
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                          -work sgate_ver       
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                      -work altera_mf_ver   
  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                  -work altera_lnsim_ver
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/fiftyfivenm_atoms.v"              -work fiftyfivenm_ver 
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/fiftyfivenm_atoms_ncrypt.v" -work fiftyfivenm_ver 
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                              -work altera_common_sv_packages                                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                              -work altera_common_sv_packages                                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                                       -work altera_common_sv_packages                                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter_004_error_adapter_0.sv"                   -l altera_common_sv_packages -work error_adapter_0                                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv"                   -l altera_common_sv_packages -work error_adapter_0                                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"                       -l altera_common_sv_packages -work error_adapter_0                                               
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/alt_mem_ddrx_mm_st_converter.v"                                                                                -work a0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd.v"                                                                                       -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd_wrap.v"                                                                                  -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr2_odt_gen.v"                                                                                   -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr3_odt_gen.v"                                                                                   -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_lpddr2_addr_cmd.v"                                                                                -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_odt_gen.v"                                                                                        -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdwr_data_tmg.v"                                                                                  -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_arbiter.v"                                                                                        -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_gen.v"                                                                                      -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_cmd_gen.v"                                                                                        -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_csr.v"                                                                                            -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer.v"                                                                                         -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer_manager.v"                                                                                 -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_tracking.v"                                                                                 -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_dataid_manager.v"                                                                                 -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_fifo.v"                                                                                           -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_list.v"                                                                                           -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdata_path.v"                                                                                     -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_wdata_path.v"                                                                                     -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder.v"                                                                                    -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_32_syn.v"                                                                             -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_64_syn.v"                                                                             -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder.v"                                                                                    -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_32_syn.v"                                                                             -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_64_syn.v"                                                                             -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v"                                                                    -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_axi_st_converter.v"                                                                               -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_input_if.v"                                                                                       -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rank_timer.v"                                                                                     -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_sideband.v"                                                                                       -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_tbp.v"                                                                                            -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_timing_param.v"                                                                                   -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller.v"                                                                                     -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller_st_top.v"                                                                              -work ng0                                                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      {\"+incdir+$QSYS_SIMDIR/submodules/\"} "$QSYS_SIMDIR/submodules/alt_mem_if_nextgen_ddr3_controller_core.sv"                                       -l altera_common_sv_packages -work ng0                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter_004.v"                                                                 -work avalon_st_adapter_004                                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter_001.v"                                                                 -work avalon_st_adapter_001                                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_avalon_st_adapter.v"                                                                     -work avalon_st_adapter                                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                                   -l altera_common_sv_packages -work mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                               -l altera_common_sv_packages -work mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                              -l altera_common_sv_packages -work mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_rsp_mux_003.sv"                                             -l altera_common_sv_packages -work rsp_mux_003                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work rsp_mux_003                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_rsp_mux.sv"                                                 -l altera_common_sv_packages -work rsp_mux                                                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work rsp_mux                                                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_rsp_demux_004.sv"                                           -l altera_common_sv_packages -work rsp_demux_004                                                 
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_rsp_demux_001.sv"                                           -l altera_common_sv_packages -work rsp_demux_001                                                 
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_rsp_demux.sv"                                               -l altera_common_sv_packages -work rsp_demux                                                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_cmd_mux_004.sv"                                             -l altera_common_sv_packages -work cmd_mux_004                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work cmd_mux_004                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_cmd_mux_001.sv"                                             -l altera_common_sv_packages -work cmd_mux_001                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work cmd_mux_001                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_cmd_mux.sv"                                                 -l altera_common_sv_packages -work cmd_mux                                                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work cmd_mux                                                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_cmd_demux_003.sv"                                           -l altera_common_sv_packages -work cmd_demux_003                                                 
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_cmd_demux.sv"                                               -l altera_common_sv_packages -work cmd_demux                                                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                                   -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                            -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                              -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                               -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                                   -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                                   -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                                -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                               -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                               -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                 -l altera_common_sv_packages -work dma_0_control_port_slave_burst_adapter                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                                 -l altera_common_sv_packages -work mm_master_bfm_0_m0_limiter                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                                  -l altera_common_sv_packages -work mm_master_bfm_0_m0_limiter                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                          -l altera_common_sv_packages -work mm_master_bfm_0_m0_limiter                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                 -l altera_common_sv_packages -work mm_master_bfm_0_m0_limiter                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router_009.sv"                                              -l altera_common_sv_packages -work router_009                                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router_006.sv"                                              -l altera_common_sv_packages -work router_006                                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router_005.sv"                                              -l altera_common_sv_packages -work router_005                                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router_004.sv"                                              -l altera_common_sv_packages -work router_004                                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router_003.sv"                                              -l altera_common_sv_packages -work router_003                                                    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0_router.sv"                                                  -l altera_common_sv_packages -work router                                                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                     -l altera_common_sv_packages -work mem_if_ddr3_emif_0_avl_agent                                  
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                              -l altera_common_sv_packages -work mem_if_ddr3_emif_0_avl_agent                                  
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                    -l altera_common_sv_packages -work mm_master_bfm_0_m0_agent                                      
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                                -l altera_common_sv_packages -work mem_if_ddr3_emif_0_avl_translator                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                               -l altera_common_sv_packages -work mm_master_bfm_0_m0_translator                                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_c0.v"                                                                                   -work c0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0.v"                                                                                   -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                                       -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_rst.sv"                                                   -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                      -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                              -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                    -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                               -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                     -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                                -l altera_common_sv_packages -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0.v"                                                                 -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_avalon_st_adapter.v"                                               -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv" -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_cmd_demux.sv"                         -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_cmd_mux.sv"                           -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_router.sv"                            -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_router_001.sv"                        -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_rsp_demux.sv"                         -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_s0_mm_interconnect_0_rsp_mux.sv"                           -l altera_common_sv_packages -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ac_ROM_reg.v"                                                                                       -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_bitcheck.v"                                                                                         -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/rw_manager_core.sv"                                                               -l altera_common_sv_packages -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_datamux.v"                                                                                          -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_data_broadcast.v"                                                                                   -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_data_decoder.v"                                                                                     -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ddr3.v"                                                                                             -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_di_buffer.v"                                                                                        -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_di_buffer_wrap.v"                                                                                   -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_dm_decoder.v"                                                                                       -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/rw_manager_generic.sv"                                                            -l altera_common_sv_packages -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_inst_ROM_reg.v"                                                                                     -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_jumplogic.v"                                                                                        -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr12.v"                                                                                           -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr36.v"                                                                                           -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr72.v"                                                                                           -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_pattern_fifo.v"                                                                                     -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ram.v"                                                                                              -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ram_csr.v"                                                                                          -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_read_datapath.v"                                                                                    -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_write_decoder.v"                                                                                    -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/sequencer_m10.sv"                                                                 -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/sequencer_phy_mgr.sv"                                                             -l altera_common_sv_packages -work s0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/sequencer_pll_mgr.sv"                                                             -l altera_common_sv_packages -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_m10_ac_ROM.v"                                                                                       -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_m10_inst_ROM.v"                                                                                     -work s0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/afi_mux_ddr3_ddrx.v"                                                                                           -work m0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_clock_pair_generator.v"                                                              -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_read_valid_selector.v"                                                               -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_addr_cmd_datapath.v"                                                                 -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_reset_m10.v"                                                                         -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_memphy_m10.sv"                                          -l altera_common_sv_packages -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_dqdqs_pads_m10.sv"                                      -l altera_common_sv_packages -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_reset_sync.v"                                                                        -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_fr_cycle_shifter.v"                                                                  -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_read_datapath_m10.sv"                                   -l altera_common_sv_packages -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_write_datapath_m10.v"                                                                -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_simple_ddio_out_m10.sv"                                 -l altera_common_sv_packages -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/max10emif_dcfifo.sv"                                                              -l altera_common_sv_packages -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_iss_probe.v"                                                                         -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_addr_cmd_pads_m10.v"                                                                 -work p0                                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0_flop_mem.v"                                                                          -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_p0.sv"                                                     -l altera_common_sv_packages -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_gpio_lite.sv"                                                              -l altera_common_sv_packages -work p0                                                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0_pll0.sv"                                                   -l altera_common_sv_packages -work pll0                                                          
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_master_0_p2b_adapter.sv"                                                      -l altera_common_sv_packages -work p2b_adapter                                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_master_0_b2p_adapter.sv"                                                      -l altera_common_sv_packages -work b2p_adapter                                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_packets_to_master.v"                                                                             -work transacto                                                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_packets_to_bytes.v"                                                                           -work p2b                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_bytes_to_packets.v"                                                                           -work b2p                                                           
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                                       -work fifo                                                          
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/ddr_master_0_timing_adt.sv"                                                       -l altera_common_sv_packages -work timing_adt                                                    
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_jtag_interface.v"                                                                             -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_jtag_dc_streaming.v"                                                                                    -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_jtag_sld_node.v"                                                                                        -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_jtag_streaming.v"                                                                                       -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                                                              -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                                                               -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                                              -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_remover.v"                                                                               -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_inserter.v"                                                                              -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                               -l altera_common_sv_packages -work jtag_phy_embedded_in_jtag_master                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                                     -work rst_controller                                                
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                                   -work rst_controller                                                
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mm_interconnect_0.v"                                                                                       -work mm_interconnect_0                                             
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_sysid_qsys_0.v"                                                                                            -work sysid_qsys_0                                                  
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_pio_0.v"                                                                                                   -work pio_0                                                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_onchip_memory2_0.v"                                                                                        -work onchip_memory2_0                                              
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS                                             "$QSYS_SIMDIR/submodules/altera_avalon_mm_master_bfm.sv"                                                   -l altera_common_sv_packages -work mm_master_bfm_0                                               
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_mm_bridge.v"                                                                                     -work mm_bridge_0                                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_mem_if_ddr3_emif_0.v"                                                                                      -work mem_if_ddr3_emif_0                                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_master_0.v"                                                                                                -work master_0                                                      
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_dma_0.v"                                                                                                   -work dma_0                                                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/ddr.v"                                                                                                                                                                                        
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L a0 -L ng0 -L avalon_st_adapter_004 -L avalon_st_adapter_001 -L avalon_st_adapter -L mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter -L rsp_mux_003 -L rsp_mux -L rsp_demux_004 -L rsp_demux_001 -L rsp_demux -L cmd_mux_004 -L cmd_mux_001 -L cmd_mux -L cmd_demux_003 -L cmd_demux -L dma_0_control_port_slave_burst_adapter -L mm_master_bfm_0_m0_limiter -L router_009 -L router_006 -L router_005 -L router_004 -L router_003 -L router -L mem_if_ddr3_emif_0_avl_agent -L mm_master_bfm_0_m0_agent -L mem_if_ddr3_emif_0_avl_translator -L mm_master_bfm_0_m0_translator -L c0 -L s0 -L m0 -L p0 -L pll0 -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L rst_controller -L mm_interconnect_0 -L sysid_qsys_0 -L pio_0 -L onchip_memory2_0 -L mm_master_bfm_0 -L mm_bridge_0 -L mem_if_ddr3_emif_0 -L master_0 -L dma_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L a0 -L ng0 -L avalon_st_adapter_004 -L avalon_st_adapter_001 -L avalon_st_adapter -L mm_master_bfm_0_m0_to_mem_if_ddr3_emif_0_avl_cmd_width_adapter -L rsp_mux_003 -L rsp_mux -L rsp_demux_004 -L rsp_demux_001 -L rsp_demux -L cmd_mux_004 -L cmd_mux_001 -L cmd_mux -L cmd_demux_003 -L cmd_demux -L dma_0_control_port_slave_burst_adapter -L mm_master_bfm_0_m0_limiter -L router_009 -L router_006 -L router_005 -L router_004 -L router_003 -L router -L mem_if_ddr3_emif_0_avl_agent -L mm_master_bfm_0_m0_agent -L mem_if_ddr3_emif_0_avl_translator -L mm_master_bfm_0_m0_translator -L c0 -L s0 -L m0 -L p0 -L pll0 -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L rst_controller -L mm_interconnect_0 -L sysid_qsys_0 -L pio_0 -L onchip_memory2_0 -L mm_master_bfm_0 -L mm_bridge_0 -L mem_if_ddr3_emif_0 -L master_0 -L dma_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
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
  echo "elab_debug                    -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -dbg -O2"
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
