#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'tests' => 13;
BEGIN { use_ok('Pod::WSDL::Type') }

my $attrData;
{
    local $/ = undef;
    $attrData = <DATA>;
}

eval { my $a1 = Pod::WSDL::Type->new(); };

ok( defined $@, 'new dies, if it does not get a name parameter' );

my $a1 = Pod::WSDL::Type->new(
    'name'  => 'my::foo',
    'array' => 1,
    'descr' => 'blah ...',
    'pod'   => $attrData,
);

ok( $a1->name eq 'my::foo',   'Red name argument correctly' );
ok( $a1->wsdlName eq 'MyFoo', 'Made wsdl name correctly' );
ok( $a1->array == 1,          'Red array argument correctly' );
ok( $a1->descr eq 'blah ...', 'Red descr argument correctly' );
ok( @{ $a1->attrs } == 6,     'Seem to parse pod correctly' );
ok( ( $a1->attrs )->[0]->name eq '_ID',                     '... yes' );
ok( ( $a1->attrs )->[0]->type eq 'string',                  '... yes' );
ok( ( $a1->attrs )->[3]->descr eq 'Additional information', '... indeed' );

$a1 = Pod::WSDL::Type->new( 'name' => 'My::foo' );

ok( $a1->array == 0,  'Default for array works' );
ok( $a1->descr eq q{}, 'Handling lack of description works' );

eval { $a1->name('bar'); };

{
    no warnings;
    ok( $@ == undef, 'Renaming type is forbidden' );
}

__DATA__
	_ATTR _ID       $string             Word's ID
	_ATTR _citation $string     _NEEDED Word's citation form
	_ATTR _grammar  $string             Grammatical information
	_ATTR _addInfo  $string             Additional information
	_ATTR _language $string     _NEEDED Word's language as 2-letter ISO code
	_ATTR _user     $Voko::User _NEEDED Word's owner
