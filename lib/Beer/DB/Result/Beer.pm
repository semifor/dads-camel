package Beer::DB::Result::Beer;
use 5.12.1;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('beer');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'int',
        is_auto_increment => 1,
    },
    name => {
        data_type     => 'varchar',
        size          => '40',
    },
    description => {
        data_type     => 'text',
        default_value => '',
    },
    style => {
        data_type     => 'enum',
        extra         => {
            list => [qw/unknown ale lager porter stout ipa/],
        },
        default_value => 'unknown',
    },
    brewery_id => {
        data_type      => 'int',
    },
);
__PACKAGE__->set_primary_key(qw/id/);
__PACKAGE__->add_unique_constraint([ qw/name brewery_id/ ]);

# relationships
__PACKAGE__->belongs_to(brewery => 'Beer::DB::Result::Brewery', 'brewery_id');
__PACKAGE__->has_many(user_beers => 'Beer::DB::Result::UserBeer', 'beer_id');
__PACKAGE__->many_to_many(users => 'user_beers', 'user');

sub new {
    my ( $class, $args ) = @_;

    # Assign default values
    return $class->next::method({
        description => '',
        style       => 'unknown',
        %$args,
    });
}

1;
