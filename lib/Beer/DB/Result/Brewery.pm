package Beer::DB::Result::Brewery;
use 5.12.1;
use warnings;

use parent 'DBIx::Class::Core';

__PACKAGE__->table('brewery');
__PACKAGE__->add_columns(qw/id name/);
__PACKAGE__->set_primary_key(qw/id/);
__PACKAGE__->add_unique_constraint([ qw/name/ ]);

1;
