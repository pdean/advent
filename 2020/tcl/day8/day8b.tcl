namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set data [lmap a $data {
            lassign $a op val
            list $op $val
        }]

set n [llength $data]
set visited [lrepeat $n 0]

set index 0
set acc 0

proc run {} {
    global data visited n acc index

    set visited [lrepeat $n 0]
    set index 0
    set acc 0

    while {1} {
        if {$index == $n} {
            return 1
        }
        if {[lindex $visited $index]} {
            return 0
        }
        lset visited $index 1
        lassign [lindex $data $index] inst val
        puts "$index $acc $inst $val"
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
}

proc brute {} {

    global data n 

    for {set i 0} {$i < $n} {incr i} {
        lassign [lindex $data $i] op val
        if {$op eq "acc"} continue
        if {$op eq "jmp"} {
            set newop  nop 
        } elseif {$op eq "nop"} {
            if {$val != 0} {
                set newop jmp
            } else {
                continue
            }
        }
        lset data $i [list $newop $val]
        set flag  [run ]  
        if {$flag} {
            break
        } else {
            lset data $i [list $op $val]
            continue
        }
    }
}
        
set flag  [run ]  

puts "flag   = $flag"
puts "index  = $index"
puts "answer = $acc"

brute

puts "index  = $index"
puts "answer = $acc"
