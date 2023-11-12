namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc run {data lastturn} {

    set turns [list]
    set turn 1
    foreach  num [split $data ,] {
        dict set turns $num [list $turn]
        incr turn
        set last $num
    }
    for {set i $turn} {$i <= $lastturn} {incr i} {
        set list [dict get $turns $last]
        if {[llength $list] == 1} {
            set last 0
        } else {
            set last [- [lindex $list end] [lindex $list end-1]]
        }
        dict lappend turns $last $i
    }
    puts "$i $last"
}

run 0,3,6 2020
run 1,3,2 2020
run 2,1,3 2020
run 2,3,1 2020
run 3,2,1 2020
run 3,1,2 2020
run 12,1,16,3,11,0 2020
