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
        if {$b eq "x"} {
            incr n
        } else {
            lappend buses [list $b $n]
            incr n
        }
    }
    puts $buses

    set buses [lassign $buses first]
    lassign $first first
    set n 1 
    while {1} {
        set t [* $n $first]
        set fail 0
        foreach b $buses {
            lassign $b bus dt
            if {[soonest $t $bus] != [+ $t $dt]} {
                incr fail
                break
            }
        }
        if {!$fail} break
        incr n
    }
        
    puts $t 

}

run [input input0]
run [input input5]
run [input input]





