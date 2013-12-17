package Beer;
use 5.12.1;
use Moose;
use Lingua::EN::Inflect qw/AN WORDLIST/;
use Beer::DB;

has beer_schema => (
    is   => 'ro',
    lazy => 1,
    default => sub {
        Beer::DB->connect('dbi:SQLite:dbname=tmp/beer.db');
    },
);

has beers_requested => (
    is      => 'rw',
    default => 0,
);

after random_beer_please => sub {
    my $self = shift;

    $self->beers_requested($self->beers_requested + 1);
};

sub random_beer_please {
    my ( $self ) = @_;

    my $beer = $self->beer_schema->resultset('Beer')->search(undef, {
        prefetch => 'brewery',
        order_by => \'random()',
    })->first;

    if ( $beer ) {
        my @users = sort map $_->name, $beer->users->all;
        @users = 'nobody' unless @users;

        return sprintf "Have %s from %s recommended by %s.",
            AN($beer->name),
            $beer->brewery->name,
            WORDLIST(@users);
    }

    return "Sorry, we're out of beer.";
}

1;

