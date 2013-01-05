package IP::Info::Exception;

=head1 NAME

IP::Info::Exception - Exception handler for the module IP::Info.

=head1 VERSION

Version 0.06

=cut

our $VERSION = '0.06';

use Exception::Class (
    'NoDataFoundException' => {
        description => 'These exceptions are related to HTTP Response data.',
        fields => [ 'url' ]
    },
);

=head1 DESCRIPTION

Exception handler for the module IP::Info.

=cut

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-ip-info at rt.cpan.org> or through the web
interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IP-Info>. I will be notified and
then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IP::Info::Exception

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

1; # End of IP::Info::Exception