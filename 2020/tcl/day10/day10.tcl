namespace path [list ::tcl::mathop ::tcl::mathfunc]



proc input {file} {
    set in [open $file r]
    set data [split [read -nonewline $in] \n]
    close $in
    return $data
}

proc count {data} {
    set data [lsort -integer $data]
    set max [max {*}$data]
    set data [concat 0 $data [+ $max 3]]
    puts $data
    set ones 0
    set threes 0

    foreach y [lassign $data x] {
        set diff [- $y $x]
        if {$diff == 1} {
            incr ones
            set x $y
            continue
        }
        if {$diff == 3} {
           incr threes
           set x $y 
           continue
       }
       puts "ERROR Diff=$diff"
   }
   return [list $ones $threes]
}

puts [count [input input0]]
puts [count [input input1]]
lassign [count [input input]] n1 n3
puts "$n1 $n3"
puts [* $n1 $n3]
