package BRIANG::Dist::Minimal;

use 5.10.1;

use strict;
use warnings;

=head1 NAME

BRIANG::Dist::Minimal - A minimal implementation.

=head1 VERSION

This is
version 0.0101
released 2020-11-21

=cut

our $VERSION = '0.0101';

=head1 SYNOPSIS

    use BRIANG::Dist::Minimal;

    my $BDM = BRIANG::Dist::Minimal->new(7);
    say $BDM->value(); # 3.5

=head1 DESCRIPTION

This module is a component from the C<BRIANG::Dist::Perfect>
distribution.

This module uses an object-oriented approach to half numbers.

=head1 CONSTRUCTOR

=head2 new

    $object = BRIANG::Dist::Minimal->new($value)

Initialises a new C<BRIANG::Dist::Minimal> object, and returns
it. C<$value> sets the number to be halved.

=cut

sub new {
    my ($class, $initial) = @_;
    return bless {value => $initial / 2}, $class;
}

=head1 METHODS

=head2 value

    $halved_value = $BDM->value();

C<value()> returns the halved value.

=cut

sub value { shift->{value} }

=head1 AUTHOR, COPYRIGHT AND LICENSE

Copyright 2020 Brian Greenfield <briang at cpan dot org>

This is free software. You can use, redistribute, and/or modify it
under the terms laid out in the L<MIT licence|LICENCE>.

=head1 CODE REPOSITORY AND ISSUE REPORTING

This project's source code is
L<hosted|https://github.com/briang/p5-briang-dist-perfect> on
L<GitHub.com|http://github.com>.

Issues should be reported using the project's GitHub L<issue
tracker|https://github.com/briang/p5-briang-dist-perfect/issues>.

Contributions are welcome. Please use L<GitHub Pull
Requests|https://github.com/briang/p5-briang-dist-perfect/pulls>.

=cut

1;
