package Beer::DB::Result::UserBeer;
use 5.12.1;
use warnings;
use DateTime;

use parent 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('user_beer');
__PACKAGE__->add_columns(
    user_id => {
        data_type      => 'int',
    },
    beer_id => {
        data_type      => 'int',
    },
    created_at => {
        data_type => 'datetime',
    },
);
__PACKAGE__->set_primary_key(qw/user_id beer_id/);

# relationships
__PACKAGE__->belongs_to(user => 'Beer::DB::Result::User', 'user_id');
__PACKAGE__->belongs_to(beer => 'Beer::DB::Result::Beer', 'beer_id');

sub new {
    my ( $class, $args ) = @_;

    # Assign default values
    return $class->next::method({
        created_at  => DateTime->now,
        %$args,
    });
}

1;
