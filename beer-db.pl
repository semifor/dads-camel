#!/usr/bin/env perl
use 5.12.1;
use warnings;
use lib 'lib';

use Beer::DB;

my $schema = Beer::DB->connect('dbi:SQLite:dbname=tmp/beer.db');
$schema->deploy;
