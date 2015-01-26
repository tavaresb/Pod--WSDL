#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'tests' => 11;
BEGIN { use_ok('Pod::WSDL::Return') }

eval { my $a1 = Pod::WSDL::Return->new(); };

ok( defined $@, 'new dies, if it does not get a string' );

eval { my $a1 = Pod::WSDL::Return->new('$string blah blah ...'); };

ok( defined $@,
    'new dies, if it does not get a string beginning with _RETURN' );

eval { my $a1 = Pod::WSDL::Return->new('_RETURN string blah blah ...'); };

ok( defined $@, 'new dies, if array/scalar type is not specified' );

my $a1 = Pod::WSDL::Return->new('_RETURN $string blah blah ...');

ok( $a1->type eq 'string',         'Read type correctly from input' );
ok( $a1->array == 0,               'Read scalar type correctly from input' );
ok( $a1->descr eq 'blah blah ...', 'Read descr correctly from input' );

$a1 = Pod::WSDL::Return->new('   _RETURN $string blah blah ...');
ok( $a1->type eq 'string', 'Handles whitespace before _RETURN correctly.' );

$a1 = Pod::WSDL::Return->new('_RETURN @string blah blah ...');
ok( $a1->array == 1, 'Read array type correctly from input' );

$a1 = Pod::WSDL::Return->new('_RETURN @string');
ok( $a1->descr eq q{}, 'No description is handled correctly' );

eval { $a1->type('foo'); };

{
    no warnings;
    ok( $@ == undef, 'Renaming return type is forbidden.' );
}
