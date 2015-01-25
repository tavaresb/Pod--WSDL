package Pod::WSDL::Param;

# ABSTRACT: Represents the WSDL pod for a parameter of a method (internal use only)

use strict;
use warnings;

use base 'Pod::WSDL::AUTOLOAD';

use Carp;

our %FORBIDDEN_METHODS = ( 'name'      => { 'get' => 1, 'set' => 0 },
                           'type'      => { 'get' => 1, 'set' => 0 },
                           'paramType' => { 'get' => 1, 'set' => 0 },
                           'descr'     => { 'get' => 1, 'set' => 0 },
                           'array'     => { 'get' => 1, 'set' => 0 },
);

sub new {
    my ( $pkg, $str ) = @_;

    defined $str or $str = q{};    # avoids warnings, dies soon
    $str =~ s/\s*_(INOUT|IN|OUT)\s*//i
        or croak
        "Input string '$str' does not begin with '_IN', '_OUT' or '_INOUT'";

    my $paramType = $1;

    my ( $name, $type, $descr ) = split /\s+/, $str, 3;

    $type ||= q{};                 # avoids warnings, dies soon

    $type =~ /([\$\@])(.+)/;
    croak
        "Type '$type' must have structure (\$|@)<typename>, e.g. '\$boolean' or '\@string', not '$type' died"
        unless $1 and $2;

    return
        bless { '_name'      => $name,
                '_type'      => $2,
                '_paramType' => $paramType,
                '_descr'     => $descr || q{},
                '_array'     => $1 eq q{@} ? 1 : 0,
        }, $pkg;
}

1;
__END__

=head1 SYNOPSIS

  use Pod::WSDL::Param;
  my $param = new Pod::WSDL::Param('_IN myParam $string This parameter is for blah ...');

=head1 DESCRIPTION

This module is used internally by Pod::WSDL. It is unlikely that you have to interact directly with it. If that is the case, take a look at the code, it is rather simple.

=head1 METHODS

=head2 new

Instantiates a new Pod::WSDL::Param. The method needs one parameter, the _IN, _OUT or _INOUT string from the pod. Please see SYNOPSIS or the section "Pod Syntax" in the description of Pod::WSDL.

=head1 EXTERNAL DEPENDENCIES

  [none]

=head1 EXAMPLES

see Pod::WSDL

=head1 BUGS

see Pod::WSDL

=head1 TODO

see Pod::WSDL

=head1 SEE ALSO

  Pod::WSDL
 
=cut
