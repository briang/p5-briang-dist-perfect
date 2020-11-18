#!/usr/bin/env perl

use 5.010;

use strict;
use warnings;

BEGIN {
    if ($ENV{INSIDE_EMACS}) {
        chdir '..' until -d 't';
        use lib 'lib';
    }
}

if (0) {
    no strict 'refs';
    diag($_), $_->() for grep { /^test_/ } keys %::
}
################################################################################
use Test::Most qw(no_plan);

# use Data::Dump;

use BRIANG::Dist::Perfect;

my $C = BRIANG::Dist::Perfect->new();
ok $C,     'new returned something';
ok ref $C, 'new returned a reference';
is ref $C, 'BRIANG::Dist::Perfect', 'new returned an BDP object';

done_testing;
