#!perl

use strict; use warnings;
use IP::Info;
use Test::More tests => 1;

my ($apikey, $secret, $info);
$apikey = 'Your_API_Key';
$secret = 'Your_shared_secret';
$info   = IP::Info->new($apikey, $secret);

eval { $info->schema() };
like($@, qr/ERROR: Please supply the file name for the schema document/);