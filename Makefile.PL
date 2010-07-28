use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBD::Nagios',
    AUTHOR              => 'Sebastien Aperghis-Tramoni <sebastien@aperghis.net>',
    VERSION_FROM        => 'lib/DBD/Nagios.pm',
    ABSTRACT_FROM       => 'lib/DBD/Nagios.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        # prereqs
        'DBI'           => '1.40',

        # build/test prereqs
        'Test::More'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DBD-Nagios-*' },
);

