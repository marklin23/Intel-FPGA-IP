onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /golden_top_vlg_tst/i1/MAX10_CLK1_50
add wave -noupdate /golden_top_vlg_tst/i1/wClk300
add wave -noupdate /golden_top_vlg_tst/i1/wClk100
add wave -noupdate /golden_top_vlg_tst/i1/wClk150
add wave -noupdate /golden_top_vlg_tst/i1/wClk40
add wave -noupdate /golden_top_vlg_tst/i1/wPllRstn
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/iClk
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/iRstn
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/ivControl
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_INT
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_I2C_SCL
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_I2C_SDA
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_BL_ON_n
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_DCLK
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_R
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_G
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_B
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_HSD
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/MTL2_VSD
add wave -noupdate -radix unsigned /golden_top_vlg_tst/i1/MTL_Driver_inst/rvHcounter
add wave -noupdate -radix unsigned /golden_top_vlg_tst/i1/MTL_Driver_inst/rvVcounter
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/rHsync
add wave -noupdate /golden_top_vlg_tst/i1/MTL_Driver_inst/rVsync
add wave -noupdate -radix hexadecimal /golden_top_vlg_tst/i1/MTL_Driver_inst/rvR
add wave -noupdate -radix hexadecimal /golden_top_vlg_tst/i1/MTL_Driver_inst/rvG
add wave -noupdate -radix hexadecimal /golden_top_vlg_tst/i1/MTL_Driver_inst/rvB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {651960000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 299
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
WaveRestoreZoom {0 ps} {6117030936 ps}
