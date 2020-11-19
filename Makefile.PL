use strict;
use warnings;

use ExtUtils::MakeMaker 6.48; # MIN_PERL_VERSION

my $module       = 'BRIANG::Dist::Perfect';
my $min_perl     = '5.10.1';

(my $path_to_main = sprintf 'lib/%s.pm', $module) =~ s|::|/|g; # lib/BRIANG::Dist/Perfect.pm
(my $dist_name    = $module) =~ s/::/-/g;                      # BRIANG-Dist-Perfect
my $github_name   = sprintf 'p5-%s', lc $dist_name;            # p5-briang-dist-perfect

WriteMakefile(
    NAME             => $module,
    AUTHOR           => 'Brian Greenfield <briang@cpan.org>',
    VERSION_FROM     => $path_to_main,
    ABSTRACT_FROM    => $path_to_main,
    LICENSE          => 'MIT',
    PL_FILES         => {},
    MIN_PERL_VERSION => $min_perl,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.48',
    },
    BUILD_REQUIRES     => {
        # 'Inline::C' => '0'
    },
    TEST_REQUIRES      => {
        'Test::Exception' => 0,
        'Test::More'      => 0,
    },
    PREREQ_PM => {
        'Exporter' => 0,
        'parent'   => 0,
        'strict'   => 0,
        'warnings' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => "$dist_name-*" },
    META_MERGE         => {
        'meta-spec'    => { version => 2 },
        resources      => {
            bugtracker => {
                web    => "https://github.com/briang/$github_name/issues"
            },
            homepage   => "https://github.com/briang/$github_name",
            repository => {
                type   => 'git',
                url    => "git://github.com/briang/$github_name.git",
                web    => "https://github.com/briang/$github_name",
            },
        },
    },
);
