#!/usr/bin/perl
# vim:ft=perl:sts=4:sw=4:et

use v5.38;
use List::Util      qw(all max min);
use List::MoreUtils qw(slide);

@ARGV = "input" unless @ARGV;

my $solution_1 = 0;
my $solution_2 = 0;

while (<>) {
    my @levels = split;
    if ( check(@levels) ) {
        ++$solution_1;
        ++$solution_2;
    }
    else {
        for my $i ( 0 .. $#levels ) {
            my @temp = @levels;
            splice @temp, $i, 1;
            if ( check(@temp) ) {
                ++$solution_2;
                last;
            }
        }
    }
    say "";
}

say "Solution 1: $solution_1";
say "Solution 2: $solution_2";

sub check {
    my @levels = @_;
    my @diffs  = slide { $b - $a } @levels;
    my $len    = @diffs;
    my $pos    = grep { $_ > 0 } @diffs;
    my $neg    = grep { $_ < 0 } @diffs;
    my $zero   = grep { $_ == 0 } @diffs;
    my $max    = grep { abs($_) > 3 } @diffs;
    my $errs   = $max + $zero;

    if ( ( ( $pos == $len ) || ( $neg == $len ) ) && ( $errs == 0 ) ) {
        say "@levels";
        say "@diffs";
        say "$len $pos $neg $max $zero $errs";
        return 1;
    }
    return 0;
}
__END__

