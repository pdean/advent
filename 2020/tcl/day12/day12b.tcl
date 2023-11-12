namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc rad {deg} {

    set fac [/ [acos -1.0] 180]
    return [* $deg $fac]
}
proc deg {rad} {

    set fac [/ [acos -1.0] 180]
    return [/ $rad $fac]
}


proc calc {data} {
    
    set E 0
    set N 0
    set B 90

    set WE 10
    set WN 1

    foreach d $data {
        regexp {(.)(.*)} $d junk op val
        if {$op eq "N"} {
            set WN [+ $WN $val]
        } elseif {$op eq "S"} {
            set WN [- $WN $val]
        } elseif {$op eq "E"} {
            set WE [+ $WE $val]
        } elseif {$op eq "W"} {
            set WE [- $WE $val]
        } elseif {$op eq "L"} {
            set D [hypot $WE $WN]
            set B [atan2 $WE $WN]
            set B [- $B [rad $val]]
            set WE [* $D [sin $B]]
            set WN [* $D [cos $B]]
        } elseif {$op eq "R"} {
            set D [hypot $WE $WN]
            set B [atan2 $WE $WN]
            set B [+ $B [rad $val]]
            set WE [* $D [sin $B]]
            set WN [* $D [cos $B]]
        } elseif {$op eq "F"} {
            set E [+ $E [* $val $WE]]
            set N [+ $N [* $val $WN]]
        }
        puts " $op $val - $E  $N  -  $WE   $WN"
    }
    puts [format "%.3f %.3f" $E  $N]
    return [+ [abs $E] [abs $N]]

}

puts [format %.3f [calc [input input0]]]
puts [format %.3f [calc [input input]]]








