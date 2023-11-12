#!/bin/sh --
# The next line restarts using wish \
exec tclsh "$0" -- "$@"

set fd [open [lindex $argv 0] r]
set input [split [read -nonewline $fd] \n]
close $fd

puts "input has [llength $input] lines"

# part 1

proc part1 {target} {
    foreach elt1 $::input {
	foreach elt2 $::input {
	    if {$elt1 + $elt2 == $target} {
		puts "part 1: $elt1 * $elt2 = [expr {$elt1 * $elt2}]"
		return
	    }
	}
    }
}

proc part2 {target} {
    foreach elt1 $::input {
	foreach elt2 $::input {
	    foreach elt3 $::input {
		if {$elt1 + $elt2 + $elt3 == $target} {
		    puts "part 2: $elt1 * $elt2 * $elt3 = [expr {$elt1 * $elt2 * $elt3}]"
		    return
		}
	    }
	}
    }
}
set target 2020
part1 $target
part2 $target

# End of file
