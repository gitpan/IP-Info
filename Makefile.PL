use strict;use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'IP::Info',
    AUTHOR        => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM  => 'lib/IP/Info.pm',
    ABSTRACT_FROM => 'lib/IP/Info.pm',
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'IP-Info-*' },
    PREREQ_PM     => {
        'Test::More'  => 0,
        'XML::Simple' => '2.14',
        'Readonly'    => '1.03',
        'Mouse'       => '0.93',
        'Digest::MD5' => '2.36',
        'HTTP::Request'      => '1.40',
        'HTTP::Exception'    => '0.04004',
        'Exception::Class'   => '1.36',
        'LWP::UserAgent'     => '2.33',
        'Data::Validate::IP' => '0.10',
    },
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
);