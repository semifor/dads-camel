package Beer::DB;

use parent 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

# Auto loads classes in:
#
# lib/Beer/DB/Result
# lib/Beer/DB/ResultSet

1;
