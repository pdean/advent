namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc init {data} {
    global table maxx maxy
    set table [list]
    foreach l $data {
        lappend table [split $l {}]
    }
    set maxy [llength [lindex $table 0]]
    set maxx [llength $table]
    puts "maxx = $maxx"
    puts "maxy = $maxy"
}


proc print {} {
    global table maxx maxy

    foreach row $table {
        puts [join $row]
    }
    puts ""
}

proc floor {pt} {
    global table
    set here [lindex $table {*}$pt]
    return [expr {$here eq "."}] 
}

proc empty {pt} {
    global table
    set here [lindex $table {*}$pt]
    return [expr {$here eq "L"}] 
}

proc occup {pt} {
    global table
    set here [lindex $table {*}$pt]
    return [expr {$here eq "#"}] 
}

proc occupied {pt} {
    global table maxx maxy
    lassign $pt x y

    set occup 0
    foreach dx {-1 0 1} {
        foreach dy {-1 0 1} {
            if {!($dx==0 && $dy==0)} {
                set i [+ $x $dx]
                set j [+ $y $dy]
                while {($i >= 0 && $i < $maxx) && ($j >= 0 && $j < $maxy)} {
                    if {[empty [list $i $j]]} {
                        break
                    }
                    if {[occup [list $i $j]]} {
                        incr occup
                        break
                    }
                    incr i $dx
                    incr j $dy
                }
            }
        }
    }
    return $occup
}

proc evolve {} {
    global table maxx maxy

    set new $table
    
    set adds 0
    set subs 0

    for {set x 0} {$x < $maxx} {incr x} {
        for {set y 0} {$y < $maxy} {incr y} {
            set here [list $x $y]
            if {[floor $here]} continue
            set occup [occupied $here]
            if {[empty $here] && $occup == 0} {
                lset new $x $y {#}
                incr adds
            }
            if {[occup $here] && $occup >= 5} {
                lset new $x $y {L}
                incr subs
            }
       }
   }
   set table $new
   return [expr {$adds || $subs}]
}

proc count {} {
    global table maxx maxy

    set occup 0
    for {set x 0} {$x < $maxx} {incr x} {
        for {set y 0} {$y < $maxy} {incr y} {
            set here [list $x $y]
            if {[occup $here]} {incr occup}
        }
    }
    return $occup
}

proc run {data} {

    global table maxx maxy

    init $data

    while {[evolve]} {
        #print
    }
    puts [count]
}

run [input input0]
run [input input]
