namespace path [list ::tcl::mathop ::tcl::mathfunc]

proc run {data lastturn} {

    set recent [list]
    set prev [list]
    set count [list]
    set turn 1
    foreach  num [split $data ,] {
        dict set recent $num $turn
        dict set prev $num $turn
        dict set count $num 1
#        puts "$turn $num"
        incr turn
        set last $num
    }
    for {set i $turn} {$i <= $lastturn} {incr i} {
        if {$i % 10000 == 0} {
            puts -nonewline .
            flush stdout
        }
        if {$i % 1000000 == 0} {
            puts "\n$i"
            flush stdout
        }
        set n [dict get $count $last]
        if {$n == 1} {
            set newlast 0
        } else {
            set p [dict get $prev $last]
            set r [dict get $recent $last]
            set newlast [- $r $p ]
        }
#        puts "$i $newlast"
        if {[dict exists $count $newlast]} {
            dict set prev $newlast [dict get $recent $newlast]
            dict set recent $newlast $i 
            dict incr count $newlast 
        } else {
            dict set recent $newlast $i
            dict set prev   $newlast $i
            dict set count  $newlast 1
        }
        set last $newlast
    }
    puts "$last"
}

run 12,1,16,3,11,0 3e7
exit
run 0,3,6 3e7
run 1,3,2 2020
run 2,1,3 2020
run 1,2,3 2020
run 2,3,1 2020
run 3,2,1 2020
run 3,1,2 2020
