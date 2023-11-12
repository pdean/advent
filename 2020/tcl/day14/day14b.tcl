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
            set mask $val
            set andmask 0b[string map {0 1 X 0} $val]
            set ormask  0b[string map {X 0} $val]
            set masklist [list $mask]
            for {set i 0} {$i < 36} {incr i} {
                if {[string index $mask $i] ne "X"} continue
                set new [list]
                foreach m $masklist {
                    lappend new [string replace $m $i $i 0]
                    lappend new [string replace $m $i $i 1]
                }
                set masklist $new
            }
        } elseif {[regexp {(\d+)} $op junk mem]} {
            set addr [| $ormask [& $andmask $mem]]
            foreach m $masklist {
                dict set memory [| $addr 0b$m] $val
            }
        }
    }
    set sum 0
    foreach val [dict values $memory] {
        incr sum $val
    }
    puts $sum
}


run [input input2]
run [input input]
