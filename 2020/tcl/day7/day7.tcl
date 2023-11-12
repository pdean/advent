namespace path [list ::tcl::mathop ::tcl::mathfunc]

set in [open input r]
set data [split [read -nonewline $in] \n]
close $in

set bags [list]

foreach line $data {
    regexp {(.*) bags contain (.*)} $line junk con tents
    dict set bags $con $tents
}

set total [list]

proc container {bags x} {

    global total 

    foreach bag [dict keys $bags] {
        set contents [dict get $bags $bag]
        if {[regexp $x $contents]} {
            puts "$bag ->  $contents"
            lappend total $bag
            container $bags $bag
        }
    }
}


container $bags "shiny gold"

puts  [llength [lsort -unique $total]]

