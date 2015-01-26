#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'tests' => 14;
BEGIN { use_ok('Pod::WSDL::Attr') }

eval { my $a1 = Pod::WSDL::Attr->new(); };

ok( defined $@, 'new dies, if it does not get a string' );

eval { my $a1 = Pod::WSDL::Attr->new('myAttr $string _NEEDED blah blah ...'); };

ok( defined $@, 'new dies, if it does not get a string beginning with _ATTR' );

eval {
    my $a1 = Pod::WSDL::Attr->new('_ATTR myAttr string _NEEDED blah blah ...');
};

ok( defined $@, 'new dies, if array/scalar type is not specified' );

my $a1 = Pod::WSDL::Attr->new('_ATTR myAttr $string _NEEDED blah blah ...');

ok( $a1->name eq 'myAttr',         'Read name correctly from input' );
ok( $a1->type eq 'string',         'Read type correctly from input' );
ok( $a1->array == 0,               'Read scalar type correctly from input' );
ok( $a1->descr eq 'blah blah ...', 'Read descr correctly from input' );

no warnings;
ok( $a1->nillable == undef, 'Read _NEEDED correctly from input' );
use warnings;

$a1 = Pod::WSDL::Attr->new('   _ATTR myAttr $string _NEEDED blah blah ...');
ok( $a1->name eq 'myAttr', 'Handles whitespace before _ATTR correctly.' );

$a1 = Pod::WSDL::Attr->new('_ATTR myAttr @string _NEEDED blah blah ...');
ok( $a1->array == 1, 'Read array type correctly from input' );

$a1 = Pod::WSDL::Attr->new('_ATTR myAttr @string blah blah etc ...');
ok(
    $a1->nillable eq 'true' && $a1->descr eq 'blah blah etc ...',
    'Read descr correctly from input without needed'
);

$a1 = Pod::WSDL::Attr->new('_ATTR myAttr @string _NEEDED');
ok( $a1->descr eq q{}, 'No description is handled correctly' );

eval { $a1->name('foo'); };

{
    no warnings;
    ok( $@ == undef, 'Renaming attr is forbidden.' );
}
