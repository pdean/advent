namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}


proc soonest {t b} {

    return [+ $b [* $b [/ $t $b]]]

}

proc run {data} {
    lassign $data time sched

    set n 0
    foreach b [split $sched ,] {
        if {$b eq "x"} continue

        set soonest [soonest $time $b]
        puts "$soonest $b"
        if {!$n} {
            set mint $soonest 
            set minb $b
        } elseif {$soonest < $mint} {
            set mint $soonest 
            set minb $b
        }
        incr n

    }

    puts "min $mint $minb"
    return [* $minb [- $mint $time]]
}

puts [run [input input0]]
puts [run [input input]]





