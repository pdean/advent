namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set g [list]
set p ""

foreach line $data {
    if {[string length $line] == 0} {
        lappend g $p
        set p ""
    } else {
        append p $line
    }
}

puts $g

set h [lmap a $g {llength [lsort -unique [split $a {}]]}]

puts [join $h \n]

puts [+ {*}$h]
