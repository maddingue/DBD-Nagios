use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'DBD::Nagios',
    license             => 'perl',
    dist_author         => 'Sebastien Aperghis-Tramoni and Yves Blusseau',
    dist_version_from   => 'lib/DBD/Nagios.pm',

    meta_merge          => {
        resources       => {
            homepage    => 'https://www.ohloh.net/p/DBD-Nagios',
            repository  => 'git://github.com/maddingue/DBD-Nagios.git',
        },
    },

    build_requires => {
        'DBI'           => '1.40',
    },
    build_requires => {
        'Test::More'    => 0,
    },

    add_to_cleanup      => [ 'DBD-Nagios-*' ],
);

$builder->create_build_script();
