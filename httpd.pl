#!/usr/bin/env perl
use 5.12.1;
use Common::Sense;
use AnyEvent::HTTPD;
use Net::Address::IP::Local;

my $beers_served = 0;
my @beer = (
    # type  => headiness
    [ lager => 0.2 ],
    [ stout => 0.7 ],
    [ ipa   => 0.8 ],
);

my $address = Net::Address::IP::Local->public;
my $port    = 9090;
my $httpd = AnyEvent::HTTPD->new(port => $port);
say "Get you beer at http://$address:$port/";

$httpd->reg_cb('' => \&serve_beer);

$httpd->run;

sub serve_beer {
    my ( $httpd, $req ) = @_;

    my $id = ++$beers_served;
    say "serving customer $id";

    my ( $type, $headiness ) = @{ $beer[int rand @beer] };
    my $w; $w = AE::timer 10 * $headiness, 0, sub {
        $req->respond({
            content => [
                'text/plain',
                "Here's your $type! #$id\n",
            ],
        });
        say "customer $id served!";
        undef $w;
    };
}

# ab -n 1000 -c 100 'http://localhost:9090/'
