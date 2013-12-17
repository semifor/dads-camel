package Beer::Role::HasBeerSchema;
use Moose::Role;
use Beer::DB;

has beer_schema => (
    is      => 'ro',
    isa     => 'Beer::DB',
    default => sub { Beer::DB->connect('dbi:SQLite:dbname=tmp/beer.db') },
    handles => {
        beer_rs    => [ resultset => 'Beer'    ],
        brewery_rs => [ resultset => 'Brewery' ],
        user_rs    => [ resultset => 'User'    ],
    },
);

1;
