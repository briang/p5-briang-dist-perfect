#!/usr/bin/env perl

use 5.10.1;

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
use Test::More;

# use Data::Dump;

use BRIANG::Dist::Minimal;

my $M = BRIANG::Dist::Minimal->new(5);
ok $M,     'new returned something';
ok ref $M, 'new returned a reference';
is ref $M, 'BRIANG::Dist::Minimal', 'new returned an BDM object';

is $M->value(), 2.5, "halfing 5 gets 2.5";

done_testing;
