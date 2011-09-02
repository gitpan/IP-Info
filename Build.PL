use strict;use warnings;
use Module::Build;

my $builder = Module::Build->new(
    sign              => 1,
    module_name       => 'IP::Info',
    license           => 'perl',
    dist_author       => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from => 'lib/IP/Info.pm',
    add_to_cleanup    => [ 'IP-Info-*' ],    
    build_requires    => {
        'Test::More'  => 0,
        'JSON'        => '2.15',
        'XML::Simple' => '2.14',
        'Readonly'    => '1.03',
        'Mouse'       => '0.93',
        'Digest::MD5' => '2.36',
        'HTTP::Request'  => '1.40',
        'LWP::UserAgent' => '2.33',
        'Data::Validate::IP' => '0.10',
    },
);

$builder->create_build_script();