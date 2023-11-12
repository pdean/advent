namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
puts [llength $data]

set m [string length [lindex $data 0]]
puts $m
set n 0

set r 0
set c 0

foreach l [lassign $data junk] {
    incr r
    incr c 3
    set c [% $c $m]
    puts "$r $c"
    set x [string index $l $c]
    if {$x eq "#"} {incr n}
}


puts $n

