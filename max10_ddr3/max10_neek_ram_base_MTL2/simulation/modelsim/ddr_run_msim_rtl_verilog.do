transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj {E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/golden_top.v}
vlog -vlog01compat -work work +incdir+E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj {E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/pll.v}
vlog -vlog01compat -work work +incdir+E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj {E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/MTL_Driver.v}
vlog -vlog01compat -work work +incdir+E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/db {E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/simulation/modelsim {E:/work/cloud/GFEC/02_Altera/Altera_IP/ddr/max10_proj/simulation/modelsim/golden_top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  golden_top_vlg_tst

add wave *
view structure
view signals
run -all
