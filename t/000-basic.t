#!/usr/bin/env perl

use 5.10.1;

use strict;
use warnings;

use Test::More;

use BRIANG::Dist::Perfect;

my $C = BRIANG::Dist::Perfect->new();
ok $C,     'new returned something';
ok ref $C, 'new returned a reference';
is ref $C, 'BRIANG::Dist::Perfect', 'new returned an BDP object';

done_testing;
