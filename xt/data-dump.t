use FindBin;
use lib "$FindBin::Bin/../lib";

use 5.10.1;

use strict; use warnings;

use Cwd ();
use File::Find::Rule;
use Test::More tests => 1;

my @perl_files = File::Find::Rule
    ->file
    ->name( '*.pl', '*.pm', '*.t', 'Makefile.PL' )
    ->in( "$FindBin::Bin/.." );

my $data_dump = "Data\:\:Dump";

my $ok = 1;
for my $perl_file ( map { Cwd::abs_path($_) } sort @perl_files ) {
    open my $IN, "<", $perl_file
        or die qq(cannot read "$perl_file": $!);

    while (<$IN>) {
        if ( /$data_dump/ ) {
            diag "$data_dump found in"
                if $ok;
            diag "  $perl_file";
            $ok = 0;
            last;
        }
    }
}

ok $ok, qq("$data_dump" not used in project);
