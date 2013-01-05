﻿#!perl

use strict; use warnings;
use IP::Info;
use Test::More tests => 4;

my ($apikey, $secret, $info);
$apikey = 'Your_API_Key';
$secret = 'Your_shared_secret';
$info   = IP::Info->new($apikey, $secret);

eval { $info->ipaddress() };
like($@, qr/ERROR: Missing parameter IP Address/);

eval { $info->ipaddress('abcde') };
like($@, qr/ERROR: Invalid IP Address \[abcde\]/);

eval { $info->ipaddress('4.4.1') };
like($@, qr/ERROR: Invalid IP Address \[4\.4\.1\]/);

eval { $info->ipaddress('127.0.0.1') };
ok(HTTP::Exception->caught, 'Caught HTTP exception.');