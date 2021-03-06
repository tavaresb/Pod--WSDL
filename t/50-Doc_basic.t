#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'tests' => 7;
BEGIN { use_ok('Pod::WSDL::Doc') }

eval { my $a1 = Pod::WSDL::Doc->new(); };

ok( defined $@, 'new dies, if it does not get a string' );

eval { my $a1 = Pod::WSDL::Doc->new('blah blah ...'); };

ok( defined $@, 'new dies, if it does not get a string beginning with _DOC' );

my $a1 = Pod::WSDL::Doc->new('_DOC blah blah ...');

ok( $a1->descr eq 'blah blah ...', 'Read descr correctly from input' );

$a1 = Pod::WSDL::Doc->new('   _DOC blah blah ...');
ok( $a1->descr eq 'blah blah ...',
    'Handles whitespace before _DOC correctly.' );

$a1 = Pod::WSDL::Doc->new('_DOC');
ok( $a1->descr eq q{}, 'No description is handled correctly' );

$a1->descr('more blah');
ok( $a1->descr eq 'more blah', 'Setting description works' );
