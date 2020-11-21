use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More;
use Test::Pod::Coverage;

for my $package (qw"BRIANG::Dist::Perfect BRIANG::Dist::Minimal") {
    pod_coverage_ok( $package, "$package is covered" );
}

done_testing;
