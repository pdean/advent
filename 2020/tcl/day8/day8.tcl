namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set n [llength $data]
set visited [lrepeat $n 0]

set index 0
set acc 0

while {1} {
    puts "$index $acc"
    if {[lindex $visited $index]} {
       puts "repeat $index"
       break
    }
    lset visited $index 1
    lassign [lindex $data $index] inst val
    if {$inst eq "nop"} {
        incr index
        continue
    } elseif {$inst eq "acc"} {
        incr acc $val
        incr index
        continue
    } elseif {$inst eq "jmp"} {
        incr index $val
        continue
    }
}

puts $visited

puts "n      = $n"
puts "answer = $acc"


