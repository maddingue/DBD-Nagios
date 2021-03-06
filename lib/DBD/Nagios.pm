package DBD::Nagios;
use strict;
use warnings;

# globals
use vars qw<
    $VERSION  $err  $errstr  $sqlstate  $drh  $DBD_IGNORECASE
>;

$VERSION  = '0.01';

$drh      = undef;     # holds driver handle once initialised

$DBD_IGNORECASE = 1;


#
# driver()
# ------
sub driver {
    my ($class, $attr) = @_;

    return $drh if $drh;    # database driver already created

    my $dbclass = $class . "::dr";

    $drh = DBI::_new_drh($dbclass, {
        Name        => $class,
        Version     => $VERSION,
        Attribution => "DBD::Nagios by Sebastien Aperghis-Tramoni and Yves Blusseau",
    }) or return undef;

    return $drh
}


#
# CLONE()
# -----
sub CLONE {
    undef $drh;
}


# ------------------------------------------------------------------------------
# driver interface
#
package DBD::Nagios::dr;
use strict;
use warnings;


$DBD::Nagios::dr::imp_data_size = 0;


#
# connect()
# ------
sub connect {
    my ($drh, $dsn, $user, $auth, $attr) = @_;

    my $dbh = DBI::_new_dbh($drh, {
        Name         => $dsn,
        USER         => $user,
        CURRENT_USER => $user,
    });

    return $dbh
}


#
# data_sources()
# ------------
sub data_sources {
    my ($drh, $attr) = @_;
    my $dbd_name = "Nagios";

    my @paths = qw< /var/lib/nagios/rw/live >;

    for my $path (@paths) {
        return "dbi:$dbd_name:socket=$path" if -S $path
    }

    return
}


# ------------------------------------------------------------------------------
# database interface
#
package DBD::Nagios::db;
use strict;
use warnings;


$DBD::Nagios::db::imp_data_size = 0;


#
# STORE()
# -----
sub STORE {
    my ($dbh, $attr, $val) = @_;

    if ($attr eq 'AutoCommit') {
        if (!$val) {
            return $dbh->set_err( 1, "Can't disable AutoCommit" );
        }
        return 1;
    }
    elsif ($attr =~ m/^nag_/) {
        # Handle only our private attributes here
        # Note that we could trigger arbitrary actions.
        # Ideally we should warn about unknown attributes.
        $dbh->{$attr} = $val; # Yes, we are allowed to do this,
        return 1;             # but only for our private attributes

    }
    # Else pass up to DBI to handle for us
    return $dbh->SUPER::STORE($attr, $val);
}


#
# FETCH()
# -----
sub FETCH {
    my ($dbh, $attr) = @_;

    if ($attr eq 'AutoCommit') { return 1; }
    elsif ($attr =~ m/^nag_/) {
          # Handle only our private attributes here
          # Note that we could trigger arbitrary actions.
          return $dbh->{$attr}; # Yes, we are allowed to do this,
                                # but only for our private attributes
    }
    # Else pass up to DBI to handle
    $dbh->SUPER::FETCH($attr);
}

# ------------------------------------------------------------------------------
# statement interface
#
package DBD::Nagios::st;
use strict;
use warnings;

$DBD::Nagios::st::imp_data_size = 0;


"OK"

__END__

=head1 NAME

DBD::Nagios - Fetch Nagios information through Livestatus query language

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

    use DBI;

    my $dbh = DBI->connect("dbi:Nagios:") or
        die "Cannot connect: $DBI::errstr";

    ...


=head1 DESCRIPTION

xxx


=head1 METHODS

=head2 DBI Class Methods

=head3 connect

Creates and returns a DBI handle connected to specified Nagios Livestatus
service.

    DBI->connect("dbi:Nagios:socket=$path;...", $user, $password, \%options)


B<DSN Parameters:>

=over

=item *

C<socket> - path to the local UNIX socket of Nagios Livestatus

=item *

C<host> - remote Nagios Livestatus server name

=item *

C<port> - remote Nagios Livestatus server port

=back


B<Options:>

=over

=item *

C<KeepAlive> - keep open the connection and reuse it for several requests

=back


=head1 SEE ALSO

L<DBI>

Nagios - L<http://www.nagios.org/>

MK Livestatus - L<http://mathias-kettner.de/checkmk_livestatus.html>

L<Monitoring::Livestatus>, L<Monitoring::Livestatus::Class> for modules
providing access to Nagios Livestatus outside the DBI API.


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
