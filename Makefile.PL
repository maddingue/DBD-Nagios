use strict;
use warnings;
use ExtUtils::MakeMaker;

use lib 'lib'; # for use DBI::DBD
use DBI::DBD;

my %opts;

WriteMakefile(
    dbd_edit_mm_attribs( {
        'NAME'         => 'DBD::Nagios',
        'VERSION_FROM' => 'lib/DBD/Nagios.pm',
        'INC'          => '',
        'dist'         => { 'SUFFIX'   => '.gz',
                            'COMPRESS' => 'gzip -9f' },
        "clean"        => { FILES => 'DBD-Nagios-*' },
        'realclean'    => { FILES => '*.xsi' },
        PREREQ_PM => {
            # prereqs
            'DBI'           => '1.40',

            # build/test prereqs
            'Test::More'    => 0,
        },
        'CONFIGURE'    => sub {
            eval {require DBI::DBD;};
            if ($@) {
                warn $@;
                exit 0;
            }
            my $dbi_arch_dir = dbd_dbi_arch_dir();
            if (exists($opts{INC})) {
                return {INC => "$opts{INC} -I$dbi_arch_dir"};
            } else {
                return {INC => "-I$dbi_arch_dir"};
            }
        }
    },
    { create_pp_tests => 1})
);

package MY;
sub postamble { return main::dbd_postamble(@_); }
sub libscan {
    my ($self, $path) = @_;
    ($path =~ m/\~$/) ? undef : $path;
}
