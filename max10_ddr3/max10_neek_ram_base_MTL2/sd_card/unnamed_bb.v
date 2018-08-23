
module unnamed (
	i_avalon_chip_select,
	i_avalon_address,
	i_avalon_read,
	i_avalon_write,
	i_avalon_byteenable,
	i_avalon_writedata,
	o_avalon_readdata,
	o_avalon_waitrequest,
	i_clock,
	i_reset_n,
	b_SD_cmd,
	b_SD_dat,
	b_SD_dat3,
	o_SD_clock);	

	input		i_avalon_chip_select;
	input	[7:0]	i_avalon_address;
	input		i_avalon_read;
	input		i_avalon_write;
	input	[3:0]	i_avalon_byteenable;
	input	[31:0]	i_avalon_writedata;
	output	[31:0]	o_avalon_readdata;
	output		o_avalon_waitrequest;
	input		i_clock;
	input		i_reset_n;
	inout		b_SD_cmd;
	inout		b_SD_dat;
	inout		b_SD_dat3;
	output		o_SD_clock;
endmodule
