namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
set rows [llength $data]
set m [string length [lindex $data 0]]
puts "$rows $m"

proc count {ic ir} {
    global rows m data
    set n 0
    set r 0
    set c 0

    while {1} {
        incr r $ir
        if {$r >= $rows} break
        incr c $ic
        set c [% $c $m]
        set l [lindex $data $r]
        set x [string index $l $c]
        if {$x eq "#"} {incr n}
    }
    puts $n
    return $n
}

set p1 [count 1 1]
set p2 [count 3 1]
set p3 [count 5 1]
set p4 [count 7 1]
set p5 [count 1 2]

puts [* $p1 $p2 $p3 $p4 $p5]

