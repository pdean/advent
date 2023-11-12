#!/usr/bin/env tclsh
#
package require fileutil
package require textutil

proc splitpar {file} {
    set data [fileutil::cat $file]
    set pars [textutil::splitx $data {\n\s*\n}]
    lmap p $pars {list {*}$p}
}

puts [join [splitpar [lindex $argv 0]] \n]
