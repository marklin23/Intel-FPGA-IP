onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/iClk
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/iRstn
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/SCL
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/SDA
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/iEna
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/iRd_Wrn
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/oLoadData
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/oReadValid
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ovTfr_state
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ovinit_state
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ivAddress
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ivOffset
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ivTxdata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/ovRxdata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_scl_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_scl_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_sda_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_sda_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvReadDataCount
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvWriteDataCount
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_csr_address
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_csr_read
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_csr_write
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_csr_writedata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_csr_readdata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_i2c_serial_sda_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_i2c_serial_scl_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_i2c_serial_sda_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_i2c_serial_scl_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_interrupt_sender_irq
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_rx_data_source_data
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_rx_data_source_valid
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_rx_data_source_ready
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_transfer_command_sink_data
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_transfer_command_sink_valid
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_0_transfer_command_sink_ready
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_1_i2c_serial_sda_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_1_i2c_serial_scl_in
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_1_i2c_serial_sda_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_1_i2c_serial_scl_oe
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/i2c_1_interrupt_sender_irq
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_address
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_read
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_read1
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_read2
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_write
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_writedata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/wvi2c_csr_readdata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_readdata1
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_readdata2
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvinit_state
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvtfr_state
add wave -noupdate -expand -group i2c_m -divider write_burst
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/SCL
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/SDA
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rtfr_flag
add wave -noupdate -expand -group i2c_m -radix hexadecimal /tb/i2c_m_ctrl_inst/rvTxDataBuf
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvtfr_state
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/wvLoadData
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvWriteDataCount
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_address
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_write
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvi2c_csr_writedata
add wave -noupdate -expand -group i2c_m -divider end
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rinit_done
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvcnt
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvtxready
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rtfr_flag
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rEnaFlag
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rReadValid
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvRxdata
add wave -noupdate -expand -group i2c_m -radix hexadecimal -radixshowbase 1 /tb/i2c_m_ctrl_inst/rvReadCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iRstn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iClk
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iFlag
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iWDTEn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iSCL
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/iSDA
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/oSDAoe
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ivIICADDR
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ivTxData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ovRxAddr
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ovRxData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ovRxOffset
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/oWriteEn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/oReadEn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ovSCLCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/ovState
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvState
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvDecodeData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvSCLCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvAddrData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rWRn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvOffsetData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvWriteData
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rSDAo
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvShifttemp
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvRdCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvWrCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvSDAPipe
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvSCLPipe
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wTxShift
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wLoad
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wIICRstn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wFilteredSCL
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wFilteredSDA
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rSoftRstn
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvWDState
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvWDStateNext
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/rvWDCnt
add wave -noupdate -expand -group i2c_slave -radix hexadecimal -radixshowbase 1 /tb/i2c_slave_t_top_inst1/IIC_Decoder_INST/wWDTRstn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {315325768 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {135514097 ps} {645060839 ps}
