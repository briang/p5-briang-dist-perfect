#!/usr/bin/env perl

use 5.10.1;

use strict;
use warnings;

use Test::More;

use BRIANG::Dist::Perfect;

my $C1 = BRIANG::Dist::Perfect->new();
is $C1->peek(),    0, "first counter initialised to 0";
is $C1->counter(), 1, "first counter is incremented to 1";
is $C1->counter(), 2, "first counter is incremented to 2";

my $C2 = BRIANG::Dist::Perfect->new(3);
is $C2->peek(),    3, "second counter initialised to 3";
is $C2->counter(), 4, "second counter is incremented to 4";
is $C2->counter(), 5, "second counter is incremented to 5";

is $C1->counter(), 3, "first counter is incremented to 3";
is $C2->counter(), 6, "second counter is incremented to 6";

done_testing;
