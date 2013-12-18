#!/usr/bin/env perl
use 5.12.1;
use warnings;

# "Taken out of context I must seem so strange." - Ani Difranco

my @rows = (
    [ perl   => 'Larry Wall',         1987 ],
    [ python => 'Guido van Rossum',   1991 ],
    [ ruby   => 'Yukihiro Matsumoto', 1995 ],
);

sub fetch_row {
    @{ shift @rows or return };
};

while ( my ($lang, $designer, $year) = fetch_row() ) {
    say "$designer gave us $lang in $year."
}
