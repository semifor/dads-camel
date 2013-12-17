#!/usr/bin/env perl
use 5.12.1;
use warnings;
use lib 'lib';
use Lingua::EN::Inflect qw/WORDLIST PL_V/;

use Beer::DB;

my $schema = Beer::DB->connect('dbi:SQLite:dbname=tmp/beer.db');
$schema->deploy({ add_drop_table => 1 });

# bulk_insert some breweries and beers
$schema->populate(Brewery => [
    [ qw/name beers/ ],
    [ 'Coors', [
        { style => 'lager', name => 'Coors', description => 'Banquet Beer' },
        { style => 'lager', name => 'Coors Light' },
    ]],
    [ '12 String Brewing', [
        { style => 'ipa',   name => 'Electric Slide IPA' },
        { style => 'ipa',   name => 'Jam Session IPA' },
        { style => 'stout', name => 'Drop D Stout' },
    ]],
    [ 'Stella Artois', [
        { style => 'lager', name => 'Stella Artois' },
    ]],
    [ 'Deschutes Brewery', [
        { style => 'ale',    name => 'Pond Pale Ale' },
        { style => 'ipa',    name => 'Inversion IPA' },
        { style => 'stout',  name => 'Obsidian Stout' },
        { style => 'porter', name => 'Black Butte Porter' },
    ]],
]);

# add some users in a single transaction
$schema->txn_do(sub {
    for my $rs ( $schema->resultset('User') ) {
        for my $name ( qw/Marc Martin Casey Peter/ ) {
            $rs->create({ name => $name });
        }
    }
});

# Martin and Peter drink Stella
$schema->txn_do(sub {
    my $users =
        $schema->resultset('User')
        ->search({ name => { -in => [ qw/Peter Martin/ ] }});

    my $beer =
        $schema->resultset('Beer')
        ->search({ name => { -like => 'Stella%' }})
        ->first;

    $_->add_to_likes($beer) for $users->all;
});

# Marc likes all the beers!
$schema->txn_do(sub {
    # primary key search
    my $user = $schema->resultset('User')->find(1);
    my $rs = $schema->resultset('Beer')->search;
    while ( my $beer = $rs->next ) {
        $user->add_to_likes($beer);
    }

    # create rows in brewery, beer, and user_beer!
    $user->add_to_likes({
        name    => 'Guinness Extra Stout',
        style   => 'stout',
        brewery => {
            name => 'Guinness Ltd.',
        },
    });
});

{
    # Who likes Stella
    my $beer =
        $schema->resultset('Beer')->search(
            { 'me.name' => { -like => 'Stella%' }},
            { prefetch => 'brewery' },
        )->first;


    my @fans = $beer->users->search({}, { order_by => 'name' })
        ->get_column('name')->all;

    # In the Queen's English, Oxford comma and all, mate!
    say sprintf '%s %s %s.',
        WORDLIST(@fans), PL_V('likes', scalar @fans), $beer->name;
}

# next: Moose! lib/Beer.pm
