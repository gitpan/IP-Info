#!perl

use strict; use warnings;
use IP::Info;
use Test::More tests => 3;

my ($apikey, $secret);
$apikey = 'Your_API_Key';
$secret = 'Your_shared_secret';

eval { IP::Info->new(); };
like($@, qr/Attribute \(apikey\) is required/);

eval { IP::Info->new($apikey); };
like($@, qr/Attribute \(secret\) is required/);

eval { IP::Info->new({apikey => $apikey}); };
like($@, qr/Attribute \(secret\) is required/);