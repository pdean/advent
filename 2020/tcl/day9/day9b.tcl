namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

proc test {pre} {
    global data
    set n [llength $data]

    for {set i $pre} {$i < $n} {incr i} {
        set x [lindex $data $i]

        set found 0
        for {set j [- $i $pre]} {$j < [- $i 2]} {incr j} {
            set y [lindex $data $j]
            for {set k [+ $j 1]} {$k < $i} {incr k} {
                set z [lindex $data $k]
                if {$x == $y+$z} {
                    incr found
                }
            }
        }
        if {!$found} break
    }

    return $x
}

proc test2 {goal} {
    global data
    set n [llength $data]

    for {set i 0} {$i < $n} {incr i} {
        set l [list]
        set found 0
        for {set j $i} {$j < $n} {incr j} {
            lappend l [lindex $data $j]
            set sum [+ {*}$l]
            if {$sum == $goal} {
                set found 1
                break
            }
            if {$sum > $goal} {
                break
            }
        }
        if {$found} break
    }
    return $l
}

puts [set g [test 25]]

puts [set l [test2 $g]]

puts [+ [min {*}$l] [max {*}$l]]
