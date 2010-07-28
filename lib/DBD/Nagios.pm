package DBD::Nagios;
use strict;
use warnings;

# globals

use vars qw($VERSION $err $errstr $sqlstate $drh);

$VERSION  = '0.01';    #

$drh      = undef;     # holds driver handle once initialised

use vars qw($DBD_IGNORECASE);
$DBD_IGNORECASE = 1;

# ------------------------------------------------------------------------------
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

sub connect {
      my ($drh, $dsn, $user, $auth, $attr) = @_;

      my $dbh = DBI::_new_dbh($drh, {
                                     Name         => $dsn,
                                     USER         => $user,
                                     CURRENT_USER => $user,
                                    });
      return $dbh;
}

sub data_sources {
    my ($drh, $attr) = @_;
    my $sDbdName = 'Nagios';

    return ("dbi:$sDbdName:");
}

# ------------------------------------------------------------------------------
# database interface
#
package DBD::Nagios::db;
use strict;
use warnings;

$DBD::Nagios::db::imp_data_size = 0;

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
