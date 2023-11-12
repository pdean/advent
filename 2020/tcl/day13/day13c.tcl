namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc run {data} {
    lassign $data time sched

    set n -1
    foreach b [split $sched ,] {
        incr n
        if {$b eq "x"} continue
        lappend buses $b [% [- $b $n] $b]
    }
    puts $buses
    set buses [lsort -integer -stride 2 $buses]
    puts $buses

    set inc 1
    set ts 0

    foreach {bus tgt} $buses {
        while {[% $ts $bus] != $tgt} {
            incr ts $inc
        }
        set inc [* $inc $bus]
        puts "$ts: $bus $tgt $inc"
    }
}

run [input input0]
run [input input5]
run [input input]





