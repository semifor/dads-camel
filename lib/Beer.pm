package Beer;
use 5.12.1;
use Moose;
use Lingua::EN::Inflect qw/AN WORDLIST/;
use Beer::DB;

with 'Beer::Role::HasBeerSchema';

has beers_requested => (
    is      => 'ro',
    traits  => [ 'Counter' ],
    default => 0,
    handles => {
        beer_requested => 'inc',
    },
);

after random_beer_please => sub { shift->beer_requested };

sub random_beer_please {
    my ( $self ) = @_;

    if ( my $beer = $self->beer_rs->random_beer ) {
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

