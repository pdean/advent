namespace path ::tcl::mathop

proc run {} {

    set in [open input r]
    while {[gets $in line] >=0} {
        lappend data $line 
    }
    close $in
    puts [set n [llength $data]]

    for {set i 0} {$i < $n} {incr i} {
        set x [lindex $data $i]
        for {set j [+ $i 1]} {$j < $n} {incr j} {
            set y [lindex $data $j]
            if {[+ $x $y] == 2020} {
                return "$x $y [* $x $y]"
            }
        }
    }
}

puts [run]
