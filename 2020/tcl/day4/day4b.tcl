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

proc valid {code val} {
    if {$code eq "byr"} {
        if {[string is integer -strict $val] 
            && $val >= 1920 
            && $val <= 2002} {
                return 1
        } else {return 0}
    }
    if {$code eq "iyr"} {
        if {[string is integer -strict $val] 
            && $val >= 2010 
            && $val <= 2020} {
                return 1
        } else {return 0}
    }
    if {$code eq "eyr"} {
        if {[string is integer -strict $val] 
            && $val >= 2020 
            && $val <= 2030} {
                return 1
        } else {return 0}
    }
    if {$code eq "hgt"} {
        if {[regexp {^(\d+)in$} $val junk x]} {
            if {$x >=59 && $x <=76} {
                return 1
            } else {return 0}
        } elseif {[regexp {^(\d+)cm$} $val junk x]} {
            if {$x >=150 && $x <=193} {
                return 1
            } else {return 0}
        } else {return 0}
    }
    if {$code eq "hcl"} {
        if {[regexp {^#[0-9a-f]{6}$} $val]} {
            return 1
        } else {return 0}
    }
    if {$code eq "ecl"} {
        if {[regexp {amb|blu|brn|gry|grn|hzl|oth} $val]} {
            return 1
        } else {return 0}
    }
    if {$code eq "pid"} {
        if {[regexp {^[0-9]{9}$} $val]} {
            return 1
        } else {return 0}
    }
    return 0
}

set n 0
foreach pp $pps {
    set lst [lmap a $pp {
        lassign [split $a :] b v
        if {$b in  $req} {
            if {[valid $b $v]} {
                expr 1
            } else {expr 0}
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
