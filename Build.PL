use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'DBD::Nagios',
    license             => 'perl',
    dist_author         => 'Sebastien Aperghis-Tramoni <sebastien@aperghis.net>',
    dist_version_from   => 'lib/DBD/Nagios.pm',
    build_requires => {
        'DBI'           => '1.40',
    },
    build_requires => {
        'Test::More'    => 0,
    },
    add_to_cleanup      => [ 'DBD-Nagios-*' ],
);

$builder->create_build_script();
