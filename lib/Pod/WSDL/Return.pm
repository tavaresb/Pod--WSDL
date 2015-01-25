package Pod::WSDL::Return;

# ABSTRACT: Represents the WSDL pod for the return value of a method (internal use only)

use strict;
use warnings;
use base 'Pod::WSDL::AUTOLOAD';

use Carp;

our %FORBIDDEN_METHODS = ( 'type'  => { 'get' => 1, 'set' => 0 },
                           'array' => { 'get' => 1, 'set' => 0 },
                           'descr' => { 'get' => 1, 'set' => 0 },
);

sub new {
    my ( $pkg, $str ) = @_;

    $str ||= q{};    # avoids warnings, dies soon
    $str =~ s/\s*_RETURN\s*//i;
    my ( $type, $descr ) = split /\s+/, $str, 2;

    $type ||= q{};    # avoids warnings, dies soon

    if ( $type !~ /([\$\@])(.+)/ ) {
        croak q{Type '} . $type
            . q{' must have structure ($|@)<typename>, e.g. '$boolean' or '@string', died };
    }
    my $the_type   = $2;
    my $array_char = $1;

    return
        bless { '_type'  => $the_type,
                '_descr' => $descr || q{},
                '_array' => $array_char eq q{@} ? 1 : 0,
        }, $pkg;
}

1;
__END__

=head1 SYNOPSIS

  use Pod::WSDL::Return;
  my $return = new Pod::WSDL::Return('_RETURN $string This returns blah ...');

=head1 DESCRIPTION

This module is used internally by Pod::WSDL. It is unlikely that you have to interact directly with it. If that is the case, take a look at the code, it is rather simple.

=head1 METHODS

=head2 new

Instantiates a new Pod::WSDL::Param. The method needs one parameter, the _RETURN string from the pod. Please see SYNOPSIS or the section "Pod Syntax" in the description of Pod::WSDL.

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
