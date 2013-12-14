#!/usr/bin/env perl
use 5.12.1;
use Common::Sense;
use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new(port => 9090);

$httpd->reg_cb('/' => \&serve_beer);
$httpd->run;
