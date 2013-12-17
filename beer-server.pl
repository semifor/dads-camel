#!/usr/bin/env perl
use 5.12.1;
use warnings;
use lib 'lib';
use Beer;

my $server = Beer->new;

for ( 1..6 ) {
    say $server->random_beer_please;
}

say "${ \$server->beers_requested } beers requested.";
