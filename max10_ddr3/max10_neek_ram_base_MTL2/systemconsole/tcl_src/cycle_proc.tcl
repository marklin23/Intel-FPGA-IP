proc cycle { m0 ledBase } {

    set x 0xFE
    for { set i 0 } { $i < 50 } { incr i } {
        master_write_32 ${m0} ${ledBase} $x
        set x [ expr $x << 1 ]
        set x [ expr [ expr $x >> 8 ] | $x ]
        set x [ expr $x & 0xFF ]
        
        #
        # delay for a while
        #
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
        master_read_32 ${m0} ${ledBase} 1
    }
}

add_help cycle {
Illuminates a single LED and rotates it through the 8 LEDs on the board.

    Arguments:
        <service-path-of-master>
        <base-address-of-led-pio>
}
