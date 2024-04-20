#!/usr/bin/env perl
use v5.10;

my @words  = qw( one two three four five six seven eight nine);
my @digits = (1..9);
my @keys   = (@digits,@words);
my @vals   = (@digits,@digits);
my %dict   = map {($keys[$_],$vals[$_])} (0 .. $#keys);
my $re     = join '|',@keys;
my $sum    = 0;

say "@{[%dict]}";

while (<>) {
    my ($d1) = /  ($re)/x;
    my ($d2) = /.*($re)/x;
    $sum += "$dict{$d1}$dict{$d2}";
}
say $sum;
