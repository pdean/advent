#!/usr/bin/perl
# vim:ft=perl:sts=4:sw=4:et

use v5.38;
use List::Util qw[mesh];

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

my ( @l, @r );

while (<>) {
    chomp;
    my ( $l, $r ) = split;
    push @l, $l;
    push @r, $r;
}

@l = sort { $a <=> $b } @l;
@r = sort { $a <=> $b } @r;

for my ( $l, $r ) ( mesh \@l, \@r ) {
    $solution_1 += abs( $r - $l );
}

my %t;
for my $r (@r) {
    $t{$r}++;
}

for my $l (@l) {
    my $n = $t{$l} // 0;
    $solution_2 += $l * $n;
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";

__END__

