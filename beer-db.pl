#!/usr/bin/env perl
use 5.12.1;
use warnings;
use lib 'lib';

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
