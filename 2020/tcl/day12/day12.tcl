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

proc calc {data} {
    
    set E 0
    set N 0
    set B 90

    foreach d $data {
        regexp {(.)(.*)} $d junk op val

        puts "$op    $val"

        if {$op eq "N"} {
            set N [+ $N $val]
        } elseif {$op eq "S"} {
            set N [- $N $val]
        } elseif {$op eq "E"} {
            set E [+ $E $val]
        } elseif {$op eq "W"} {
            set E [- $E $val]
        } elseif {$op eq "L"} {
            set B [- $B $val]
        } elseif {$op eq "R"} {
            set B [+ $B $val]
        } elseif {$op eq "F"} {
            set E [+ $E [* $val [sin [rad $B]]]]
            set N [+ $N [* $val [cos [rad $B]]]]
        }
    }
    puts [format "%.3f %.3f" $E  $N]
    return [+ [abs $E] [abs $N]]

}

puts [format %.3f [calc [input input0]]]
puts [format %.3f [calc [input input]]]








