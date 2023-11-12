namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
#puts [llength $data]

proc seat {code} {

    set rmin 0
    set rmax 127

    set cmin 0
    set cmax 7

    foreach c [split $code {}] {

        if {$c eq "F"} {
            set rmax [/ [+ $rmax $rmin] 2]
        } elseif {$c eq "B"} {
            set rmin [+ 1 [/ [+ $rmax $rmin] 2]]
        } elseif {$c eq "L"} {
            set cmax [/ [+ $cmax $cmin] 2]
        } elseif {$c eq "R"} {
            set cmin [+ 1 [/ [+ $cmax $cmin] 2]]
         } 
         #puts "$c $rmin $rmax $cmin $cmax"
    }

    return [+ $cmin [* 8 $rmin]]
}


puts [seat FBFBBFFRLR]
puts [seat BFFFBBFRRR]
puts [seat FFFBBBFRRR]
puts [seat BBFFBBFRLL]

set max 0

foreach code $data {
    set val [seat $code]
    if {$val > $max} {
        set max $val
    }
}

puts $max
