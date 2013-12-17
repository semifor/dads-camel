package Beer::DB::Result::User;
use 5.12.1;
use warnings;
use DateTime;

use parent 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('user');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'int',
        is_auto_increment => 1,
    },
    name => {
        data_type     => 'varchar',
        size          => '40',
    },
    created_at => {
        data_type     => 'datetime',
    },
);
__PACKAGE__->set_primary_key(qw/id/);

# relationships
__PACKAGE__->has_many(user_beers => 'Beer::DB::Result::UserBeer', 'user_id');
__PACKAGE__->many_to_many(likes => 'user_beers', 'beer');

sub new {
    my ( $class, $args ) = @_;

    # Assign default values
    return $class->next::method({
        created_at  => DateTime->now,
        %$args,
    });
}

1;
