package Beer::DB::Result::Brewery;
use 5.12.1;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('brewery');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'int',
        is_auto_increment => 1,
    },
    name => {
        data_type     => 'varchar',
        size          => '50',
    },
);
__PACKAGE__->set_primary_key(qw/id/);
__PACKAGE__->add_unique_constraint([ qw/name/ ]);

# relationships
__PACKAGE__->has_many(beers => 'Beer::DB::Result::Beer', 'brewery_id');

1;
