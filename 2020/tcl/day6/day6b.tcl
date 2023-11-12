namespace path [list ::tcl::mathop ::tcl::mathfunc]

package require struct::set


set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set g [list]
set p [list]

foreach line $data {
    if {[string length $line] == 0} {
        lappend g $p
        set p [list]
    } else {
        lappend p [split $line {}]
    }
}

puts [join $g \n]

set h [lmap a $g {llength [::struct::set intersect {*}$a]}]

puts [join $h \n]

puts [+ {*}$h]
