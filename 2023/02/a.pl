#!/usr/bin/env perl
use v5.36;
use List::Util qw(max);

my $sum = 0;

while (<>) {
    my ($game) = /(\d+)/x;
    my $maxr = max / (\d+) \s+ r/gx;
    my $maxg = max / (\d+) \s+ g/gx;
    my $maxb = max / (\d+) \s+ b/gx;

    if ($maxr <= 12 && $maxg <= 13 && $maxb <= 14) {
        $sum += $game;
    }
}
say $sum
