#!/usr/bin/env perl
use 5.12.1;
use warnings;

# There's a better way!

use Try::Tiny;

try { die "in a fire!" }
catch {
    say "Quick! Deploy the heat shield!";
};

say "All is well!"
