
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

# ACDS 16.1 196 win32 2018.07.19.11:44:20

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     ddr_example_sim
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level shell script that compiles Altera simulation libraries
# and the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "ncsim.sh", and modify text as directed.
# 
# You can also modify the simulation flow to suit your needs. Set the
# following variables to 1 to disable their corresponding processes:
# - SKIP_FILE_COPY: skip copying ROM/RAM initialization files
# - SKIP_DEV_COM: skip compiling the Quartus EDA simulation library
# - SKIP_COM: skip compiling Quartus-generated IP simulation files
# - SKIP_ELAB and SKIP_SIM: skip elaboration and simulation
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
# # the simulator. In this case, you must also copy the generated files
# # "cds.lib" and "hdl.var" - plus the directory "cds_libs" if generated - 
# # into the location from which you launch the simulator, or incorporate
# # into any existing library setup.
# #
# # Run Quartus-generated IP simulation script once to compile Quartus EDA
# # simulation libraries and Quartus-generated IP simulation files, and copy
# # any ROM/RAM initialization files to the simulation directory.
# # - If necessary, specify USER_DEFINED_COMPILE_OPTIONS.
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1 \
# USER_DEFINED_COMPILE_OPTIONS=<compilation options for your design> \
# QSYS_SIMDIR=<script generation output directory>
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the IP script)
# #
# ncvlog <compilation options> <design and testbench files>
# #
# # TOP_LEVEL_NAME is used in this script to set the top-level simulation or
# # testbench module/entity name.
# #
# # Run the IP script again to elaborate and simulate the top level:
# # - Specify TOP_LEVEL_NAME and USER_DEFINED_ELAB_OPTIONS.
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME=<simulation top> \
# USER_DEFINED_ELAB_OPTIONS=<elaboration options for your design> \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
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
# initialize variables
TOP_LEVEL_NAME="ddr_example_sim"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="C:/intelfpga_lite/16.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS=""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/fiftyfivenm_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_AC_ROM.hex ./
  cp -f $QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_inst_ROM.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                -work altera_ver      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                         -work lpm_ver         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                            -work sgate_ver       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                        -work altera_mf_ver   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                    -work altera_lnsim_ver
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/fiftyfivenm_atoms.v"                -work fiftyfivenm_ver 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/fiftyfivenm_atoms_ncrypt.v" -work fiftyfivenm_ver 
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/alt_mem_ddrx_mm_st_converter.v"                                                  
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_addr_cmd_wrap.v"                                                    
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr2_odt_gen.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ddr3_odt_gen.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_lpddr2_addr_cmd.v"                                                  
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_odt_gen.v"                                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdwr_data_tmg.v"                                                    
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_arbiter.v"                                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_gen.v"                                                        
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_cmd_gen.v"                                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_csr.v"                                                              
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer.v"                                                           
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_buffer_manager.v"                                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_burst_tracking.v"                                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_dataid_manager.v"                                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_fifo.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_list.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rdata_path.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_wdata_path.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder.v"                                                      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_32_syn.v"                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_decoder_64_syn.v"                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder.v"                                                      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_32_syn.v"                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_64_syn.v"                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v"                                      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_axi_st_converter.v"                                                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_input_if.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_rank_timer.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_sideband.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_tbp.v"                                                              
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_timing_param.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_ddrx_controller_st_top.v"                                                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS -incdir "$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/alt_mem_if_nextgen_ddr3_controller_core.sv"                                      
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                              
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/driver_definitions.sv"                                                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/addr_gen.sv"                                                                     
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/burst_boundary_addr_gen.sv"                                                      
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/lfsr.sv"                                                                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/lfsr_wrapper.sv"                                                                 
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rand_addr_gen.sv"                                                                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rand_burstcount_gen.sv"                                                          
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rand_num_gen.sv"                                                                 
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rand_seq_addr_gen.sv"                                                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/reset_sync.v"                                                                    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/scfifo_wrapper.sv"                                                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/seq_addr_gen.sv"                                                                 
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/template_addr_gen.sv"                                                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/template_stage.sv"                                                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/driver_csr.sv"                                                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/avalon_traffic_gen_avl_use_be_avl_use_burstbegin.sv"                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/block_rw_stage_avl_use_be_avl_use_burstbegin.sv"                                 
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/driver_avl_use_be_avl_use_burstbegin.sv"                                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/driver_fsm_avl_use_be_avl_use_burstbegin.sv"                                     
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/read_compare_avl_use_be_avl_use_burstbegin.sv"                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/single_rw_stage_avl_use_be_avl_use_burstbegin.sv"                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_c0.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_rst.sv"                                                  
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                                     
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                              
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                                    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0.v"                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_avalon_st_adapter.v"                 
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_cmd_demux.sv"                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_cmd_mux.sv"                          
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_router.sv"                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_router_001.sv"                       
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_rsp_demux.sv"                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_s0_mm_interconnect_0_rsp_mux.sv"                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ac_ROM_reg.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_bitcheck.v"                                                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rw_manager_core.sv"                                                              
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_datamux.v"                                                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_data_broadcast.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_data_decoder.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ddr3.v"                                                               
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_di_buffer.v"                                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_di_buffer_wrap.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_dm_decoder.v"                                                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/rw_manager_generic.sv"                                                           
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_inst_ROM_reg.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_jumplogic.v"                                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr12.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr36.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_lfsr72.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_pattern_fifo.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ram.v"                                                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_ram_csr.v"                                                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_read_datapath.v"                                                      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_write_decoder.v"                                                      
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/sequencer_m10.sv"                                                                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/sequencer_phy_mgr.sv"                                                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/sequencer_pll_mgr.sv"                                                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_m10_ac_ROM.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/rw_manager_m10_inst_ROM.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/afi_mux_ddr3_ddrx.v"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_clock_pair_generator.v"                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_read_valid_selector.v"                                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_addr_cmd_datapath.v"                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_reset_m10.v"                                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_memphy_m10.sv"                                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_dqdqs_pads_m10.sv"                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_reset_sync.v"                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_fr_cycle_shifter.v"                                    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_read_datapath_m10.sv"                                  
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_write_datapath_m10.v"                                  
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_simple_ddio_out_m10.sv"                                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/max10emif_dcfifo.sv"                                                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_iss_probe.v"                                           
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_addr_cmd_pads_m10.v"                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0_flop_mem.v"                                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_p0.sv"                                                    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_gpio_lite.sv"                                                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0_pll0.sv"                                                  
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_mm_interconnect_0.v"                                          
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_d0.v"                                                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0_if0.v"                                                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/alt_mem_if_ddr3_mem_model_top_ddr3_max10_mem_if_dm_pins_en_mem_if_dqsn_en.sv"    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/alt_mem_if_common_ddr_mem_model_ddr3_max10_mem_if_dm_pins_en_mem_if_dqsn_en.sv"  
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_mem_if_checker_no_ifdef_params.sv"                                        
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/submodules/ddr_example_sim_e0.v"                                                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS                                    "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS                                        "$QSYS_SIMDIR/ddr_example_sim.v"                                                                          
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  export GENERIC_PARAM_COMPAT_CHECK=1
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi

