namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set bags [list]

foreach line $data {
    regexp {(.*) bags contain (.*)} $line junk container contents

    if {[regexp {^no other} $contents]} {
        set res {}
    } else {
        set res {}
        foreach x [split $contents ,] {
            lassign $x n a c
            lappend res [list $n "$a $c"]
        }
    }
    dict set bags $container $res
}

proc dump {bags}  {
    foreach b [dict keys $bags] {
        set v [dict get $bags $b]
        puts "$b -> $v"
    }
}
#dump $bags

proc count {col} {

    set contents [dict get $::bags $col]
    if {[llength $contents] == 0} {
        return 0
    }

    set sum 0
    foreach x $contents {
        lassign $x n b
        set sum [+ $sum $n [* $n [count $b]]]
    }

    return $sum
}



puts [count "shiny gold"]


