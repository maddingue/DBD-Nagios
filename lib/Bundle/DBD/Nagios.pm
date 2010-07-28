# -*- perl -*-

package Bundle::DBD::Nagios;

$VERSION = "0.01";

1;

__END__

=head1 NAME

Bundle::DBD::Nagios - A bundle to install all DBD::Nagios related modules

=head1 SYNOPSIS

  perl -MCPAN -e 'install Bundle::DBD::Nagios'

=head1 CONTENTS

Bundle::DBI  - Bundle for DBI by TIMB (Tim Bunce)

DBD::Nagios  - DBD::Nagios by SAPER and YBLUSSEAU (Sebastien Aperghis-Tramoni and Yves Blusseau)

=head1 DESCRIPTION

This bundle includes all the modules used by the Perl Database
Interface (DBI) driver for Driver (DBD::Nagios), assuming the
use of DBI version 1.13 or later, created by Tim Bunce.

If you've not previously used the CPAN module to install any
bundles, you will be interrogated during its setup phase.
But when you've done it once, it remembers what you told it.
You could start by running:

  C<perl -MCPAN -e 'install Bundle::CPAN'>

=head1 AUTHOR

This module is currently maintained by

    Sebastien Aperghis-Tramoni <maddingue@free.fr> and Yves Blusseau <1p0aj9c02@sneakemail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Sebastien Aperghis-Tramoni and Yves Blusseau

All rights reserved.

You may distribute this module under the terms of either the GNU
General Public License or the Artistic License, as specified in
the Perl README file.

=cut
