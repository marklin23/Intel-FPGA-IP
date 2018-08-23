//altiobuf_out CBX_AUTO_BLACKBOX="ALL" CBX_SINGLE_OUTPUT_FILE="ON" DEVICE_FAMILY="MAX 10" ENABLE_BUS_HOLD="FALSE" NUMBER_OF_CHANNELS=1 OPEN_DRAIN_OUTPUT="FALSE" PSEUDO_DIFFERENTIAL_MODE="TRUE" USE_DIFFERENTIAL_MODE="TRUE" USE_OE="FALSE" USE_OUT_DYNAMIC_DELAY_CHAIN1="FALSE" USE_OUT_DYNAMIC_DELAY_CHAIN2="FALSE" USE_TERMINATION_CONTROL="FALSE" datain dataout dataout_b
//VERSION_BEGIN 16.1 cbx_altiobuf_out 2016:10:24:15:04:16:SJ cbx_mgl 2016:10:24:15:05:03:SJ cbx_stratixiii 2016:10:24:15:04:16:SJ cbx_stratixv 2016:10:24:15:04:16:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2016  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel MegaCore Function License Agreement, or other 
//  applicable license agreement, including, without limitation, 
//  that your use is for the sole purpose of programming logic 
//  devices manufactured by Intel and sold by Intel or its 
//  authorized distributors.  Please refer to the applicable 
//  agreement for further details.



//synthesis_resources = fiftyfivenm_io_obuf 2 fiftyfivenm_pseudo_diff_out 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  ddr_example_sim_e0_if0_p0_clock_pair_generator
	( 
	datain,
	dataout,
	dataout_b) /* synthesis synthesis_clearbox=1 */;
	input   [0:0]  datain;
	output   [0:0]  dataout;
	output   [0:0]  dataout_b;

	wire  [0:0]   wire_obuf_ba_o;
	wire  [0:0]   wire_obufa_o;
	wire  [0:0]   wire_pseudo_diffa_o;
	wire  [0:0]   wire_pseudo_diffa_obar;
	wire [0:0]  oe_b;
	wire  [0:0]  oe_w;

	fiftyfivenm_io_obuf   obuf_ba_0
	( 
	.i(wire_pseudo_diffa_obar),
	.o(wire_obuf_ba_o[0:0]),
	.obar(),
	.oe(oe_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obuf_ba_0.bus_hold = "false",
		obuf_ba_0.open_drain_output = "false",
		obuf_ba_0.lpm_type = "fiftyfivenm_io_obuf";
	fiftyfivenm_io_obuf   obufa_0
	( 
	.i(wire_pseudo_diffa_o),
	.o(wire_obufa_o[0:0]),
	.obar(),
	.oe(oe_w)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_0.bus_hold = "false",
		obufa_0.open_drain_output = "false",
		obufa_0.lpm_type = "fiftyfivenm_io_obuf";
	fiftyfivenm_pseudo_diff_out   pseudo_diffa_0
	( 
	.i(datain),
	.o(wire_pseudo_diffa_o[0:0]),
	.obar(wire_pseudo_diffa_obar[0:0]));
	assign
		dataout = wire_obufa_o,
		dataout_b = wire_obuf_ba_o,
		oe_b = 1'b1,
		oe_w = 1'b1;
endmodule //ddr_example_sim_e0_if0_p0_clock_pair_generator
//VALID FILE
