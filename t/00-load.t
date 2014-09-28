#!perl

use Test::More tests => 6;
BEGIN {
    use_ok( 'IP::Info' )                       || print "Bail out!";
    use_ok( 'IP::Info::Response' )             || print "Bail out!";
    use_ok( 'IP::Info::Response::Network' )    || print "Bail out!";
    use_ok( 'IP::Info::Response::Location' )   || print "Bail out!";
    use_ok( 'IP::Info::UserAgent' )            || print "Bail out!";
    use_ok( 'IP::Info::UserAgent::Exception' ) || print "Bail out!";
}
