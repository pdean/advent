#!/usr/bin/perl
# vim:ft=perl:sts=4:sw=4:et

use v5.38;

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

$/ = "";

while (<>) {
    my @rows = split;
    my $m = @rows;  # number of rows
    my $n = length $rows[0]; #number of columns
    say "@rows";
    say "$m rows $n columns";

    my @lrows;
    for my $row (@rows) {
        push @lrows, [split "", $row];
    }
    my @lcols;
    for my $row (@lrows) {
        for my $col (0 .. $#{$row}) {
            push(@{$lcols[$col]}, $row->[$col]);
        }
    }
    my @cols;
    for my $col (@lcols) {
        push @cols, "@$col";
    }
    for my $col (@cols) {
        say "$col";
    }
}







say "Solution 1: $solution_1";
say "Solution 2: $solution_2";

__END__

