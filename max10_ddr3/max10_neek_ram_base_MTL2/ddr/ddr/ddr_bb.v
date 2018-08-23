
module ddr (
	clk_clk,
	mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk,
	mem_if_ddr3_emif_0_pll_sharing_pll_write_clk,
	mem_if_ddr3_emif_0_pll_sharing_pll_locked,
	mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk,
	mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk,
	mem_if_ddr3_emif_0_status_local_init_done,
	mem_if_ddr3_emif_0_status_local_cal_success,
	mem_if_ddr3_emif_0_status_local_cal_fail,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_dm,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	mm_bridge_0_s0_waitrequest,
	mm_bridge_0_s0_readdata,
	mm_bridge_0_s0_readdatavalid,
	mm_bridge_0_s0_burstcount,
	mm_bridge_0_s0_writedata,
	mm_bridge_0_s0_address,
	mm_bridge_0_s0_write,
	mm_bridge_0_s0_read,
	mm_bridge_0_s0_byteenable,
	mm_bridge_0_s0_debugaccess,
	pio_0_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	output		mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk;
	output		mem_if_ddr3_emif_0_pll_sharing_pll_write_clk;
	output		mem_if_ddr3_emif_0_pll_sharing_pll_locked;
	output		mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk;
	output		mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk;
	output		mem_if_ddr3_emif_0_status_local_init_done;
	output		mem_if_ddr3_emif_0_status_local_cal_success;
	output		mem_if_ddr3_emif_0_status_local_cal_fail;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	inout	[0:0]	memory_mem_ck;
	inout	[0:0]	memory_mem_ck_n;
	output	[0:0]	memory_mem_cke;
	output	[0:0]	memory_mem_cs_n;
	output	[2:0]	memory_mem_dm;
	output	[0:0]	memory_mem_ras_n;
	output	[0:0]	memory_mem_cas_n;
	output	[0:0]	memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[23:0]	memory_mem_dq;
	inout	[2:0]	memory_mem_dqs;
	inout	[2:0]	memory_mem_dqs_n;
	output	[0:0]	memory_mem_odt;
	output		mm_bridge_0_s0_waitrequest;
	output	[31:0]	mm_bridge_0_s0_readdata;
	output		mm_bridge_0_s0_readdatavalid;
	input	[0:0]	mm_bridge_0_s0_burstcount;
	input	[31:0]	mm_bridge_0_s0_writedata;
	input	[29:0]	mm_bridge_0_s0_address;
	input		mm_bridge_0_s0_write;
	input		mm_bridge_0_s0_read;
	input	[3:0]	mm_bridge_0_s0_byteenable;
	input		mm_bridge_0_s0_debugaccess;
	output	[7:0]	pio_0_external_connection_export;
	input		reset_reset_n;
endmodule
