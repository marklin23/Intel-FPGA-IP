
/*
i2c_slave_t_top#(
   .slave_addr ()
)i2c_slave_t_top_inst(
   .iRstn (rRstn),
   .iClk   (),
   .SCL   (),
   .SDA   ()

);

*/
module i2c_slave_t_top#(
  parameter slave_addr = 7'h08,
  parameter tx_data    = 8'h23,
  parameter write_num  = 1,
  parameter read_num   = 1
)(
	input  iRstn, iClk,
	// I2C_Interface for test bench
	input  SCL,
	inout  SDA
   
);

wire       wSDAoe           ;
wire [7:0] wvTxData         ;
wire [6:0] wvRxAddr         ;
wire [7:0] wvRxData         ;
wire [7:0] wvRxOffset       ;
wire       wWriteEn         ;
wire       wReadEn          ;
wire [3:0] wvSCLCnt         ;
wire [3:0] wvState          ;

IIC_Decoder #(
   .WRITE_BYTE    ( write_num ),
   .READ_BYTE     ( read_num  ),
   .WATCHDOG_TIME ( 131000    )    //unit us  
   
)IIC_Decoder_INST(
	.iRstn      ( iRstn      ),
   .iClk       ( iClk       ),
   .iFlag      ( 1'b1       ),
   .iWDTEn     ( 1'b0       ), 
	.iSCL       ( SCL        ),
	.iSDA       ( iSDA       ),
	.oSDAoe     ( wSDAoe     ),
	.ivIICADDR  ( slave_addr ),
	.ivTxData   ( tx_data    ),
	.ovRxAddr   ( wvRxAddr   ),
	.ovRxData   ( wvRxData   ),
	.ovRxOffset ( wvRxOffset ),
	.oWriteEn   ( wWriteEn   ),
	.oReadEn    ( wReadEn    ),
	.ovSCLCnt   ( wvSCLCnt   ),
	.ovState    ( wvState    )
);


// I2C_Interface for test bench
assign	SDA  = (!wSDAoe)	?	1'b0	:	1'bz;
//assign	SCL  = (!oSCLOE)	?	1'b0	:	1'bz;
assign	iSDA = SDA;


endmodule