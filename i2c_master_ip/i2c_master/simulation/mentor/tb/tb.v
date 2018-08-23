// Copyright (C) 2016  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
// Generated on "02/08/2018 23:43:57"
                                                                                
// Verilog Test Bench template for design : es5642bq_fpga_pin
// 
// Simulation tool : ModelSim-Altera (Verilog)
// 

`timescale 1 ns/ 1 ns
module tb();

pullup(pull1) p00( wSCL );  
pullup(pull1) p01( wSDA );  

reg rClk_50 , rRstn;
reg rEna;
pullup(pull1) p20( LM75BD1_SCLK        );  
pullup(pull1) p21( LM75BD2_SCLK        );  
pullup(pull1) p22( LM75BD3_SCLK        );  
pullup(pull1) p23( LM75B0_HEATER_SCLK  );            
pullup(pull1) p24( LM75B1_HEATER_SCLK  );  
                
pullup(pull1) p25( LM75BD1_SDA         );    
pullup(pull1) p26( LM75BD2_SDA         );     
pullup(pull1) p27( LM75BD3_SDA         );  
pullup(pull1) p28( LM75B0_HEATER_SDA   );  
pullup(pull1) p29( LM75B1_HEATER_SDA   );  
pullup(pull1) p30( FAN_SCL_FPGA_R      );  
pullup(pull1) p31( FAN_SDA_FPGA_R      ); 

parameter time_unit      = 1;					      //
parameter clk_time       = 20 * time_unit;   	//
parameter clk_time_div2  = ( clk_time /   2 );	//
parameter clk_time_div10 = ( clk_time / 100 );	//
parameter wait_time      = clk_time * 1000; 	   //
parameter wait_long_time = clk_time * 10000;	   //

`define LM75_1_ADDR                    7'h4C //7'h1C         // U18
`define LM75_2_ADDR                    7'h49 //7'h19         // U27
`define LM75_3_ADDR                    7'h4A //7'h1A         // U29
`define LM75_CPU_ADDR                  7'h4E //7'h1E         // CPU
`define LM75_BMC_ADDR                  7'h4F //7'h1F         // BMC
`define CPLD_ADDRESS                   7'h66 //7'h16         // BMC

i2c_m_ctrl#(

   .OFFSET_DATA_BYTE ( 1 ),
   .READ_DATA_BYTE   ( 20 ),
   .WRITE_DATA_BYTE  ( 5 )

)i2c_m_ctrl_inst(
   .iClk          ( rClk_50 ) ,
   .iRstn         ( rRstn   ) ,
//  .i2c_scl_in    () ,
//  .i2c_scl_oe    () ,
//  .i2c_sda_in    () ,
//  .i2c_sda_oe    () ,
   .SCL           ( wSCL   ) ,
   .SDA           ( wSDA   ) ,
   .iEna          ( rEna   ) ,  
   .iRd_Wrn       ( 1'b1   ) ,
   .oLoadData     (        ) ,
   .oReadValid    (        ) ,
   .ovTfr_state   (        ) ,  
   .ovinit_state  (        ) ,
   .ivAddress     ( 7'h08  ) ,
   .ivOffset      ( 8'hed  ) ,
   .ivTxdata      ({8'h05,8'h12,8'h00,8'h00,8'h60,8'h00}) ,
   //.ivTxdata      ( 8'hA5  ) ,
   .ovRxdata      (        )
   
);

i2c_slave_t_top#(
   .slave_addr ( 7'h08  ),
   .tx_data    ( 8'h55  ),
   .write_num  ( 5      ),
   .read_num   ( 20      )
)i2c_slave_t_top_inst1(
   .iRstn      ( rRstn   ),
   .iClk       ( rClk_50 ),
   .SCL        ( wSCL    ),
   .SDA        ( wSDA    )
);

//==============================================
// clock
//==============================================
initial
begin
  rClk_50 = 1'b1;
  forever
    #clk_time_div2 rClk_50 = ~rClk_50;
end

initial
begin
  rRstn   = 1'b0;
  rEna    = 1'b0;
  # wait_time   rRstn = 1'b1;
  # wait_long_time 
                rEna    = 1'b1;
end

endmodule

