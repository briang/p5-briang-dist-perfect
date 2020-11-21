package BRIANG::Dist::Perfect;

use 5.10.1;

use strict;
use warnings;

=head1 NAME

BRIANG::Dist::Perfect - A perfect distribution for a perfect year. Or
perhaps not.

=head1 VERSION

This is
version 0.0101
released 2020-11-21

=cut

our $VERSION = '0.0101';

=head1 SYNOPSIS

    # Object-oriented interface

    use BRIANG::Dist::Perfect;

    my $C1 = BRIANG::Dist::Perfect->new();
    say $C1->peek();    # 0
    say $C1->counter(); # 1
    say $C1->counter(); # 2

    my $C2 = BRIANG::Dist::Perfect->new(3);
    say $C2->peek();    # 3
    say $C2->counter(); # 4
    say $C2->counter(); # 5

    say $C1->counter(); # 3
    say $C2->counter(); # 6

    # Functional interface

    use BRIANG::Dist::Perfect qw(:all);

    set(3);
    say view(); # 3
    say bump(); # 4
    say view(); # 4
    say bump(); # 5
    say bump(); # dies

=head1 DESCRIPTION

This module is the principal component from the
C<BRIANG::Dist::Perfect> distribution.

What a wonderful year 2020 has been, and to cap it off, here's my
perfect distribution.

I intend this distribution to follow every Perl best practice I
can. There is a L<section below|/SEE ALSO> with an exhaustive
collection of documentation.

This "dummy" module implements a counter accessible through a
functional or object-oriented interface.

B<Important note regarding the functional interface>

Due to limitations in the implementation, the functional
implementation cannot count beyond 5 and will throw an exception if
asked to do so.

=head1 EXPORTS

No functions are exported automaticaly, but C<bump()>, C<set()> and
C<view()> will be exported on request. Alternatively, the export tag
':all' may be used to export all three functions.

=cut

use parent 'Exporter';
our @EXPORT_OK = qw(bump set view);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

=head1 FUNCTIONS

=head2 bump

    $next_counter_value = bump()

Increases the counter by one and returns the new value.

=head3 Exceptions Thrown

C<Six encountered>

=over

Thrown whenever C<bump()> would normally have returned the value 6.

=back

=cut

my $__count;

sub bump {
    die "Six encountered"
      if $__count == 5;
    return ++ $__count;
}

=head2 set

    set($initial_value)

Initialises the counter to C<$initial_value>, or zero if
C<$initial_value> is omitted.

=head3 Exceptions Thrown

C<Six encountered>

=over

Thrown whenever C<set()> is called with C<$initial_value> >= 6.

=back

=cut

sub set {
    die "Six encountered"
      if $__count >= 6;
    $__count = shift // 0;
}

=head2 view

    $counter_value = view()

=cut

sub view { $__count }

=head1 CONSTRUCTOR

=head2 new

    $counter = BRIANG::Dist::Perfect->new($initial_value)

Initialises a new counter object, and returns it. C<$initial_value> is
optional and is used to set an initial value for the counter. Zero is
used if the argument is omitted.

=cut

sub new {
    my ($class, $initial) = (@_, 0);
    return bless {count => $initial}, $class;
}

=head1 METHODS

=head2 counter

    $next_counter_value = $counter->count()

Adds one to the counter and returns the new value.

=cut

sub counter {
    my $self = shift;
    $self->{count}++;
    return $self->{count};
}

=head2 peek

    $counter_value = $counter->peek()

Returns the value of the counter without incrementing its value.

=cut

sub peek { shift->{count} }

=head1 AUTHOR, COPYRIGHT AND LICENSE

Copyright 2020 Brian Greenfield <briang at cpan dot org>

This is free software. You can use, redistribute, and/or modify it
under the terms laid out in the L<MIT licence|LICENCE>.

=head1 SEE ALSO

L<CPAN::Meta::Spec>

L<ExtUtils::MakeMaker>

L<Release::Checklist>

L<Github Actions for Perl running on Windows, Mac OSX, and Ubuntu
Linux|https://perlmaven.com/github-actions-running-on-3-operating-systems>
by Gabor Szabo

TODO: others?

=head1 CODE REPOSITORY AND ISSUE REPORTING

This project's source code is
L<hosted|https://github.com/briang/p5-briang-dist-perfect> on
L<GitHub.com|http://github.com>.

Issues should be reported using the project's GitHub L<issue
tracker|https://github.com/briang/p5-briang-dist-perfect/issues>.

Contributions are welcome. Please use L<GitHub Pull
Requests|https://github.com/briang/p5-briang-dist-perfect/pulls>.

=head1 TODO: more pod???

=cut

1;
