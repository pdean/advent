#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec tclsh "$0" ${1+"$@"}

#----------------------------------------------------------------------
# Key phrases from the site www.adventofcode.com have been taken as
# requirement statements, and have been embedded in the code as comments
# to serve as inline documentation.  Where I remember to, I have hash-bang
# commented them (#!), but I will gladly credit any place I have missed.
# All copyright on those text sections is assigned to the writers behind
# adventofcode.com.  They are quoted in this code file under fair use as 
# part of my contribution to the online contest of which they are the 
# source, wherein my part is the Tcl code implementing them.
# 
# All code and other comments are Copyright 2020, Erik N. Johnson.
# This software is distributed under the [MIT 3-clause license](./license.ENJ.txt).
#----------------------------------------------------------------------

# Get input from file
set fhandle [open "advent13.txt"]
#set fhandle [open "input0"]
#set fhandle [open "tmp.txt"]
set inData [read -nonewline $fhandle]
close $fhandle

#
# --- Day 13: Shuttle Search --- 
#
#! Fortunately, a shuttle bus service is available to bring you from the sea 
#! port to the airport! Each bus has an ID number that also indicates how often 
#! the bus leaves for the airport.
#! 
#! Bus schedules are defined based on a timestamp that measures the number of 
#! minutes since some fixed reference point in the past. At timestamp 0, every 
#! bus simultaneously departed from the sea port. After that, each bus travels 
#! to the airport, then various other locations, and finally returns to the sea 
#! port to repeat its journey forever.
#! 
#! The time this loop takes a particular bus is also its ID number: the bus 
#! with ID 5 departs from the sea port at timestamps 0, 5, 10, 15, and so on. 
#! The bus with ID 11 departs at 0, 11, 22, 33, and so on. If you are there 
#! when the bus departs, you can ride that bus to the airport!
#! 
#! Your notes (your puzzle input) consist of two lines. The first line is your 
#! estimate of the earliest timestamp you could depart on a bus. The second 
#! line lists the bus IDs that are in service according to the shuttle company; 
#! entries that show x must be out of service, so you decide to ignore them.

#
# Part 1
#
#! What is the ID of the earliest bus you can take to the airport multiplied by 
#! the number of minutes you'll need to wait for that bus?

# the time to first bus per id is add id to timestamp then reduce by the offset 
# to the intervening modulo.
lassign [split $inData "\n"] timestamp idCsv
set idL [split $idCsv ","]

puts "Bus IDs are:\n $idL\n"

# Compute first time after timestamp for each ID, leaving x's so id/index 
# relationship not lost.
set firstL [lmap id $idL {
    expr {($id eq "x" ) ? "x" : (($timestamp + $id) - (($timestamp + $id) % $id)) }
}]

# compute smallest "first", ignoring x's.  Back-extract the IDs.
set first [::tcl::mathfunc::min {*}[lsearch -inline -not -all $firstL "x"]]
set wait [expr {$first - $timestamp}]
set id [lindex $idL [lsearch $firstL $first]]

puts "first is $first, wait is $wait.  Solution is [expr {$id * $wait}]\n"


#
# Part 2
#
#! one gold coin for anyone that can find the earliest timestamp such that the 
#! first bus ID departs at that time and each subsequent listed bus ID departs 
#! at that subsequent minute. (The first line in your input is no longer 
#! relevant.)
#
#! What is the earliest timestamp such that all of the listed bus IDs depart at 
#! offsets matching their positions in the list?

set idx -1
set maxId 0
foreach id $idL {
    incr idx
    if {$id eq "x"} continue
    lappend modL $id [expr {($id - $idx) % $id}]
}
puts $modL

# Brute force is too slow.  I can't come up with a decent closed-form 
# mathematical approach.  So let's get clever and try an iterative mathematical
# approach.

# I'm going to try syncing up one ID at a time. For each ID in the modulo list,
# start with the last sync point and advance the time by modulo(all the synced
# IDs) until the next ID is in sync.  Take that as the next starting point, 
# multiply the master modulo by the newly sync'ed ID, and iterate.

# It is likely to be faster if I start with the largest IDs first, so sort.
set sortL [lsort -integer -stride 2 $modL]
set accumMod 1
set timestamp 0
foreach {mod tgt} $sortL {
    puts "looking for Bus ID $mod, starting at $timestamp"
    while {($timestamp % $mod) != $tgt} {
        incr timestamp $accumMod
    }
    set accumMod [expr {$accumMod * $mod}]
    puts "At $timestamp: Bus $mod is at target $tgt, accumulated modulo goes to $accumMod\n"
}

puts "Timestamp is $timestamp"


exit

# below here is the original brute force version

set timestamp $startTime
set done false
while {!$done} {
    incr timestamp $maxId
if {$timestamp % 1000000 == 0} {puts $timestamp}
    set bk false
    foreach {mod tgt} $modL {
        if {($timestamp % $mod) != $tgt} {
            set bk true
        }
    }
    if {$bk} continue
    puts "Found!"
    set done true
}

puts "Timestamp is $timestamp"
