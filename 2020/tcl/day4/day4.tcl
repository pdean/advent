namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in
puts [llength $data]

set pps [list]
set pp [list]

foreach line $data {
    if {[llength $line] == 0} {
        lappend pps $pp
        set pp [list]
    } else {
        lappend pp {*}$line
    }
}
lappend pps $pp
#puts [join $pps \n]


set req [list byr iyr eyr hgt hcl ecl pid]
set opt [list cid]

set n 0
foreach pp $pps {
    set lst [lmap a $pp {
        lassign [split $a :] b
        if {$b in  $req} {
            expr 1
        } elseif {$b in $opt} {
            expr 0
        } else {
            expr 0
        }
    }]
    set cnt [+ {*}$lst]
    puts "$cnt $lst $pp"
    if {$cnt == 7} {
        incr n
    }
}
               
puts $n
