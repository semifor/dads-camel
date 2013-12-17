package Beer::DB::ResultSet::Beer;
use 5.12.1;

use parent 'DBIx::Class::ResultSet';

sub random_beer {
    shift->search(undef, {
        prefetch => 'brewery',
        order_by => \'random()',
    })->first;
}

1;
