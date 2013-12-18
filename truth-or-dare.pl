#!/usr/bin/env perl
use 5.12.1;
use warnings;

# We hold these truths to be self evident...

# These things are false:
say "undef is false"           unless undef;
say "an empty string is false" unless '';
say "an empty list is false"   unless ();
say "the number 0 is false"    unless 0;
say "the number 0e0 is false"  unless 0e0;
