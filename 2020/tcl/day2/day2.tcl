
set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
puts [llength $data]

set n 0

foreach l $data {
    lassign $l m c s
    lassign [split $m -] min max
    set c [string trim $c :]
    set cnt [regexp -all $c $s]
    if {$cnt >= $min &&  $cnt <= $max} {
        incr n
    }
}

puts $n

