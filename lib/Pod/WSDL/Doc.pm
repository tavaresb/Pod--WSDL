package Pod::WSDL::Doc;

# ABSTRACT: Represents the WSDL pod for the documentation of methods (internal use only)

use strict;
use warnings;

use base 'Pod::WSDL::AUTOLOAD';
use Carp;

sub new {
    my ( $pkg, $str ) = @_;

    $str ||= q{};    # avoids warnings
    if ( $str !~ /\s*_DOC\s*(.*)/ ) {
        carp
            q{_DOC statements must have structure '_DOC <text>', like '_DOC This is my documentation'};
    }

    return bless { '_descr' => $1 || q{} }, $pkg;
}

1;
__END__

=head1 SYNOPSIS

  use Pod::WSDL::Doc;
  my $doc = new Pod::WSDL::Doc('_DOC This method is for blah ...');

=head1 DESCRIPTION

This module is used internally by Pod::WSDL. It is unlikely that you have to interact directly with it. If that is the case, take a look at the code, it is rather simple.

=head1 METHODS

=head2 new

Instantiates a new Pod::WSDL::Attr. The method needs one parameter, the documentation string from the pod. Please see SYNOPSIS or the section "Pod Syntax" in the description of Pod::WSDL.

=head1 EXTERNAL DEPENDENCIES

  [none]

=head1 EXAMPLES

see Pod::WSDL

=head1 BUGS

see Pod::WSDL

=head1 TODO

see Pod::WSDL

=head1 SEE ALSO

  Pod::WSDL :-)
 
=cut
