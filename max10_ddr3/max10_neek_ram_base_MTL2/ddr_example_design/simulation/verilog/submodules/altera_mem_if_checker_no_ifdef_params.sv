// (C) 2001-2016 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



`timescale 1 ps / 1 ps

module altera_mem_if_checker_no_ifdef_params (
	input wire clk,
	input wire reset_n,
	input wire test_complete,
	input wire test_complete_1,
	input wire test_complete_2,
	input wire test_complete_3,
	input wire test_complete_4,
	input wire test_complete_5,
	input wire test_complete_6,
	input wire test_complete_7,
	input wire test_complete_8,
	input wire test_complete_9,
	input wire test_complete_10,
	input wire test_complete_11,
	input wire fail,
	input wire fail_1,
	input wire fail_2,
	input wire fail_3,
	input wire fail_4,
	input wire fail_5,
	input wire fail_6,
	input wire fail_7,
	input wire fail_8,
	input wire fail_9,
	input wire fail_10,
	input wire fail_11,
	input wire pass,
	input wire pass_1,
	input wire pass_2,
	input wire pass_3,
	input wire pass_4,
	input wire pass_5,
	input wire pass_6,
	input wire pass_7,
	input wire pass_8,
	input wire pass_9,
	input wire pass_10,
	input wire pass_11,
	input wire local_init_done,
	input wire local_init_done_1,
	input wire local_init_done_2,
	input wire local_init_done_3,
	input wire local_init_done_4,
	input wire local_init_done_5,
	input wire local_init_done_6,
	input wire local_init_done_7,
	input wire local_init_done_8,
	input wire local_init_done_9,
	input wire local_init_done_10,
	input wire local_init_done_11,
	input wire local_cal_success,
	input wire local_cal_success_1,
	input wire local_cal_success_2,
	input wire local_cal_success_3,
	input wire local_cal_success_4,
	input wire local_cal_success_5,
	input wire local_cal_success_6,
	input wire local_cal_success_7,
	input wire local_cal_success_8,
	input wire local_cal_success_9,
	input wire local_cal_success_10,
	input wire local_cal_success_11,
	input wire local_cal_fail,
	input wire local_cal_fail_1,
	input wire local_cal_fail_2,
	input wire local_cal_fail_3,
	input wire local_cal_fail_4,
	input wire local_cal_fail_5,
	input wire local_cal_fail_6,
	input wire local_cal_fail_7,
	input wire local_cal_fail_8,
	input wire local_cal_fail_9,
	input wire local_cal_fail_10,
	input wire local_cal_fail_11);

parameter ENABLE_VCDPLUS = 0;
parameter CONTINUE_AFTER_CAL_FAIL = 0;

reg				afi_cal_success_reported;
reg            afi_cal_fail_reported;

//synthesis translate_off

initial begin
	afi_cal_success_reported <= 0;
	afi_cal_fail_reported <= 0;
end

wire test_complete_total = &({test_complete, test_complete_1, test_complete_2, test_complete_3, test_complete_4, test_complete_5, test_complete_6, test_complete_7, test_complete_8, test_complete_9, test_complete_10, test_complete_11});
wire pass_total = &({pass, pass_1, pass_2, pass_3, pass_4, pass_5, pass_6, pass_7, pass_8, pass_9, pass_10, pass_11});
wire local_cal_fail_total = |({local_cal_fail, local_cal_fail_1, local_cal_fail_2, local_cal_fail_3, local_cal_fail_4, local_cal_fail_5, local_cal_fail_6, local_cal_fail_7, local_cal_fail_8, local_cal_fail_9, local_cal_fail_10, local_cal_fail_11});
wire local_cal_success_total = &({local_cal_success, local_cal_success_1, local_cal_success_2, local_cal_success_3, local_cal_success_4, local_cal_success_5, local_cal_success_6, local_cal_success_7, local_cal_success_8, local_cal_success_9, local_cal_success_10, local_cal_success_11});

always @(posedge test_complete_total)
begin
	@(posedge clk);
	if (pass_total)
	begin
		$display("          --- SIMULATION PASSED --- ");
		$finish;
	end
	else
	begin
		$display("          --- SIMULATION FAILED --- ");
		$finish;
	end
end

always @(posedge clk) begin
	if (local_cal_fail_total)
		begin
         if (!afi_cal_fail_reported) begin
            afi_cal_fail_reported <= 1'b1;
            $display("          --- CALIBRATION FAILED --- ");
         end
         if (!CONTINUE_AFTER_CAL_FAIL) begin
			   $display("          --- SIMULATION FAILED --- ");
			   $finish;
         end
		end
	if (local_cal_success_total)
		if (!afi_cal_success_reported) begin
			afi_cal_success_reported <= 1'b1;
			$display("          --- CALIBRATION PASSED --- ");
		end
	end
		

//synthesis translate_on

endmodule
