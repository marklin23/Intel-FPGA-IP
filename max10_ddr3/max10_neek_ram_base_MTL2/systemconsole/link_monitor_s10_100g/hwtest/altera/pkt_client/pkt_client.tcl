# =====================================================
#     Top level register map: Base Addresses
# =====================================================
#    word address to byte address translations should
#    happen inside the basic.tcl defining write & read
# ______________________________________________________

set CLIENT_BASE  $BASE_TRFC
# =====================================================
#     Ethernet registers (MAC + PHY)
# =====================================================

set REG_TEMP_SENSE     0x0006
# =====================================================
#     test utilities
# =====================================================

set log 0

proc client_init {LOG} {
    global log
    set log $LOG
}

proc check_e_temp {} {
    global CLIENT_BASE
    global REG_TEMP_SENSE
    global rdata
    global log
    set rdata [reg_read $CLIENT_BASE $REG_TEMP_SENSE]
    return $rdata
}


proc stop_pkt_gen {} {
    global CLIENT_BASE

    global rdata
    global wdata
    global log

    reg_write $CLIENT_BASE 0x10 0x7
}

proc client_rom {} {
    global CLIENT_BASE
    global log
    global rdata
    global wdata
    reg_write $CLIENT_BASE 0x10 0x2
}

proc client_loop {} {
    global CLIENT_BASE
    reg_write $CLIENT_BASE 0x10 0xf
}

proc start_pkt_gen {} {
    global CLIENT_BASE
    global log
    global rdata
    global wdata
    reg_write $CLIENT_BASE 0x10 0x5
}

proc client_reset {} {
    global CLIENT_BASE

    reg_write $CLIENT_BASE 0x16 1
    after 100
    reg_write $CLIENT_BASE 0x16 0
}
