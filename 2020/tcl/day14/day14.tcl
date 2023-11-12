namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc run {data} {
    set memory [list]
    foreach l $data {
        lassign [lmap x [split $l =] {string trim $x}] op val
        if {$op eq "mask"} {
            set andmask 0b[string map {X 1} $val]
            set ormask  0b[string map {X 0} $val]
        } elseif {[regexp {(\d+)} $op junk mem]} {
            set newval [| $ormask [& $andmask $val]]
            dict set memory $mem $newval
        }
    }
    set sum 0
    foreach val [dict values $memory] {
        incr sum $val
    }
    puts $sum
}


run [input input0]
run [input input]
