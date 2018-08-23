	unnamed u0 (
		.i_avalon_chip_select (<connected-to-i_avalon_chip_select>), // avalon_sdcard_slave.chipselect
		.i_avalon_address     (<connected-to-i_avalon_address>),     //                    .address
		.i_avalon_read        (<connected-to-i_avalon_read>),        //                    .read
		.i_avalon_write       (<connected-to-i_avalon_write>),       //                    .write
		.i_avalon_byteenable  (<connected-to-i_avalon_byteenable>),  //                    .byteenable
		.i_avalon_writedata   (<connected-to-i_avalon_writedata>),   //                    .writedata
		.o_avalon_readdata    (<connected-to-o_avalon_readdata>),    //                    .readdata
		.o_avalon_waitrequest (<connected-to-o_avalon_waitrequest>), //                    .waitrequest
		.i_clock              (<connected-to-i_clock>),              //                 clk.clk
		.i_reset_n            (<connected-to-i_reset_n>),            //               reset.reset_n
		.b_SD_cmd             (<connected-to-b_SD_cmd>),             //         conduit_end.b_SD_cmd
		.b_SD_dat             (<connected-to-b_SD_dat>),             //                    .b_SD_dat
		.b_SD_dat3            (<connected-to-b_SD_dat3>),            //                    .b_SD_dat3
		.o_SD_clock           (<connected-to-o_SD_clock>)            //                    .o_SD_clock
	);

