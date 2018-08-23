onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/pll_ref_clk_clk_clk
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/global_reset_reset_reset
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_afi_clk_clk
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_afi_reset_reset
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_drv_status_fail
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_drv_status_pass
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_drv_status_test_complete
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_emif_status_local_cal_fail
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_emif_status_local_init_done
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_emif_status_local_cal_success
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_cas_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_reset_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_ba
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_we_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_dm
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_ras_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_ck
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_ck_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_cs_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_a
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_dq
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_dqs
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_dqs_n
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_odt
add wave -noupdate -expand -group tb_top -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0_memory_mem_cke
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_ready
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_read_req
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_burstbegin
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_addr
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_size
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_be
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_wdata
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_rdata_valid
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_rdata
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/pass
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/fail
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/test_complete
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/pnf_per_bit
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/pnf_per_bit_persist
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_address
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_write
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_writedata
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_be
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_read
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_readdata
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/csr_waitrequest
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/resync_reset_n
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/do_write
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/do_read
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/can_write
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/can_read
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/timeout
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/loop_counter
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/loop_counter_persist
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_select
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_enable
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_ready
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_addr
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_burstcount
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_fifo_write_req
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_fifo_read_req
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_fifo_addr
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_fifo_burstcount
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/traffic_gen_ready
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_fifo_full
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_fifo_empty
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_addr
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_burstcount
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/wdata_req
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/wdata
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/be
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo_empty
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_rdata_valid_delay
add wave -noupdate -group traffic_gen -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avl_rdata_delay
add wave -noupdate -expand -group traffic_component -divider ureset_driver_clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/ureset_driver_clk/reset_n
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/ureset_driver_clk/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/ureset_driver_clk/reset_n_sync
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/ureset_driver_clk/reset_reg
add wave -noupdate -expand -group traffic_component -divider addr_gen_inst
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/reset_n
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/enable
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/seq_addr_gen_enable
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/seq_addr_gen_ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/seq_addr_gen_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/seq_addr_gen_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_addr_gen_enable
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_addr_gen_ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_addr_gen_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_addr_gen_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_seq_addr_gen_enable
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_seq_addr_gen_ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_seq_addr_gen_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/rand_seq_addr_gen_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/template_addr_gen_enable
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/template_addr_gen_ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/template_addr_gen_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/template_addr_gen_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/addr_no_id
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_gen_inst/word_addr
add wave -noupdate -expand -group traffic_component -divider data_gen_inst
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/data_gen_inst/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/data_gen_inst/reset_n
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/data_gen_inst/data
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/data_gen_inst/lfsr_data
add wave -noupdate -expand -group traffic_component -divider addr_burstcount_fifo
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/reset_n
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/read_req
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/data_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/data_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/full
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/empty
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/data_in_wire
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/write_req_wire
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/almost_full
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/addr_burstcount_fifo/total_full
add wave -noupdate -expand -group traffic_component -divider avalon_burst_interface
add wave -noupdate -expand -group traffic_component -divider avalon_traffic_gen
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/reset_n
add wave -noupdate -expand -group traffic_component -radix binary -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_be
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_burstbegin
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_size
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_write_req
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_wdata
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_read_req
add wave -noupdate -expand -group traffic_component -radixshowbase 1 /ddr_example_sim/e0/d0/avl_rdata
add wave -noupdate -expand -group traffic_component -radixshowbase 1 /ddr_example_sim/e0/d0/avl_rdata_valid
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/avl_ready
add wave -noupdate -expand -group traffic_component -divider end
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/do_write
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/do_read
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/write_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/write_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/wdata
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/be
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/read_addr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/read_burstcount
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/ready
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/wdata_req
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/state
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/do_write_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/do_read_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/write_addr_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/write_burstcount_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/read_addr_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/read_burstcount_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/last_write_addr_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/last_write_burstcount_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/burst_counter
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_full
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_empty
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/can_issue_avl_cmd
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_write_req_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_read_req_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_burstbegin_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_addr_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_size_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_wdata_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_be_in
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_write_req_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_read_req_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_burstbegin_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_addr_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_size_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_wdata_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/fifo_be_out
add wave -noupdate -expand -group traffic_component -divider read_compare
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/clk
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/reset_n
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/wdata_req
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/wdata
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/be
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/rdata_valid
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/rdata
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/read_compare_fifo_full
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/read_compare_fifo_empty
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/pnf_per_bit
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_data
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_data_fifo_out
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/rdata_valid_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/rdata_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/wdata_req_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/wdata_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/be_reg
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/data_counter
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/force_error
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_be
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/rdata_rr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_data_rr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_be_full_rr
add wave -noupdate -expand -group traffic_component -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/read_compare_inst/written_be_full
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/pll_ref_clk
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/global_reset_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/soft_reset_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/afi_clk
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/afi_half_clk
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/afi_reset_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_a
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_ba
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_ck
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_ck_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_cke
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_cs_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_dm
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_ras_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_cas_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_we_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_reset_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_dq
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_dqs
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_dqs_n
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mem_odt
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/local_init_done
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/local_cal_success
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/local_cal_fail
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/drv_status_pass
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/drv_status_fail
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/drv_status_test_complete
add wave -noupdate -expand -group e0 -divider avalon_burst_interface
add wave -noupdate -expand -group e0 -divider avalon_traffic_gen
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/reset_n
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_be
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/clk
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_addr
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_burstbegin
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_size
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_write_req
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_wdata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/traffic_generator_0/avalon_traffic_gen_inst/avl_read_req
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/avl_rdata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/avl_rdata_valid
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0/avl_ready
add wave -noupdate -expand -group e0 -divider end
add wave -noupdate -expand -group e0 -divider avl_m
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_beginbursttransfer
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_waitrequest
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_readdata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_address
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_read
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_byteenable
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_readdatavalid
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_writedata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_write
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/d0_avl_burstcount
add wave -noupdate -expand -group e0 -divider alv_if
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_beginbursttransfer
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_readdata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_waitrequest
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_address
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_read
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_byteenable
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_readdatavalid
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_write
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_writedata
add wave -noupdate -expand -group e0 -color Gold -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/mm_interconnect_0_if0_avl_burstcount
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/rst_controller_reset_out_reset
add wave -noupdate -expand -group e0 -radix hexadecimal -radixshowbase 1 /ddr_example_sim/e0/rst_controller_001_reset_out_reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {352109 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 502
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {328788 ps} {382058 ps}
