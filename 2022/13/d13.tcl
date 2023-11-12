#!/usr/bin/tclsh

namespace path ::tcl::mathop

set input [read -nonewline stdin]
set pairs [split [string map { "\n\n" "#" } $input] "#"]
set pairs [lmap x $pairs { split $x "\n" }]

proc islist {s} {
	return [expr {[string index $s 0] == "\["}]
}

proc unlist {s} {
	if {![islist $s]} { return $s }
	for {set i 1; set n 0} {$i < [string len $s]} {incr i} {
		if {[string index $s $i] == "\["} {
			incr n
		} elseif {[string index $s $i] == "\]"} {
			if {$n > 0} {
				incr n -1
			} else {
				return [string range $s 1 $i-1]
			}
		}
	}
}

proc pull {sName} {
	upvar $sName s
	if {[islist $s]} {
		set ret "\[[unlist $s]\]"
	} else {
		set ret [regsub {,.*} $s ""]
	}
	set s [string range $s [string len $ret]+1 end]
	return $ret
}

proc lcompare {l r} {
	while {$l != "" || $r != ""} {
		set l0 [pull l]
		set r0 [pull r]

		if {$l0 == "" && $r0 != ""} { ;# left ran out
			return 1
		} elseif {$l0 == "" && $r0 == ""} { ;# both ran out
			return 0
		} elseif {$l0 != "" && $r0 == ""} { ;# right ran out
			return -1
		}

		if {[islist $l0] || [islist $r0]} {
			set ret [lcompare [unlist $l0] [unlist $r0]]
			if {$ret != 0} {
				return $ret
			}
		} elseif {$l0 < $r0} {
			return 1
		} elseif {$l0 > $r0} {
			return -1
		}
	}
	if {!($l == "" && $r == "")} { error "PANIK" }
	return 0 ;#both ran out
}

for {set i 0} {$i < [llength $pairs] } {incr i} {
	lassign [lindex $pairs $i] l r
	set ret [lcompare [unlist $l] [unlist $r]]
	if {$ret > 0} {
		incr t0 [expr {$i + 1}]
	}
        puts "[+ $i 1]\t$ret"
}
puts "part1: $t0"

exit
set brackets [list {[[6]]} {[[2]]}]
foreach {p} $pairs { lappend brackets {*}$p }
set brackets [lreverse [lsort -command lcompare $brackets]]
set d0 [lsearch -exact $brackets {[[2]]}]
set d1 [lsearch -exact $brackets {[[6]]}]
puts "part2: [expr {($d0+1) * ($d1+1)}]"

