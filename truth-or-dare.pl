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
say 'the string "0" is false'  unless "0";

# Everything else is true, including:
say "any non-zero number is true"  if -7;
say 'a "string" is true'           if "string";
say 'the string "0e0" is true'     if "0e0";
say 'the string "0\n" is true'     if "0\n";

# DBI (Perl's Database Independent Interface) is a useful example.
# It returns the number of rows operated on, which may be zero!
# And it returns undef on failure. We'll simulate it:
sub db_exec {
    state $rows_updated = [ 100, , 1, "0e0" ];
    return shift @$rows_updated;
}

for ( 1..4 ) {
    if ( my $rv = db_exec("delete from beer where stale") ) {
        say sprintf "deleted %d stale beers", $rv;
    }
    else {
        say "ERROR! deleting beer!";
    }
}
