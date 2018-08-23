## ===================================================== 
## 	Top level register map: Base Addresses
## ===================================================== 
source [file join [file dirname [info script]] "../sval_top/reg_map_inc.tcl"]

## ================================================================== 
## 	Ethernet registers MAC(Tx and Rx)
## ================================================================== 
##
set  ADDR_RXMAC_TFLCFG 0x00
set  ADDR_RXMAC_SZECFG 0x01
set  ADDR_RXMAC_CRCCFG 0x02
set  ADDR_RXMAC_LNKFLT 0x03

proc chkmac_rx_maxframe_length {} {
    global BASE_RXMAC
    global ADDR_RXMAC_TFLCFG
    global ADDR_RXMAC_SZECFG
    global ADDR_RXMAC_CRCCFG
    global ADDR_RXMAC_LNKFLT
    puts "Accessing Mac Frame Length register in Rx MAC"; reg_read  $BASE_RXMAC  $ADDR_RXMAC_SZECFG
    puts "Modifying Mac Frame Length register in Rx MAC"; reg_write $BASE_RXMAC  $ADDR_RXMAC_SZECFG 0x1550
    puts "Verifying Mac Frame Length register in Rx MAC"; reg_read  $BASE_RXMAC  $ADDR_RXMAC_SZECFG
}
