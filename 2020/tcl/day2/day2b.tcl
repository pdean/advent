namespace path ::tcl::mathop

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
puts [llength $data]

set n 0

foreach l $data {
    set a 0
    lassign $l m c s
    lassign [split $m -] min max
    puts "$l  $min $max"
    set c [string trim $c :]
    set x [string index $s [- $min 1]]
    set y [string index $s [- $max 1]]
    if {$c eq $x} {incr a}
    if {$c eq $y} {incr a}
    if {$a == 1} {incr n}
}

puts $n

