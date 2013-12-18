#!/usr/bin/env perl
use 5.12.1;
use warnings;

# The term sigil derives from the Latin sigillum, meaning "seal", though it may
# also be related to the Hebrew סגולה (segula meaning "word, action, or item of
# spiritual effect, talisman"). The current use of the term is derived from
# Renaissance magic, which was in turn inspired by the magical traditions of
# antiquity. - http://en.wikipedia.org/wiki/Sigil_(magic)

my %sigil_for = (
    scalar => '$',
    array  => '@',
    hash   => '%',
    sub    => '&',
    glob   => '*',
);

say "The sigil for hash is $sigil_for{hash}.";

# next: context.pl
