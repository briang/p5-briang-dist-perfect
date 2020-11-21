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

use BRIANG::Dist::Perfect;

pass;

done_testing;