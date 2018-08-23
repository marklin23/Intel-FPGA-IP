#common procedures

proc open_log_file {fname} {
    global LOGFILE
    set LOGFILE [open $fname  a]
}

proc close_log_file {} {
    global LOGFILE
    close $LOGFILE
}

proc putl {txt} {
    global LOGFILE
    puts $LOGFILE "$txt \r";
}

proc sleep {sec} {
    after [expr {int($sec * 1000)}];
}
