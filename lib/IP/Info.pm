package IP::Info;

use Mouse;
use Mouse::Util::TypeConstraints;

use Carp;
use Readonly;
use Data::Dumper;

use XML::Simple;
use HTTP::Request;
use LWP::UserAgent;
use IP::Info::Response;
use Digest::MD5 qw(md5_hex);
use Data::Validate::IP qw(is_ipv4);

=head1 NAME

IP::Info - Interface to IP geographic and network data.

=head1 VERSION

Version 0.05

=cut

our $VERSION = '0.05';
Readonly my $API_VER => 'v1';
Readonly my $METHOD  => 'ipinfo';
Readonly my $SERVICE => 'http://api.quova.com';

=head1 DESCRIPTION

Quova RESTful API provides the geographic location and network data for any  Internet Protocol
address in the public address space. The information includes:

=over 5

=item * Postal code, city, state, region, country, and continent

=item * Area code (US and Canada only) and time zone

=item * Longitude and latitude

=item * DMA (Designated Market Area) and MSA (Metropolitan Statistical Area)

=item * Network information, including type, speed, carrier, and registering organization

=back

=head1 CONSTRUCTOR

The constructor requires the following parameters as listed below:

    +--------+----------+----------------------------------------+
    | Key    | Required | Description                            |
    +--------+----------+----------------------------------------+
    | apikey |   Yes    | API Key given by Quova.                |
    | secret |   Yes    | Allocated share secret given by Quova. |
    +--------+----------+----------------------------------------+

To obtain your Quova API key (apikey) and the shared secret, register your application here at
http://developer.quova.com/

    use strict; use warnings;
    use IP::Info;
    
    my ($apikey, $secret, $info);
    $apikey = 'Your_API_Key';
    $secret = 'Your_shared_secret';
    $info   = IP::Info->new($apikey, $secret);
    # or
    $info   = IP::Info->new({ apikey => $apikey, secret => $secret});

=cut

type 'Format'  => where { defined($_) && (/\bxml\b|\bjson\b/i) };
has  'apikey'  => (is => 'ro', isa => 'Str', required => 1);
has  'secret'  => (is => 'ro', isa => 'Str', required => 1);
has  'browser' => (is => 'ro', isa => 'LWP::UserAgent', default => sub { return LWP::UserAgent->new(agent => 'Mozilla/5.0'); });

around BUILDARGS => sub
{
    my $orig  = shift;
    my $class = shift;

    if (@_ == 1 && ! ref $_[0])
    {
        return $class->$orig(apikey => $_[0]);
    }
    elsif (@_ == 2 && ! ref $_[0])
    {
        return $class->$orig(apikey => $_[0], secret => $_[1]);
    }
    else
    {
        return $class->$orig(@_);
    }
};

=head1 METHODS

=head2 ipaddress()

If an IP address is specified in the correct format, then  the  call returns an object of type
L<IP::Info::Response> object which can be queried further to look for specific information for 
that IP.

The IP must be a standard, 32-bit IPv4 address. The allowed IP formats are

=over 2

=item * dot-decimal e.g. 4.2.2.2

=item * decimal notation e.g. 67240450 

=back

    use strict; use warnings;
    use IP::Info;
    
    my $apikey = 'Your_API_Key';
    my $secret = 'Your_shared_secret';
    my $ipaddress = '4.2.2.2';
    my $info = IP::Info->new($apikey, $secret);
    my $response = $info->ipaddress($ipaddress);
    print "Country: [".$response->country(). "]\n";

=cut

sub ipaddress
{
    my $self = shift;
    my $ip   = shift;
    croak("ERROR: Missing parameter IP Address.\n") unless defined $ip;
    croak("ERROR: Invalid IP Address [$ip].\n") unless is_ipv4($ip);
    
    my $url = sprintf("%s/%s?apikey=%s&sig=%s&format=xml",
        $self->_url(), $ip, $self->apikey, $self->_sig());
    my $source = $self->_process($url);
    $source =~ s/^(\<\?.*\?\>)//g;
    return IP::Info::Response->new(source => XMLin($source));
}

=head2 schema()

Saves the XML Schema Document in the given file (.xsd file).

    use strict; use warnings;
    use IP::Info;
    
    my $apikey = 'Your_API_Key';
    my $secret = 'Your_shared_secret';
    my $info   = IP::Info->new($apikey, $secret);
    $info->schema('User_supplied_filename.xsd');

=cut

sub schema
{
    my $self = shift;
    my $file = shift;
    croak("ERROR: Please supply the file name for the schema document.\n")
        unless defined $file;

    my $url  = sprintf("%s/schema?apikey=%s&sig=%s",
        $self->_url(), $self->apikey, $self->_sig());
    my $data = $self->_process($url);

    open(SCHEMA, ">$file") 
        or croak("ERROR: Couldn't open file [$file] for writing: [$!]\n");
    print SCHEMA $data;
    close(SCHEMA);
}

sub _process
{
    my $self = shift;
    my $url  = shift;
    
    my ($browser, $request, $response, $content);
    $browser = $self->browser;
    $browser->timeout(120);
    $browser->env_proxy;
    $request  = HTTP::Request->new(GET => $url);
    $response = $browser->request($request);
    croak("ERROR: Couldn't fetch data [$url]:[".$response->status_line."]\n")
        unless $response->is_success;
    $content  = $response->content;
    croak("ERROR: No data found.\n") unless defined $content;
    return $content;
}

sub _sig
{
    my $self = shift;
    my $time = time;
    return md5_hex($self->apikey . $self->secret . $time);
}

sub _url
{
    my $self = shift;
    return sprintf("%s/%s/%s", $SERVICE, $API_VER, $METHOD);
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-ip-info at rt.cpan.org> or through the web
interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IP-Info>. I will be notified and
then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IP::Info

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=IP-Info>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/IP-Info>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/IP-Info>

=item * Search CPAN

L<http://search.cpan.org/dist/IP-Info/>

=back

=head1 LICENSE AND COPYRIGHT

This  program  is  free  software; you can redistribute it and/or modify it under the terms of
either:  the  GNU  General Public License as published by the Free Software Foundation; or the
Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DISCLAIMER

This  program  is  distributed in the hope that it will be useful,  but  WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

__PACKAGE__->meta->make_immutable;
no Mouse; # Keywords are removed from the IP::Info package
no Mouse::Util::TypeConstraints;

1; # End of IP::Info