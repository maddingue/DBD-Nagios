use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBD::Nagios',
    LICENSE             => 'perl',
    AUTHOR              => 'Sebastien Aperghis-Tramoni and Yves Blusseau',
    VERSION_FROM        => 'lib/DBD/Nagios.pm',
    ABSTRACT_FROM       => 'lib/DBD/Nagios.pm',
    META_MERGE          => {
        resources       => {
            homepage    => 'https://www.ohloh.net/p/DBD-Nagios',
            repository  => 'git://github.com/maddingue/DBD-Nagios.git',
        },
    },
    PREREQ_PM           => {
        # prereqs
        'DBI'           => '1.40',

        # build/test prereqs
        'Test::More'    => 0,
    },
    PL_FILES            => {},
    clean               => { FILES => 'DBD-Nagios-*' },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);

