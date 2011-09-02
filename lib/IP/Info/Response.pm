package IP::Info::Response;

use Carp;
use Data::Dumper;

use Mouse;

=head1 NAME

IP::Info::Response - Response handler for the module IP::Info.

=head1 VERSION

Version 0.04

=cut

our $VERSION = '0.04';

=head1 DESCRIPTION

Response handler for IP::Info and exposes the response data to user.

=cut

has 'source'            => (is => 'rw', isa => 'HashRef', required => 1);
has 'http_status'       => (is => 'rw', isa => 'Num');
has 'message'           => (is => 'rw', isa => 'Str');
has 'ip_type'           => (is => 'rw', isa => 'Str');
has 'ip_routing_type'   => (is => 'rw', isa => 'Str');
has 'carrier'           => (is => 'rw', isa => 'Str');
has 'line_speed'        => (is => 'rw', isa => 'Str');
has 'asn'               => (is => 'rw', isa => 'Str');
has 'organization'      => (is => 'rw', isa => 'Str');
has 'organization_type' => (is => 'rw', isa => 'Str');
has 'domain_tld'        => (is => 'rw', isa => 'Str');
has 'domain_sld'        => (is => 'rw', isa => 'Str');
has 'longitude'         => (is => 'rw', isa => 'Str');
has 'latitude'          => (is => 'rw', isa => 'Str');
has 'city_cf'           => (is => 'rw', isa => 'Str');
has 'city'              => (is => 'rw', isa => 'Str');
has 'postal_code'       => (is => 'rw', isa => 'Str');
has 'time_zone'         => (is => 'rw', isa => 'Str');
has 'area_code'         => (is => 'rw', isa => 'Str');
has 'region'            => (is => 'rw', isa => 'Str');
has 'continent'         => (is => 'rw', isa => 'Str');
has 'state_code'        => (is => 'rw', isa => 'Str');
has 'state_cf'          => (is => 'rw', isa => 'Str');
has 'state'             => (is => 'rw', isa => 'Str');
has 'country_code'      => (is => 'rw', isa => 'Str');
has 'country_cf'        => (is => 'rw', isa => 'Str');
has 'country'           => (is => 'rw', isa => 'Str');

sub BUILD
{
    my $self = shift;

    my $source = $self->source;
    
    $self->{'http_status'} = $source->{'http_status'} 
        if defined($source->{'http_status'});
    $self->{'message'} = $source->{'message'} 
        if defined($source->{'message'});
        
    # Network Data
    $self->{'ip_type'} = $source->{ip_type}
        if defined($source->{ip_type});
    $self->{'ip_routing_type'} = $source->{Network}->{ip_routing_type}
        if defined($source->{Network}->{ip_routing_type});
    $self->{'carrier'} = $source->{Network}->{carrier}
        if defined($source->{Network}->{carrier});
    $self->{'line_speed'} = $source->{Network}->{line_speed}
        if defined($source->{Network}->{line_speed});
    $self->{'asn'} = $source->{Network}->{asn}
        if defined($source->{Network}->{asn});
    $self->{'organization'} = $source->{Network}->{organization}
        if defined($source->{Network}->{organization});
    $self->{'organization_type'} = $source->{Network}->{OrganizationData}->{organization_type}
        if defined($source->{Network}->{OrganizationData}->{organization_type});
    $self->{'connection_type'} = $source->{Network}->{connection_type}
        if defined($source->{Network}->{connection_type});
    $self->{'domain_tld'} = $source->{Network}->{Domain}->{tld}
        if defined($source->{Network}->{Domain}->{tld});
    $self->{'domain_sld'} = $source->{Network}->{Domain}->{sld}
        if defined($source->{Network}->{Domain}->{sld});
        
    # Location Data
    $self->{'longitude'} = $source->{Location}->{longitude}
        if defined($source->{Location}->{longitude});
    $self->{'latitude'} = $source->{Location}->{latitude}
        if defined($source->{Location}->{latitude});
    $self->{'city_cf'} = $source->{Location}->{CityData}->{city_cf}
        if defined($source->{Location}->{CityData}->{city_cf});
    $self->{'city'} = $source->{Location}->{CityData}->{city}
        if defined($source->{Location}->{CityData}->{city});
    $self->{'postal_code'} = $source->{Location}->{CityData}->{postal_code}
        if defined($source->{Location}->{CityData}->{postal_code});
    $self->{'time_zone'} = $source->{Location}->{CityData}->{time_zone}
        if defined($source->{Location}->{CityData}->{time_zone});
    $self->{'area_code'} = $source->{Location}->{CityData}->{area_code}
        if defined($source->{Location}->{CityData}->{area_code});
    $self->{'region'} = $source->{Location}->{region}
        if defined($source->{Location}->{region});
    $self->{'continent'} = $source->{Location}->{continent}
        if defined($source->{Location}->{continent});
    $self->{'state_code'} = $source->{Location}->{StateData}->{state_code}
        if defined($source->{Location}->{StateData}->{state_code});
    $self->{'state_cf'} = $source->{Location}->{StateData}->{state_cf}
        if defined($source->{Location}->{StateData}->{state_cf});
    $self->{'state'} = $source->{Location}->{StateData}->{state}
        if defined($source->{Location}->{StateData}->{state});
    $self->{'country_code'} = $source->{Location}->{CountryData}->{country_code}
        if defined($source->{Location}->{CountryData}->{country_code});
    $self->{'country_cf'} = $source->{Location}->{CountryData}->{country_cf}
        if defined($source->{Location}->{CountryData}->{country_cf});
    $self->{'country'} = $source->{Location}->{CountryData}->{country}
        if defined($source->{Location}->{CountryData}->{country});
}

=head1 METHODS

=head2 ip_type()

Returns the IP Type.

=head2 ip_routing_type()

Returns the IP Routing Type.

=head2 carrier()

Returns the IP Carrier.

=head2 line_speed()

Returns the IP Line Speed.

=head2 asn()

Returns the IP ASN.

=head2 organization()

Returns the IP Organization.

=head2 organization_type()

Returns the IP Organization Type.

=head2 connection_type()

Returns the IP Connection Type.

=head2 domain_tld()

Returns the IP Domain TLD.

=head2 domain_sld()

Returns the IP Domain SLD.

=head2 longitute()

Returns the IP Location Longitude.

=head2 latitude()

Returns the IP Location Latitude.

=head2 city_cf()

Returns the IP Location City CF.

=head2 city()

Returns the IP Location City.

=head2 postal_code()

Returns the IP Location Postal Code.

=head2 time_zone()

Returns the IP Location Time Zone.

=head2 area_code()

Returns the IP Location Area Code.

=head2 region()

Returns the IP Location Region.

=head2 continent()

Returns the IP Location Continent.

=head2 state_code()

Returns the IP Location State Code.

=head2 state_cf()

Returns the IP Location State CF.

=head2 state()

Returns the IP Location State.

=head2 country_code()

Returns the IP Location Country Code.

=head2 country_cf()

Returns the IP Location Country CF.

=head2 country()

Returns the IP Location Country.

=head2 message()

Returns the message.

=head2 http_status()

Returns the error code.

    +------+-----------------------+
    | Code | Message               |
    +------+-----------------------+
    | 200  | Success!              |
    | 400  | Bad Request           |
    | 403  | Forbidden             |
    | 404  | Not Found             |
    | 408  | Request Timeout       |
    | 500  | Internal Server Error |
    | 503  | Service Unavailable   |
    +------+-----------------------+

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-ip-info at rt.cpan.org> or through the web
interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IP-Info>. I will be notified and
then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IP::Info::Response

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
no Mouse; # Keywords are removed from the IP::Info::Response package

1; # End of IP::Info::Response