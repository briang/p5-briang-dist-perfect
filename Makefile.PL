#!/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker 6.48; # MIN_PERL_VERSION

my $module       = 'BRIANG::Dist::Perfect';
my $min_perl     = '5.14.0'; # s///r modifier

my $path_to_main = "lib/$module.pm" =~ s|::|/|gr; # lib/BRIANG/Dist/Perfect.pm
my $dist_name    = $module =~ s/::/-/gr;          # BRIANG-Dist-Perfect
my $github_name  = "p5-\L$dist_name";             # p5-briang-dist-perfect

my %WriteMakefileArgs = (
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
        'Test::More'      => '0.22',
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

my $eumm_version  = eval $ExtUtils::MakeMaker::VERSION;

for (qw(configure build test runtime)) {
  my $key = $_ eq 'runtime' ? 'PREREQ_PM' : uc $_.'_REQUIRES';
  next unless exists $WriteMakefileArgs{META_ADD}{prereqs}{$_}
           or exists $WriteMakefileArgs{$key};
  my $r = $WriteMakefileArgs{$key} = {
    %{$WriteMakefileArgs{META_ADD}{prereqs}{$_}{requires} || {}},
    %{delete $WriteMakefileArgs{$key} || {}},
  };
  defined $r->{$_} or delete $r->{$_} for keys %$r;
}

# dynamic prereqs get added here.

# $WriteMakefileArgs{MIN_PERL_VERSION} = delete $WriteMakefileArgs{PREREQ_PM}{perl} || 0;

die 'attention developer: you need to do a sane meta merge here!'
  if keys %{$WriteMakefileArgs{BUILD_REQUIRES}};

$WriteMakefileArgs{BUILD_REQUIRES} = {
    %{$WriteMakefileArgs{BUILD_REQUIRES} || {}},
    %{delete $WriteMakefileArgs{TEST_REQUIRES}}
} if $eumm_version < 6.63_03;

$WriteMakefileArgs{PREREQ_PM} = {
    %{$WriteMakefileArgs{PREREQ_PM}},
    %{delete $WriteMakefileArgs{BUILD_REQUIRES}}
} if $eumm_version < 6.55_01;

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  if $eumm_version < 6.51_03;

delete $WriteMakefileArgs{MIN_PERL_VERSION}
  if $eumm_version < 6.48;

delete @WriteMakefileArgs{qw(META_ADD META_MERGE)}
  if $eumm_version < 6.46;

delete $WriteMakefileArgs{LICENSE}
  if $eumm_version < 6.31;

sub MY::postamble {
    my $extra_targets = join "\n", (
        '.PHONY: alltests xtests trial coverage',
        'trial: dist',
        '    mv $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME)-TRIAL.tar$(SUFFIX)',
        '',
        'xtests:',
        '    prove -l xt',
        '',
        'alltests:',
        '    prove -l t xt',
        '',
        qx(which cover) ? ( 'coverage:', '  cover -test' ) : ()
    );
    $extra_targets =~ s{^[ \t]+}{\t}gm;

    return $extra_targets;
}

WriteMakefile(%WriteMakefileArgs);

my $dd = 'Data::' . 'Dump';
if (eval "require $dd; 1") {
    no strict 'refs';
    "${dd}::dd"->( \%WriteMakefileArgs );
}
