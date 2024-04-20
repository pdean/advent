#!/usr/bin/env perl
use v5.10;

my $sum;

while (<>) {
    my ($d1) = /  ([1-9])/x;
    my ($d2) = /.*([1-9])/x;
    $sum += "$d1$d2";
}
say $sum;
