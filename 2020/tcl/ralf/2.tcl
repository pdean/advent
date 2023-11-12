# tclsh puzzle02.tcl < input02.txt

set valid1 0
set valid2 0
set pw ""
while {[gets stdin line] >= 0} {
    # puts "$line [scan $line {%d-%d %s: %s} min max c pw]"
    if {[scan $line {%d-%d %s %s} min max c pw] == 4 || 1} {
	set c [string trim $c {:}]
	# puts "min {$min} max {$max} c {$c} pw {$pw}"
	array unset tmp
	foreach char [split $pw ""] {
	    incr tmp($char)
	}
	# part 1
	if {[info exists tmp($c)] && $tmp($c) >= $min && $tmp($c) <= $max} {
	    incr valid1
	}
	# part 2
	set c1 [string index $pw $min-1]
	set c2 [string index $pw $max-1]
	if {$c1 ne $c2 && ($c1 eq $c || $c2 eq $c)} {
	    incr valid2
	}
    }
}
puts "Part 1: $valid1 valid passwords"
puts "Part 2: $valid2 valid passwords"

# End of file
