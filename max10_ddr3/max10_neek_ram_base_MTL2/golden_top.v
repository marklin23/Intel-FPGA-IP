// ============================================================================
// Copyright (c) 2015 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Thu Jul  2 14:45:59 2015
// ============================================================================
//Last Edit Melissa Sussmann July 13 2015, Altera 

`define ENABLE_ADC
`define ENABLE_AUDIO
`define ENABLE_CAMERA
`define ENABLE_DAC
//`define ENABLE_DDR3
`define ENABLE_FLASH
`define ENABLE_GPIO
`define ENABLE_GSENSOR
`define ENABLE_HDMI
`define ENABLE_HEX0
`define ENABLE_HEX1
`define ENABLE_KEY
`define ENABLE_LEDR
`define ENABLE_LSENSOR
`define ENABLE_MAX10
`define ENABLE_MIPI
`define ENABLE_MTL2
`define ENABLE_NET
`define ENABLE_PM
`define ENABLE_PS2
`define ENABLE_RH
`define ENABLE_SD
`define ENABLE_SW
`define ENABLE_UART

module golden_top(

`ifdef ENABLE_ADC
      ///////// ADC 3.3 V /////////
      input              ADC_CLK_10,
`endif     
     
`ifdef ENABLE_AUDIO
      ///////// AUDIO 2.5 V /////////
      inout              AUDIO_BCLK,
      output             AUDIO_DIN_MFP1,
      input              AUDIO_DOUT_MFP2,
      inout              AUDIO_GPIO_MFP5,
      output             AUDIO_MCLK,
      input              AUDIO_MISO_MFP4,
      inout              AUDIO_RESET_n,
      output             AUDIO_SCLK_MFP3,
      output             AUDIO_SCL_SS_n,
      inout              AUDIO_SDA_MOSI,
      output             AUDIO_SPI_SELECT,
      inout              AUDIO_WCLK,
`endif
     
`ifdef ENABLE_CAMERA   
      ///////// CAMERA /////////
      // 2.5 V
     output             CAMERA_I2C_SCL,
      inout              CAMERA_I2C_SDA,
      // 3.3 V LVTTL
     output             CAMERA_PWDN_n,
`endif
     
`ifdef ENABLE_DAC     
      ///////// DAC 3.3 V LVTTL /////////
      inout              DAC_DATA,
      output             DAC_SCLK,
      output             DAC_SYNC_n,
`endif
     
`ifdef ENABLE_DDR3
      ///////// DDR3 1.5 V /////////
     // "SSTL-15 CLASS I"
      output      [14:0] DDR3_A,
      output      [2:0]  DDR3_BA,
      output             DDR3_CKE, 
      output             DDR3_CAS_n,
      output             DDR3_CS_n,
      output      [2:0]  DDR3_DM,
      inout       [23:0] DDR3_DQ,
      output             DDR3_ODT,
      output             DDR3_RAS_n,
      output             DDR3_RESET_n,
      output             DDR3_WE_n,
     // "DIFFERENTIAL 1.5-V SSTL CLASS I"
      inout              DDR3_CK_n,
      inout              DDR3_CK_p,
      inout       [2:0]  DDR3_DQS_n,
      inout       [2:0]  DDR3_DQS_p,
`endif 

`ifdef ENABLE_FLASH
      ///////// FLASH /////////
     // "3.3-V LVTTL"
      inout       [3:0]  FLASH_DATA,
      output             FLASH_DCLK,
      output             FLASH_NCSO,
      output             FLASH_RESET_n,
`endif
    
    `ifdef ENABLE_GPIO
      ///////// GPIO /////////
     // "3.3-V LVTTL"
      inout       [7:0]  GPIO,    
    `endif   
    
`ifdef ENABLE_GSENSOR  
      ///////// GSENSOR /////////
     // 2.5 V
      output             GSENSOR_CS_n,
      input       [2:1]  GSENSOR_INT,
      inout              GSENSOR_SCLK,
      inout              GSENSOR_SDI,
      inout              GSENSOR_SDO,
`endif  
     
`ifdef ENABLE_HDMI  
      ///////// HDMI /////////
      // "3.3-V LVTTL"
      input              HDMI_AP,
      inout              HDMI_I2C_SCL,
      inout              HDMI_I2C_SDA,
      inout              HDMI_LRCLK,
      inout              HDMI_MCLK,
      input              HDMI_RX_CLK,
      input       [23:0] HDMI_RX_D,
      input              HDMI_RX_DE,
      inout              HDMI_RX_HS,
      input              HDMI_RX_INT1,
      inout              HDMI_RX_RESET_n,
      input              HDMI_RX_VS,
      inout              HDMI_SCLK,
`endif
     
`ifdef ENABLE_HEX0     
      ///////// HEX0 /////////
     // "3.3-V LVTTL"
      output      [6:0]  HEX0,
`endif

`ifdef ENABLE_HEX1
      ///////// HEX1 /////////
     // "3.3-V LVTTL"
      output      [6:0]  HEX1,
`endif
     
`ifdef ENABLE_KEY
      ///////// KEY /////////
     // "1.5 V SCHMITT TRIGGER" 
      input       [4:0]  KEY,
`endif
     
`ifdef ENABLE_LEDR     
      ///////// LEDR /////////
     // "3.3-V LVTTL"
      output      [9:0]  LEDR,
`endif
     
`ifdef ENABLE_LSENSOR     
      ///////// LSENSOR /////////
     // "3.3-V LVTTL"
      inout              LSENSOR_INT,
      output             LSENSOR_SCL,
      inout              LSENSOR_SDA,
`endif
     
`ifdef ENABLE_MAX10    
      ///////// MAX10 /////////
     //  "3.3-V LVTTL"
      input              MAX10_CLK1_50,
      input              MAX10_CLK2_50,
      input              MAX10_CLK3_50,
`endif
     
`ifdef ENABLE_MIPI
      ///////// MIPI CS2 CAMERA /////////
     // "3.3-V LVTTL"
      output             MIPI_CS_n,
      output             MIPI_I2C_SCL,
      inout              MIPI_I2C_SDA,
      input              MIPI_PIXEL_CLK,
      input       [23:0] MIPI_PIXEL_D,
      input              MIPI_PIXEL_HS,
      input              MIPI_PIXEL_VS,
      output             MIPI_REFCLK,
      output             MIPI_RESET_n,
`endif

`ifdef ENABLE_MTL2     
      ///////// MTL2 /////////
     // "3.3-V LVTTL"
      output      [7:0]  MTL2_B,
      output             MTL2_BL_ON_n,
      output             MTL2_DCLK,
      output      [7:0]  MTL2_G,
      output             MTL2_HSD,
      output             MTL2_I2C_SCL,
      inout              MTL2_I2C_SDA,
      input              MTL2_INT,
      output      [7:0]  MTL2_R,
      output             MTL2_VSD,
`endif
     
`ifdef ENABLE_NET
      ///////// NET /////////
     // 2.5 V 
      output             NET_GTX_CLK,
      input              NET_INT_n,
      input              NET_LINK100,
      output             NET_MDC,
      inout              NET_MDIO,
      output             NET_RST_N,
      input              NET_RX_CLK,
      input              NET_RX_COL,
      input              NET_RX_CRS,
      input       [3:0]  NET_RX_D,
      input              NET_RX_DV,
      input              NET_RX_ER,
      input              NET_TX_CLK,
      output      [3:0]  NET_TX_D,
      output             NET_TX_EN,
      output             NET_TX_ER,
`endif
     
`ifdef ENABLE_PM     
      ///////// PM /////////
     //  "3.3-V LVTTL"
      output             PM_I2C_SCL,
      inout              PM_I2C_SDA,
`endif

`ifdef ENABLE_PS2
      ///////// PS2 /////////
     // "3.3-V LVTTL"
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,
`endif

`ifdef ENABLE_RH
      ///////// RH /////////
     // "3.3-V LVTTL"
      input              RH_TEMP_DRDY_n,
      output             RH_TEMP_I2C_SCL,
      inout              RH_TEMP_I2C_SDA,
`endif
     
`ifdef ENABLE_SD
      ///////// SD /////////
     // 2.5 V  
      output             SD_CLK,
      inout              SD_CMD,
      inout       [3:0]  SD_DATA,
`endif

`ifdef ENABLE_SW
      ///////// SW ///////// 
     // 1.5 V 
      input       [9:0]  SW,
`endif
     
`ifdef ENABLE_UART
      ///////// UART /////////
     // 2.5 V 
      output             UART_RESET_n,
      input              UART_RX,
      output             UART_TX,
`endif

      ///////// FPGA /////////
      input              FPGA_RESET_n

);


//=======================================================
//  REG/WIRE declarations
//=======================================================
//      output      [14:0] DDR3_A,
//      output      [2:0]  DDR3_BA,
//      output             DDR3_CKE, 
//      output             DDR3_CAS_n,
//      output             DDR3_CS_n,
//      output      [2:0]  DDR3_DM,
//      inout       [23:0] DDR3_DQ,
//      output             DDR3_ODT,
//      output             DDR3_RAS_n,
//      output             DDR3_RESET_n,
//      output             DDR3_WE_n,
//     // "DIFFERENTIAL 1.5-V SSTL CLASS I"
//      inout              DDR3_CK_n,
//      inout              DDR3_CK_p,
//      inout       [2:0]  DDR3_DQS_n,
//      inout       [2:0]  DDR3_DQS_p,

//    ddr u0 (
//        .clk_clk                                         ( wClk50     ),                                         //                                 clk.clk
//        .mem_if_ddr3_emif_0_pll_sharing_pll_mem_clk      ( ),//      mem_if_ddr3_emif_0_pll_sharing.pll_mem_clk
//        .mem_if_ddr3_emif_0_pll_sharing_pll_write_clk    ( ),//                                    .pll_write_clk
//        .mem_if_ddr3_emif_0_pll_sharing_pll_locked       ( ),//                                    .pll_locked
//        .mem_if_ddr3_emif_0_pll_sharing_pll_capture0_clk ( ),//                                    .pll_capture0_clk
//        .mem_if_ddr3_emif_0_pll_sharing_pll_capture1_clk ( ),//                                    .pll_capture1_clk
//        .mem_if_ddr3_emif_0_status_local_init_done       ( LEDR[7]),//           mem_if_ddr3_emif_0_status.local_init_done
//        .mem_if_ddr3_emif_0_status_local_cal_success     ( LEDR[8]),//                                    .local_cal_success
//        .mem_if_ddr3_emif_0_status_local_cal_fail        ( LEDR[9]),//                                    .local_cal_fail
//        .memory_mem_a                                    ( DDR3_A     ),//                              memory.mem_a
//        .memory_mem_ba                                   ( DDR3_BA    ),//                                    .mem_ba
//        .memory_mem_ck                                   ( DDR3_CK_p  ),//                                    .mem_ck
//        .memory_mem_ck_n                                 ( DDR3_CK_n  ),//                                    .mem_ck_n
//        .memory_mem_cke                                  ( DDR3_CKE   ),//                                    .mem_cke
//        .memory_mem_cs_n                                 ( DDR3_CS_n  ),//                                    .mem_cs_n
//        .memory_mem_dm                                   ( DDR3_DM    ),//                                    .mem_dm
//        .memory_mem_ras_n                                ( DDR3_RAS_n ),//                                    .mem_ras_n
//        .memory_mem_cas_n                                ( DDR3_CAS_n ),//                                    .mem_cas_n
//        .memory_mem_we_n                                 ( DDR3_WE_n  ),//                                    .mem_we_n
//        .memory_mem_reset_n                              ( DDR3_RESET_n ),//                                    .mem_reset_n
//        .memory_mem_dq                                   ( DDR3_DQ    ),//                                    .mem_dq
//        .memory_mem_dqs                                  ( DDR3_DQS_p ),//                                    .mem_dqs
//        .memory_mem_dqs_n                                ( DDR3_DQS_n ),//                                    .mem_dqs_n
//        .memory_mem_odt                                  ( DDR3_ODT   ),//                                    .mem_odt
//        .mm_bridge_0_s0_waitrequest                      ( ),//                      mm_bridge_0_s0.waitrequest
//        .mm_bridge_0_s0_readdata                         ( ),//                                    .readdata
//        .mm_bridge_0_s0_readdatavalid                    ( ),//                                    .readdatavalid
//        .mm_bridge_0_s0_burstcount                       ( ),//                                    .burstcount
//        .mm_bridge_0_s0_writedata                        ( ),//                                    .writedata
//        .mm_bridge_0_s0_address                          ( ),//                                    .address
//        .mm_bridge_0_s0_write                            ( ),//                                    .write
//        .mm_bridge_0_s0_read                             ( ),//                                    .read
//        .mm_bridge_0_s0_byteenable                       ( ),//                                    .byteenable
//        .mm_bridge_0_s0_debugaccess                      ( ),//                                    .debugaccess
//        .reset_reset_n                                   ( KEY[0] & wPllRstn ),                                   //                               reset.reset_n
//        .mem_if_ddr3_emif_0_afi_reset_export_reset_n     (           ),     // mem_if_ddr3_emif_0_afi_reset_export.reset_n
//        .pio_0_external_connection_export                ( LEDR[6:0] )                 //           pio_0_external_connection.export
//    ); 

	 
	 
	 
	 
	 
	 
    wire wPllRstn;
    wire wClk50,wClk30, wClk150,wClk100 , wClk300;
    pll pll_inst(
      .areset ( 1'b0          ) ,
      .inclk0 ( MAX10_CLK1_50 ) ,
      .c0     ( wClk150       ) ,
      .c1     ( wClk100       ) ,
      .c2     ( wClk300       ) ,
      .c3     ( wClk50        ) ,
		.c4     ( wClk30        ) ,
      .locked ( wPllRstn      ) 
    );



	//=======================================================
	//  Structural coding
	//=======================================================
		 //pio_test u0 (
		 //    .clk_clk                          ( MAX10_CLK1_50 ),                          //                       clk.clk
		 //    .reset_reset_n                    ( KEY[0]        ),                    //                     reset.reset_n
		 //    .pio_0_external_connection_export ( LEDR[7:0]     )  // pio_0_external_connection.export
		 //);
	wire [10:0] wvHcounter;
	wire [10:0] wvVcounter;

	MTL_Driver MTL_Driver_inst (

		.iClk         ( wClk30             ) ,  // wClk30
		.iRstn        ( KEY[0] & wPllRstn  ) ,
		.ivControl    ( SW[7:0]            ) ,
		.ivRGB_Ram    ( q[23:0]            ) ,
		.ovHcounter   ( wvHcounter         ) ,
		.ovVcounter   ( wvVcounter         ) ,
		.MTL2_INT     ( MTL2_INT           ) ,
		.MTL2_I2C_SCL ( MTL2_I2C_SCL       ) ,
		.MTL2_I2C_SDA ( MTL2_I2C_SDA       ) ,	
		.MTL2_BL_ON_n (                    ) ,
		.MTL2_DCLK    ( MTL2_DCLK          ) ,
		.MTL2_R       ( MTL2_R             ) ,
		.MTL2_G       ( MTL2_G             ) ,
		.MTL2_B       ( MTL2_B             ) ,
		.MTL2_HSD     ( MTL2_HSD           ) ,
		.MTL2_VSD     ( MTL2_VSD           ) ,
		
			

	);
		
	assign MTL2_BL_ON_n = wPllRstn & SW[8];
	
	wire [12:0] address;
	wire        clock;
	wire [23:0] data;
	wire        wren;
	reg         rden;
	wire [23:0] q;
	
	wire [63:0] wvSource;
	wire [63:0] wvProbe;	
	
	//assign wvProbe[23:0] =        q [23: 0];
	//assign address[12:0] = wvSource [12: 0];
	//assign data   [23:0] = wvSource [36:13];
	//assign wren          = wvSource [37];
	//assign rden          = wvSource [38];
	
	S_P S_P_inst (
        .source (wvSource), // sources.source
        .probe  (wvProbe )   //  probes.probe
    );
	
	ram ram_inst ( 
		             .address ( rvAddressCounter ),
		             .clock   ( wClk30  ),
		             .data    ( data    ),
		             .wren    ( wren    ),
						 .rden    ( rden    ), 
		             .q       ( q       )  
						 
				     );

	reg [20:0]rvAddressCounter;
	reg [12:0]rvHsyncCounter;	
	reg [7:0]rvVCounter;
	reg rVScaleValid;
	reg rVScaleValid2;
	wire wScaleValidfall = (rVScaleValid2 & ~rVScaleValid);
	wire wScaleValidrise = (~rVScaleValid2 & rVScaleValid);
	reg [4:0] rvCounter;
	
	// scale
	
	//pixel size: 100x 60 to 800x 480 ==> 8 scale
	
	parameter PIC_SCALE = 8;
	
	always@(posedge wClk30) begin
		rvVCounter <=  (MTL2_VSD == 0) ? 0              : 
							wScaleValidrise ? rvVCounter + 1 : rvVCounter;
	end
	
	
	always@(posedge wClk30) begin
		rVScaleValid2 <= rVScaleValid;
		if((KEY[0] & wPllRstn) ==0) begin
			rVScaleValid     <= 0;
			rvHsyncCounter   <= 0;
		end
		else if (MTL2_VSD == 0) begin
			rvHsyncCounter   <= 0;
			rVScaleValid     <= 0;
		end
		else	begin
			rvHsyncCounter      <= (wvVcounter[10:0] <= 23 )         ? 0: 
										  (MTL2_HSD == 0  && rVScaleValid ) ? rvHsyncCounter + 1 : rvHsyncCounter;
												
			rVScaleValid        <=  ((wvVcounter[10:0]>=32 ) && ((wvVcounter[10:0]-24 )%PIC_SCALE == 0));
											
		end
	end
	
	wire wDisplay =(wvHcounter>45 && wvHcounter< 846) && (wvVcounter[10:0] > 23 ) && (wvVcounter[10:0] < 503) ;
	always@(posedge wClk30) begin
		 
		if((KEY[0] & wPllRstn) ==0) 
			begin
				rvAddressCounter <= 0;
				rden             <= 1;
				rvCounter        <= 0;
				
			end
		else if (MTL2_VSD == 0)//( (wvVcounter[10:0] == 11'd524) && (wvHcounter[10:0] == 11'd1055) )
			begin
				rvAddressCounter <= 0;
				rden             <= 1;
				rvCounter        <= 0;
			end	
		else if (MTL2_HSD == 0)//( (wvVcounter[10:0] == 11'd524) && (wvHcounter[10:0] == 11'd1055) )
			begin
				rvAddressCounter <= (rvVCounter+1)*100 - 100;
				rvCounter        <= 0;
			end
		else if (SW[9] && wDisplay ) 
			begin
				
				rvAddressCounter <= (rvCounter == PIC_SCALE-1) ? rvAddressCounter + 1 : rvAddressCounter;
				//rvAddressCounter <= ((rvAddressCounter == ((rvHsyncCounter+1)*100-1 ))
				//												    && (rvCounter == PIC_SCALE-1)) ? ( wScaleValidfall ? rvAddressCounter+1 : 0)
				//													 (rvCounter == PIC_SCALE-1)                         ? rvAddressCounter +1                            : rvAddressCounter;
				   
				rvCounter        <= (rvCounter == PIC_SCALE-1)                         ? 0 : rvCounter + 1;
				rden             <= 1'b1;
			end

						
	end

endmodule
