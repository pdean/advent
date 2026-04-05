#!/usr/bin/env perl

use 5.020;

while (<>) {
    my ($day, $both, $part1) = split ' ';
    say "$day\t$both\t$part1\t", sprintf("%.0f\%", ($both - $part1)/$both*100);
}

