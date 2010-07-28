use strict;
use warnings;

package DBD::Nagios;
use strict;
use warnings;

require DBI;

# globals

use vars qw($VERSION $err $errstr $sqlstate $drh);

$VERSION  = '0.01';    #

$err      = 0;         # holds error code   for DBI::err
$errstr   =  '';       # holds error string for DBI::errstr
$sqlstate = '00000';   # holds sqlstate for DBI::sqlstate
$drh      = undef;     # holds driver handle once initialised

use vars qw($DBD_IGNORECASE);
$DBD_IGNORECASE = 1;

# ------------------------------------------------------------------------------
sub driver {

    my ($class, $attr) = @_;

    return $drh if $drh;    # database driver already created

    my $dbclass = $class . "::db";
    $drh = DBI::_new_drh($dbclass, {
        Name        => $class,
        Version     => $VERSION,
        Err         => \$DBD::Nagios::err,
        Errstr      => \$DBD::Nagios::errstr,
        State       => \$DBD::Nagios::sqlstate,
        Attribution => "DBD::Nagios by Sebastien Aperghis-Tramoni and Yves Blusseau",
    }) or return;

    return $drh
}


# ------------------------------------------------------------------------------
# driver interface
#
package DBD::Nagios::dr;
use strict;
use warnings;



# ------------------------------------------------------------------------------
# database interface
#
package DBD::Nagios::db;
use strict;
use warnings;



# ------------------------------------------------------------------------------
# statement interface
#
package DBD::Nagios::st;
use strict;
use warnings;




"OK"

__END__

=head1 NAME

DBD::Nagios - Fetch Nagios information through Livestatus query language

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

    use DBI;

    my $nagios = DBI->connect("dbi:Nagios:xxx", "", "");
    ...


=head1 DESCRIPTION

xxx



=head1 SEE ALSO

L<DBI>

Nagios - L<http://www.nagios.org/>

MK Livestatus - L<http://mathias-kettner.de/checkmk_livestatus.html>


=head1 AUTHORS

SE<eacute>bastien Aperghis-Tramoni C<< <sebastien at aperghis.net> >>

Yves Blusseau


=head1 BUGS

Please report any bugs or feature requests to
C<bug-dbd-nagios at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Dist=DBD-Nagios>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DBD::Nagios

You can also look for information at:

=over

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/Public/Dist/Display.html?Dist=DBD-Nagios>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DBD-Nagios>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DBD-Nagios>

=item * Search CPAN

L<http://search.cpan.org/dist/DBD-Nagios>

=back


=head1 COPYRIGHT & LICENSE

Copyright 2010 SE<eacute>bastien Aperghis-Tramoni and Yves Blusseau,
all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
