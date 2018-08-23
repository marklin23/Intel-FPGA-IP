#
#  The following code snippet assumes that these two variables have already
#  been declared like this:
#
#       set m0 [ get_service_paths master ]
#       set ledBase 0x420
#

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
