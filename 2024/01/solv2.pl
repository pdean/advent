#!/usr/bin/perl
# vim:ft=perl:sts=4:sw=4:et

use v5.38;
use List::Util qw[mesh];

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

my ( @l, @r, %t );

while (<>) {
    my ( $l, $r ) = split;
    push @l, $l;
    push @r, $r;
    $t{$r}++;
}

@l = sort { $a <=> $b } @l;
@r = sort { $a <=> $b } @r;

for my ( $l, $r ) ( mesh \@l, \@r ) {
    $solution_1 += abs( $r - $l );
}

for my $l (@l) {
    $solution_2 += $l * ( $t{$l} // 0 );
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";

__END__

