//---------------------------------------------------------------------------------------------------------------
// Title  : intel fpga i2c master control core
// Version: Q16.1 lite
// Author : Mark
// Date   : 2018/08/23
// Note   : 1. Support Burst Read Write
//          2. Support 100k/ 400k I2C Speed Configuration
//          3. Self interrupt handling
//
//
// Info   : Embedded Peripherals IP User Guide ==> page 135 ==> 12. Intel FPGA Avalon I2C (Master) Core
//          https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/ug/ug_embedded_ip.pdf
//---------------------------------------------------------------------------------------------------------------

module i2c_m_ctrl#(

parameter OFFSET_DATA_BYTE = 1,
parameter READ_DATA_BYTE   = 1,
parameter WRITE_DATA_BYTE  = 1
)
(

input       iClk,
input       iRstn,

//input       i2c_scl_in,
//output      i2c_scl_oe,
//input       i2c_sda_in,
//output      i2c_sda_oe,

inout SCL,
inout SDA,

//ctrl sig
input       iEna,
input       iRd_Wrn,
output      oLoadData,
output      oReadValid,
output [8                   :0] ovTfr_state,  
output [8                   :0] ovinit_state,
input  [6                   :0] ivAddress,
input  [8*OFFSET_DATA_BYTE-1:0] ivOffset,
input  [8*WRITE_DATA_BYTE-1 :0] ivTxdata,
output [8*READ_DATA_BYTE-1  :0] ovRxdata

);
//*******************************************
// i2c simulation
wire i2c_scl_in = SCL;
wire i2c_scl_oe;
wire i2c_sda_in = SDA;
wire i2c_sda_oe;

assign SCL = i2c_scl_oe ? 1'b0 : 1'bz;
assign SDA = i2c_sda_oe ? 1'b0 : 1'bz;
//*******************************************




localparam TFR_CMD           =	4'h0;
localparam RX_DATA           =	4'h1;
localparam CTRL              =	4'h2; //Control register
localparam ISER              =	4'h3; //Interrupt status enable register
localparam ISR               =	4'h4; //Interrupt status register
localparam STATUS            =	4'h5; //Status register
localparam TFR_CMD_FIFO_LVL  =	4'h6; //TFR_CMD FIFO level register
localparam RX_DATA_FIFO_LVL  =	4'h7; //RX_DATA FIFO level register
localparam SCL_LOW           =	4'h8; //SCL low count register
localparam SCL_HIGH          =	4'h9; //SCL high count register
localparam SDA_HOLD          =	4'hA; //SDA hold count register
 

function integer logb2 ( input integer size );
	integer size_buf;
	begin
		size_buf = size;
		for(logb2=-1; size_buf>0; logb2=logb2+1) size_buf = size_buf >> 1;
	end
endfunction

   
reg  [logb2(READ_DATA_BYTE)  : 0] rvReadDataCount;
reg  [logb2(WRITE_DATA_BYTE) : 0] rvWriteDataCount;
	
//avst      
reg  [3 :0] i2c_0_csr_address;        
       
reg         i2c_0_csr_read;            
reg         i2c_0_csr_write;        
reg  [31:0] i2c_0_csr_writedata;       
wire [31:0]	i2c_0_csr_readdata;        
wire        i2c_0_i2c_serial_sda_in;   
wire        i2c_0_i2c_serial_scl_in;   
wire        i2c_0_i2c_serial_sda_oe;   
wire        i2c_0_i2c_serial_scl_oe;   
wire        i2c_0_interrupt_sender_irq;

wire [7:0]  i2c_0_rx_data_source_data;
wire        i2c_0_rx_data_source_valid;
reg         i2c_0_rx_data_source_ready;
reg [15:0]  i2c_0_transfer_command_sink_data;
reg         i2c_0_transfer_command_sink_valid;
wire        i2c_0_transfer_command_sink_ready;


//avmm
wire        i2c_1_i2c_serial_sda_in;
wire        i2c_1_i2c_serial_scl_in;
wire        i2c_1_i2c_serial_sda_oe;
wire        i2c_1_i2c_serial_scl_oe;
wire        i2c_1_interrupt_sender_irq;
reg [3:0]   rvi2c_csr_address;
reg         rvi2c_csr_read;
reg         rvi2c_csr_read1;
reg         rvi2c_csr_read2;
reg         rvi2c_csr_write;
reg [31:0]  rvi2c_csr_writedata; 
wire [31:0]	wvi2c_csr_readdata;
reg [31:0]  rvi2c_csr_readdata1;
reg [31:0]  rvi2c_csr_readdata2;


	i2c_master u0 (
		.clk_clk                    ( iClk ),//                    clk.clk
		.i2c_1_csr_address          ( rvi2c_csr_address ),//              i2c_1_csr.address
		.i2c_1_csr_read             ( rvi2c_csr_read ),//                       .read
		.i2c_1_csr_write            ( rvi2c_csr_write ),//                       .write
		.i2c_1_csr_writedata        ( rvi2c_csr_writedata ),//                       .writedata
		.i2c_1_csr_readdata         ( wvi2c_csr_readdata ),//                       .readdata
		.i2c_1_i2c_serial_sda_in    ( i2c_sda_in ),//       i2c_1_i2c_serial.sda_in
		.i2c_1_i2c_serial_scl_in    ( i2c_scl_in ),//                       .scl_in
		.i2c_1_i2c_serial_sda_oe    ( i2c_sda_oe ),//                       .sda_oe
		.i2c_1_i2c_serial_scl_oe    ( i2c_scl_oe ),//                       .scl_oe
		.i2c_1_interrupt_sender_irq ( i2c_1_interrupt_sender_irq ),// i2c_1_interrupt_sender.irq
		.reset_reset_n              ( iRstn) //                  reset.reset_n
	);


//i2c_m avst (
//		.clk_clk                              ( iClk                              ),                           
//		.reset_reset_n                        ( iRstn                             ),
////avmm
//		.i2c_1_i2c_serial_sda_in              ( i2c_sda_in                        ),
//		.i2c_1_i2c_serial_scl_in              ( i2c_scl_in                        ),
//		.i2c_1_i2c_serial_sda_oe              ( i2c_sda_oe                        ),
//		.i2c_1_i2c_serial_scl_oe              ( i2c_scl_oe                        ),
//		.i2c_1_interrupt_sender_irq           ( i2c_1_interrupt_sender_irq        ),
//		.i2c_1_csr_address                    ( rvi2c_csr_address                 ),
//		.i2c_1_csr_read                       ( rvi2c_csr_read                    ),
//		.i2c_1_csr_write                      ( rvi2c_csr_write                   ),
//		.i2c_1_csr_writedata                  ( rvi2c_csr_writedata               ),
//		.i2c_1_csr_readdata                   ( wvi2c_csr_readdata                )
//	); 


//reg	[3:0]		i2c_1_csr_address;
//reg				i2c_1_csr_read;
//reg				i2c_1_csr_write;
//reg	[31:0]	i2c_1_csr_writedata;	

localparam IDLE_INIT     = 0, S0_INIT         = 1, S1_INIT         = 2, S2_INIT                 = 3 , S3_INIT              = 4 ,S4_INIT   = 5 , S5_INIT = 6 , S6_INIT_DONE = 7 ;
localparam IDLE_TFR      = 0, ST_TFR_ADDR_W   = 1, ST_TFR_OFFSET_W = 2, ST_TFR_DATA_W           = 3 , ST_TFR_LOAD          = 10 ;
localparam ST_TFR_ADDR_R = 4, ST_TFR_OFFSET_R = 5, ST_TFR_DATA_R   = 6, ST_TFR_DATA_LAST_BYTE_R = 7 , ST_TFR_RX_DATA_LATCH = 8 ,ST_CLEAR_IRQ= 9;

reg [8 :0] rvinit_state;
reg [8 :0] rvtfr_state;
reg        rinit_done;
reg [10:0] rvcnt;
reg        rvtxready;
reg        rtfr_flag;
reg        rEnaFlag;
reg        rReadValid;
reg [8*READ_DATA_BYTE-1  :0] rvRxdata;
reg [3 :0] rvReadCnt;
reg [7 :0] rvTxDataBuf;
reg [7 :0] rvDataCnt;
wire[8*WRITE_DATA_BYTE-1 :0] wvLoadData; 

always@(posedge iClk)	
	
	if(!iRstn)
		begin
			rvi2c_csr_address     <= 4'b0;
			rvi2c_csr_read        <= 1'b0;
			rvi2c_csr_write       <= 1'b0;
			rvi2c_csr_writedata   <= 32'b0;
			rvinit_state          <= IDLE_INIT;
			rvtfr_state           <= IDLE_TFR;
			rinit_done            <= 1'b0;
			rvtxready             <= 1'b0;
			rvcnt                 <= 11'b0;
			rtfr_flag             <= 1'b1;
         rvReadDataCount       <= 0;
         rvWriteDataCount      <= 0;
         rReadValid            <= 1'b0;
         rvRxdata              <= {8*READ_DATA_BYTE{1'b0}};
         rvReadCnt             <= 0;
         rvTxDataBuf           <= 8'h0;
         //rvDataCnt             <= WRITE_DATA_BYTE;
		end
   else if ((rvinit_state==S6_INIT_DONE)&& (~rEnaFlag & iEna ))
         rvtfr_state           <= ST_TFR_ADDR_W;
	else
		begin
//=====================================================================
//  INIT STATE
//=====================================================================
		
			case (rvinit_state)
			
				IDLE_INIT:
						begin	
							rvcnt                <= (rvcnt==1023)	?	0       :	rvcnt	+	1;
							rvinit_state         <= (rvcnt==1023)	?  S0_INIT	:	IDLE_INIT;
						end
						
				S0_INIT:
						begin											//Disable Altera Avalon I2C (Master) core through CTRL register	
							rvi2c_csr_address    <=	CTRL;
							rvi2c_csr_writedata  <= 32'h00;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S1_INIT;
						end
						
				S1_INIT:
						begin										  //Configure ISER, SCL_LOW,SCL_HIGH, SDA_HOLD register
							rvi2c_csr_address    <=	ISER;   // set irq NACK NACK_DET & ARBLOST_DET
							rvi2c_csr_writedata  <= 32'h0C; //32'h00;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S2_INIT;
						end
						
				S2_INIT:
						begin												//SCL_LOW
							rvi2c_csr_address    <=	SCL_LOW;
							rvi2c_csr_writedata  <= 32'hFA;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S3_INIT;
						end
						
				S3_INIT:
						begin												//SCL_HIGH	
							rvi2c_csr_address    <=	SCL_HIGH;
							rvi2c_csr_writedata  <= 32'hF9;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S4_INIT;
						end
						
				S4_INIT:
						begin												//SDA_HOLD
							rvi2c_csr_address    <=	SDA_HOLD;
							rvi2c_csr_writedata  <= 32'h7E;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S5_INIT;
						end		
						
				S5_INIT:
						begin												//Configure control bits and enable the Altera Avalon I2C (Master) core through CTRL register
							rvi2c_csr_address    <=	CTRL;
							rvi2c_csr_writedata  <= 32'h01;
							rvi2c_csr_read       <=	1'b0;
							rvi2c_csr_write      <=	1'b1;
							rvinit_state         <= S6_INIT_DONE;
						end
						
				S6_INIT_DONE:
						begin
							rinit_done           <= 1'b1;
							rvinit_state         <= S6_INIT_DONE;

                     //==================================================
                     //  TFR STATE
                     //==================================================
                             case (rvtfr_state)
                                 IDLE_TFR:
                                       begin	
                                          rvtfr_state         <=  (i2c_1_interrupt_sender_irq) ? ST_CLEAR_IRQ  :
                                                                  ((~rEnaFlag & iEna ))        ? ST_TFR_ADDR_W : IDLE_TFR;
                                          rvi2c_csr_address   <= 0;
                                          rtfr_flag           <= 1'b1;
                                          rvi2c_csr_writedata <= 32'h0;
                                          rvi2c_csr_read      <= 0;
                                          rvi2c_csr_write     <= 1'b0;
                                          rvWriteDataCount    <= 0;
                                          rvReadDataCount     <= 0;
                                          rvcnt               <= 0;
                                          rReadValid          <= 0;
                                          rvRxdata            <= rvRxdata;
                                          rvReadCnt           <= 0;
                                          rvTxDataBuf         <= 8'h0;
                                          //rvDataCnt           <= WRITE_DATA_BYTE;
                                       end
                                  ST_CLEAR_IRQ:
                                       begin	
                                          rvtfr_state         <= (rvcnt==5) ? IDLE_TFR : rvtfr_state;
                                          rvi2c_csr_address   <= ISR;
                                          rtfr_flag           <= 1'b1;
                                          rvi2c_csr_writedata <= 32'h1C;  // write 1 to clear IRQ ==> bit 4,3,2  RX_OVER   ARBLOST_DET NACK_DET
                                          rvi2c_csr_read      <= 1'b0;
                                          rvi2c_csr_write     <= (rvcnt==2) ? 1'b1     : 1'b0;
                                          rvWriteDataCount    <= 0;                    
                                          rvReadDataCount     <= 0;                    
                                          rvcnt               <= (rvcnt==5) ? 0        : rvcnt + 1;
                                          rReadValid          <= 0;
                                          rvRxdata            <= rvRxdata;
                                          rvReadCnt           <= 0;
                                          rvTxDataBuf         <= 8'h0;
                                          //rvDataCnt           <= WRITE_DATA_BYTE;
                                       end     

                                 ST_TFR_ADDR_W:
                                       begin							
                                          rvtxready 						<= 1'b0;
                                          if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= {24'h0,ivAddress[6:0],1'b0};//32'h062;
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rtfr_flag					    <= 1'b0;
                                                rvcnt                       <= 1'b0;
                                                rvtfr_state					    <= rvtfr_state;
                                                
                                             end
                                          else
                                             begin
                                                
                                                if(rvi2c_csr_read1 && (wvi2c_csr_readdata[0]==1'b1))
                                                   begin
                                                      rvtfr_state         <= ST_TFR_OFFSET_W;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= 1'b1;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      //rvcnt               <= (rvcnt==1023) ? 0 : rvcnt + 1;
                                                   end
                                                   
                                             end							
                                       end
                                 ST_TFR_OFFSET_W:
                                       begin							
                                          if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= ivOffset;
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rvtxready                   <= 1'b0;
                                                rtfr_flag                   <= 1'b0;
                                             
                                             end
                                          else
                                             begin
                                                
                                                if(rvi2c_csr_read1 && (wvi2c_csr_readdata[0]==1'b1))
                                                   begin
                                                      rvtfr_state         <= (iRd_Wrn) ? ST_TFR_ADDR_R : ST_TFR_LOAD ;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                              
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= 1'b1;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      //rvcnt               <= (rvcnt==1023) ? 0 : rvcnt + 1;
                                                   end
                                                   
                                             end
                                       end	
                                 ST_TFR_LOAD: 
                                       begin
                                          rvi2c_csr_address           <= 0;
                                          rvi2c_csr_writedata         <= 0;
                                          rvi2c_csr_read              <= 1'b0;
                                          rvi2c_csr_write             <= 1'b0;
                                          rvtxready                   <= 1'b0;
                                          rtfr_flag                   <= 1'b1;
                                          rvReadDataCount             <= 0;
                                          rvtfr_state                 <= ST_TFR_DATA_W; 
                                          rvTxDataBuf                 <= wvLoadData[7:0];
                                          rvWriteDataCount            <=( rvWriteDataCount == WRITE_DATA_BYTE ) ? rvWriteDataCount : (rvWriteDataCount + 1);
                                          //rvDataCnt                   <= WRITE_DATA_BYTE;
                                       end


                                       
                                 ST_TFR_DATA_W:
                                       begin							
                                          if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= {22'd0, 1'b0, (rvWriteDataCount == WRITE_DATA_BYTE ) ,rvTxDataBuf[7:0]};
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rvtxready                   <= 1'b0;
                                                rtfr_flag                   <= 1'b0;
                                                rvReadDataCount             <= 0;
                                                rvTxDataBuf                 <= rvTxDataBuf;
                                                rvWriteDataCount            <= rvWriteDataCount;
                                             end
                                          else
                                             begin
                                                if(rvi2c_csr_read1 && ((|wvi2c_csr_readdata[3:2]))) // NACK NACK_DET & ARBLOST_DET
                                                   begin  
                                                      rvtfr_state         <= IDLE_TFR;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvWriteDataCount    <= 0;
                                                   end
                                                else if(rvi2c_csr_read1 && (wvi2c_csr_readdata[0]==1'b1))
                                                   begin
                                                      rvtfr_state         <= (rvWriteDataCount < WRITE_DATA_BYTE) ? ST_TFR_LOAD : IDLE_TFR;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvWriteDataCount    <= rvWriteDataCount;
                              
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= 1'b1;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      rvWriteDataCount    <= rvWriteDataCount;
                                                      //rvcnt               <= (rvcnt==1023) ? 0 : rvcnt + 1;
                                                   end
                                                   
                                             end												
                                       end
                                    //=====================================================================
                                    //  Read 1 byte Operation
                                    //=====================================================================	
                                       
                                 ST_TFR_ADDR_R:
                                       begin							
                                          if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= {22'h0,2'b10,ivAddress[6:0],1'b1};//32'h263;
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rvtxready                   <= 1'b0;
                                                rtfr_flag                   <= 1'b0;
                                             end
                                          else
                                             begin
                                                
                                                if(rvi2c_csr_read1 && (wvi2c_csr_readdata[0]==1'b1))
                                                   begin
                                                      rvtfr_state         <= (READ_DATA_BYTE <= 1) ? ST_TFR_DATA_LAST_BYTE_R : ST_TFR_DATA_R;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                              
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= 1'b1;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      //rvcnt               <= (rvcnt==1023) ? 0 : rvcnt + 1;
                                                   end
                                                   
                                             end												
                                       end
                                 ST_TFR_DATA_R:
                                       begin							
                                          if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= 32'h000;
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rvtxready                   <= 1'b0;
                                                rtfr_flag                   <= 1'b0;
                                                rReadValid                  <= 1'b0;
                                                rvReadCnt                   <= 0;
                                                rvcnt                       <= 0;
                                                rvReadDataCount             <= rvReadDataCount;
                                             end
                                          else
                                             begin
                                               if((rvcnt==4) && ((|wvi2c_csr_readdata[3:2]) && (rvi2c_csr_address ==ISR ))) // NACK NACK_DET & ARBLOST_DET
                                                   begin  
                                                      rvtfr_state         <= IDLE_TFR;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvWriteDataCount    <= 0;
                                                      rvReadDataCount     <= 0;
                                                      rvcnt               <= 1'b0;
                                                   end
                                                else if((rvcnt==4) && (wvi2c_csr_readdata[1]==1'b1))
                                                   begin
                                                      rvtfr_state         <= ST_TFR_RX_DATA_LATCH;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvReadDataCount     <= rvReadDataCount +1;
                                                      rvcnt               <= 1'b0;
                                                      rvReadCnt           <= 0;
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rtfr_flag           <= 1'b0;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= (rvcnt==1 ) ? 1'b1 : 1'b0;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      rvcnt               <= (rvcnt==10) ? 0    : rvcnt + 1;
                                                      rvReadCnt           <= 0;
                                                      rvReadDataCount     <= rvReadDataCount;
                                                   end
                                             end												
                                       end
                                 

                                 ST_TFR_RX_DATA_LATCH:
                                       begin							

                                          rvtfr_state         <=  ((rvReadDataCount >  READ_DATA_BYTE - 1 ) && (rvReadCnt==6) ) ? IDLE_TFR                : 
                                                                  ((rvReadDataCount == READ_DATA_BYTE - 1 ) && (rvReadCnt==6) ) ? ST_TFR_DATA_LAST_BYTE_R : 
                                                                  ((rvReadDataCount <  READ_DATA_BYTE - 1 ) && (rvReadCnt==6) ) ? ST_TFR_DATA_R           : rvtfr_state;
                                          rtfr_flag           <= 1'b1;
                                          rvi2c_csr_address   <= RX_DATA;
                                          rvi2c_csr_read      <= (rvReadCnt==1 ) ? 1'b1 : 1'b0;
                                          rvi2c_csr_write     <= 1'b0;
                                          rvRxdata            <= (rvReadCnt==4) ? {rvRxdata[8*READ_DATA_BYTE-9:0], wvi2c_csr_readdata[7:0]} : rvRxdata;
                                          rReadValid          <= (rvReadCnt==4);
                                          rvReadCnt           <= (rvReadCnt==6) ? rvReadCnt    : rvReadCnt + 1; 
                                          rvReadDataCount     <= rvReadDataCount;
                                          rvcnt               <= 0;
	
                                       end

                                       
                                 ST_TFR_DATA_LAST_BYTE_R:
                                       begin							
                                           if(rtfr_flag)
                                             begin
                                                rvi2c_csr_address           <= TFR_CMD;
                                                rvi2c_csr_writedata         <= 32'h100;
                                                rvi2c_csr_read              <= 1'b0;
                                                rvi2c_csr_write             <= 1'b1;
                                                rvtxready                   <= 1'b0;
                                                rtfr_flag                   <= 1'b0;
                                                rReadValid                  <= 1'b0;
                                                rvReadCnt                   <= 0;
                                                rvcnt                       <= 0;
                                                rvReadDataCount             <= rvReadDataCount;
                                             end
                                          else
                                             begin
                                               if((rvcnt==4) && ((|wvi2c_csr_readdata[3:2]) && (rvi2c_csr_address ==ISR ))) // NACK NACK_DET & ARBLOST_DET
                                                   begin  
                                                      rvtfr_state         <= IDLE_TFR;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvWriteDataCount    <= 0;
                                                      rvReadDataCount     <= 0;
                                                      rvcnt               <= 1'b0;
                                                   end
                                                else if((rvcnt==4) && (wvi2c_csr_readdata[1]==1'b1))
                                                   begin
                                                      rvtfr_state         <= ST_TFR_RX_DATA_LATCH;
                                                      rtfr_flag           <= 1'b1;
                                                      rvi2c_csr_read      <= 1'b0;
                                                      rvReadDataCount     <= rvReadDataCount +1;
                                                      rvcnt               <= 1'b0;
                                                      rvReadCnt           <= 0;
                                                   end
                                                else
                                                   begin
                                                      rvtfr_state         <= rvtfr_state;
                                                      rtfr_flag           <= 1'b0;
                                                      rvi2c_csr_address   <= ISR;
                                                      rvi2c_csr_writedata <= 32'h0;
                                                      rvi2c_csr_read      <= (rvcnt==1 ) ? 1'b1 : 1'b0;
                                                      rvi2c_csr_write     <= 1'b0;
                                                      rvcnt               <= (rvcnt==10) ? 0    : rvcnt + 1;
                                                      rvReadCnt           <= 0;
                                                      rvReadDataCount     <= rvReadDataCount;
                                                   end
                                             end												
                                       end
                                 default:          begin
                                                      rvtfr_state         <= IDLE_TFR;
                                                   end
                                    
                              endcase
                           end		
     
                     
	
               default:   begin
                           rvinit_state = IDLE_INIT;
                          end
			endcase
   end
   
   assign wvLoadData = (rvtfr_state==ST_TFR_LOAD) ? (ivTxdata>>(8*( WRITE_DATA_BYTE - rvWriteDataCount-1))) : 0;
                                                                      
         
      
//*******************************************************
//  data pipe line
//*******************************************************      
   always@(posedge iClk)
      begin
         rvi2c_csr_read1	<=	rvi2c_csr_read;
         rvi2c_csr_read2	<=	rvi2c_csr_read1;
         rEnaFlag          <= iEna;
         //rvi2c_csr_read2	<=	rvi2c_csr_read1;
      end	

//*******************************************************
// i2c address sel
//*******************************************************
/*
   localparam I2C_DEVICE_NUM = 5;
   wire[8                   : 0 ] wvTfr_state; 
   wire[8                   : 0 ] wvinit_state; 
   reg [I2C_DEVICE_NUM*8-1  : 0 ] rvTempStoreData;
   reg [I2C_DEVICE_NUM*7-1  : 0 ] rvAddress = {7'h4C, 7'h49, 7'h4A, 7'h4E, 7'h4F}; // U18 U27 U29 CPU BMC
   
   reg [6                   : 0 ] rvAddressBuf;
   
   always@(posedge clk50 or negedge sys_rst_n)
   begin
     if(!sys_rst_n)
     begin
        
     end
        
     if(wFlag100ms)
     begin
     
     end
        
   end   
   
   */
   
   
   
   
   
   
   assign oReadValid = rReadValid;
   assign ovRxdata   = rvRxdata;
		
   assign ovTfr_state [8:0] = rvtfr_state[8:0];   
   assign ovinit_state[8:0] = rvinit_state[8:0];      
	
endmodule

