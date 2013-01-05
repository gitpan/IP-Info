#!perl

use strict; use warnings;
use IP::Info;
use Test::More;

eval "use Test::LWP::UserAgent";
plan skip_all => "Test::LWP::UserAgent required for testing exception handler" if $@;

my ($apikey, $secret, $sig, $info);
my ($browser, $response, $exception);

$apikey = 'Your_API_Key';
$secret = 'Your_shared_secret';
$sig    = 'Internal_SIG';

my $ok_200_with_data    = "http://api.quova.com/v1/ipinfo/127.0.0.0?apikey=$apikey&sig=$sig";
my $ok_200_without_data = "http://api.quova.com/v1/ipinfo/127.0.0.1?apikey=$apikey&sig=$sig";
my $bad_request_400  = "http://api.quova.com/v1/ipinfo/127.0.0.2?apikey=$apikey&sig=$sig";
my $unauthorized_401 = "http://api.quova.com/v1/ipinfo/127.0.0.3?apikey=$apikey&sig=$sig";
my $forbidden_403    = "http://api.quova.com/v1/ipinfo/127.0.0.4?apikey=$apikey&sig=$sig";
my $not_found_404    = "http://api.quova.com/v1/ipinfo/127.0.0.5?apikey=$apikey&sig=$sig";

$browser = Test::LWP::UserAgent->new(agent => 'Mozilla/5.0');
$browser->map_response(qr{\Q$ok_200_with_data\E},    HTTP::Response->new(200, 'OK', ['Content-Type' => 'text/plain'], 'Data'));
$browser->map_response(qr{\Q$ok_200_without_data\E}, HTTP::Response->new(200, 'OK', ['Content-Type' => 'text/plain'], ''));
$browser->map_response(qr{\Q$bad_request_400\E},  HTTP::Response->new(400));
$browser->map_response(qr{\Q$unauthorized_401\E}, HTTP::Response->new(401));
$browser->map_response(qr{\Q$forbidden_403\E},    HTTP::Response->new(403));
$browser->map_response(qr{\Q$not_found_404\E},    HTTP::Response->new(404));

$info = IP::Info->new(apikey => $apikey, secret => $secret, browser => $browser);
eval { $response = $info->_process($ok_200_with_data)  };
$exception = HTTP::Exception->caught;
ok(!$exception, 'No exception 200 OK with data.');
ok(!Exception::Class->caught('NoDataFoundException'), 'No NoDataFoundException cought.');

eval { $response = $info->_process($ok_200_without_data) };
$exception = HTTP::Exception->caught;
ok(!$exception, 'No exception 200 OK without data.');
ok(Exception::Class->caught('NoDataFoundException'), 'Caught NoDataFoundException.');

eval { $response = $info->_process($bad_request_400) };
$exception = HTTP::Exception->caught;
ok($exception, 'Caught exception 400 Bad Request.');
is($exception->code, 400, 'Expected 400 Bad Request response.');

eval { $response = $info->_process($unauthorized_401) };
$exception = HTTP::Exception->caught;
ok($exception, 'Caught exception 401 Unauthorized.');
is($exception->code, 401, 'Expected 401 Unauthorized response.');

eval { $response = $info->_process($forbidden_403) };
$exception = HTTP::Exception->caught;
ok($exception, 'Caught exception 403 Forbidden.');
is($exception->code, 403, 'Expected 403 Forbidden response.');

eval { $response = $info->_process($not_found_404) };
$exception = HTTP::Exception->caught;
ok($exception, 'Caught exception 404 Not Found.');
is($exception->code, 404, 'Expected 404 Not Found response.');

done_testing();