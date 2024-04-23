#!/usr/bin/env perl

use v5.26;
use warnings;

my $sum;

my %h = (one => 1, two => 2, three => 3, four => 4, five => 5, six => 6, seven => 7, eight => 8, nine => 9);

for (<>) {
        /([1-9]|one|two|three|four|five|six|seven|eight|nine)/;
        $sum += ($h{$1} // $1) * 10;

        /.*([1-9]|one|two|three|four|five|six|seven|eight|nine)/;
        $sum += $h{$1} // $1;
}

say $sum;
