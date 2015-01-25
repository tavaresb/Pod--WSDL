package Pod::WSDL::Attr;

# ABSTRACT: Represents the WSDL pod for an attribute of a class (internal use only)

use strict;
use warnings;
use base 'Pod::WSDL::AUTOLOAD';

use Carp;

our %FORBIDDEN_METHODS = ( 'name'     => { 'get' => 1, 'set' => 0 },
                           'type'     => { 'get' => 1, 'set' => 0 },
                           'nillable' => { 'get' => 1, 'set' => 0 },
                           'descr'    => { 'get' => 1, 'set' => 0 },
                           'array'    => { 'get' => 1, 'set' => 0 },
);

sub new {
    my ( $pkg, $str ) = @_;

    defined $str or $str = q{};    # avoids warnings
    $str =~ s/\s*_ATTR\s*//i
        or croak "Input string '$str' does not begin with '_ATTR'";

    my ( $name, $type, $needed, $descr ) = split /\s+/, $str, 4;

    $descr ||= q{};

    if ( ( uc $needed ) ne '_NEEDED' ) {
        $descr  = "$needed $descr";
        $needed = 0;
    }
    else {
        $needed = 1;
    }

    if ( $type !~ /([\$\@])(.*)/ ) {
        croak "Type '$type' must be prefixed with either '\$' or '\@', ddieied";
    }
    my ( $arrob, $the_type ) = ( $1, $2 );

    return
        bless { '_name'     => $name,
                '_type'     => $the_type,
                '_nillable' => $needed ? undef : 'true',
                '_descr'    => $descr,
                '_array'    => $arrob eq q{@} ? 1 : 0,
        }, $pkg;
}

1;
__END__

=head1 SYNOPSIS

  use Pod::WSDL::Attr;
  my $attr = new Pod::WSDL::Attr('_ATTR $string _NEEDED This attribute is for blah ...');

=head1 DESCRIPTION

This module is used internally by Pod::WSDL. It is unlikely that you have to interact directly with it. If that is the case, take a look at the code, it is rather simple.

=head1 METHODS

=head2 new

Instantiates a new Pod::WSDL::Attr. The method needs one parameter, the attribute string from the pod. Please see SYNOPSIS or the section "Pod Syntax" in the description of Pod::WSDL.

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
