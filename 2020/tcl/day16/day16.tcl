namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc run {data} {

    set names [list]
    set ranges [list]
    set tickets [list]

    set your 0
    set nearby 0

    set fields 0
    set n -1

    foreach l $data {
        incr n
        if {[regexp {^ *$} $l]} continue
        if {[regexp {^your} $l]} {
            set your 1
            continue
        }
        if {[regexp {^nearby} $l]} {
            set your 0
            set nearby 1
            continue
        }
        if {$your} {
            set myticket [split $l ,]
            continue
        }
        if {$nearby} {
            lappend tickets [split $l ,]
            continue
        }
        if {[regexp {([^:]+): (\d+)-(\d+) or (\d+)-(\d+)} $l --> name x1 x2 x3 x4]} {
            lappend names $name
            lappend ranges [list $x1 $x2 $fields]
            lappend ranges [list $x3 $x4 $fields]
            incr fields
            continue
        }
        puts "Error in Data: line $n: $l"
    }

    set invalid [list]

    foreach t $tickets {
        foreach f $t {
            set valid 0
            foreach r $ranges {
                lassign $r lo hi
                if {$f >= $lo && $f <= $hi} {
                    incr valid
                    break
                }
            }
            if {!$valid} {
                lappend invalid $f
            }
        }
    }

    puts $invalid
    puts [+ {*}$invalid]
}

run [input input0]
run [input input]
