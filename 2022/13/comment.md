I'm disappointed that I rarely see any tcl solutions. I'm coming late to this because I wanted some practice before this year's aoc. I managed 31 in 2020, but been busy since.

Anyhow I got stumped on day 13 and resented the fact that other languages seemed to parse the input for them. Then I realised that it looked like json. This led to quite an elegant solution. You guys might be interested.


    #!/usr/bin/env tclsh
    # vim:sts=4:sw=4:tw=80:et:ft=tcl 

    namespace path ::tcl::mathop
    package require json

    proc tcl {l} {
        set json [string cat "{ \"list\": " $l " }"]
        set dict [::json::json2dict $json]
        dict get $dict list
    }

    proc cmp {L R} {
        foreach l $L r $R {
            set nl [llength $l] 
            set nr [llength $r]
            if {$nl == 0 && $nr != 0} {
                return -1
            } elseif {$nl == 0 && $nr == 0} {
                set res 0
            } elseif {$nl != 0 && $nr == 0} {
                 return 1
            } elseif {[string is integer $l] && 
                      [string is integer $r]} { 
                if {$l < $r} {return -1}
                if {$l > $r} {return 1} 
                set res 0
            } else {
                set res [cmp $l $r]
            }
            if {!$res} continue
            return $res
        }
        return 0
    }

    proc run {input} {
        set in [open $input r]
        set data [read -nonewline $in]
        close $in
        set pkts [lmap p [split [regsub -all \n\s*\n $data \n] \n] {tcl $p}]

        set n 0
        set sum 0
        foreach {L R} $pkts {
            incr n
            set res [cmp $L $R] 
            if {$res < 0} { incr sum $n }
        }
        puts $sum 

        set p2 [tcl {[[2]]}]
        set p6 [tcl {[[6]]}]
        lappend pkts $p2 $p6
        set pkts [lsort -command cmp $pkts]
        puts [* [+ 1 [lsearch $pkts $p2]] [+ 1 [lsearch $pkts $p6]]]
    }

    run [lindex $argv 0]
