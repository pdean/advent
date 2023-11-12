namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}


proc mask {val mask} {
    set b [dec2bin $val 36]
    puts $val
    puts $b

    set res ""
    foreach d [split $b {}] m [split $mask {}] {
        if {$m eq "X"} {
            append res $d
        } else {
            append res $m
        }
    }
    puts $res
    return [bin2dec $res]

}

proc dec2bin {i {width {}}} {
    #returns the binary representation of $i
    # width determines the length of the returned string (left truncated or added left 0)
    # use of width allows concatenation of bits sub-fields

    set res {}
    if {$i<0} {
        set sign -
        set i [expr {abs($i)}]
    } else {
        set sign {}
    }
    while {$i>0} {
        set res [expr {$i%2}]$res
        set i [expr {$i/2}]
    }
    if {$res eq {}} {set res 0}

    if {$width ne {}} {
        append d [string repeat 0 $width] $res
        set res [string range $d [string length $res] end]
    }
    return $sign$res
}

proc bin2dec bin {
    if {$bin == 0} {
        return 0
    } elseif  {[string match -* $bin]} {
        set sign -
        set bin [string range $bin 1 end]
    } else {
        set sign {}
    }
    if {[string map [list 1 {} 0 {}] $bin] ne {}} {
        error "argument is not in base 2: $bin"
    }
    set r 0
    foreach d [split $bin {}] {
        incr r $r
        incr r $d
    }
    return $sign$r
}


proc run {data} {

    set memory [list]
    foreach l $data {

        lassign [split $l =] op val
        set op [string trim $op]
        set val [string trim $val]

        if {$op eq "mask"} {
            set mask $val
        } elseif {[regexp {(\d+)} $op junk mem]} {
            set newval [mask $val $mask]
            puts "$mem $val $newval"
            dict set memory $mem $newval
        }
    }
    set sum 0
    foreach val [dict values $memory] {
        set sum [+ $sum $val]
    }
    puts $sum
}


run [input input0]
#run [input input]
