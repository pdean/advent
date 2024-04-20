#!/usr/bin/env perl
use v5.10;

my @words = qw( one two three four five six seven eight nine);
my @digits = (1..9);
my @keys = (@digits,@words);
my @vals = (@digits,@digits);
my %hash = map {($keys[$_],$vals[$_])} (0 .. $#keys);
say "@{[%hash]}";
my $re = join '|',@keys;
my $sum = 0;

while (<>) {
    my ($d1) = /  ($re)/x;
    my ($d2) = /.*($re)/x;
    $sum += "$hash{$d1}$hash{$d2}";
}
say $sum;
