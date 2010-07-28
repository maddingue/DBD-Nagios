#!perl
use strict;
use Test::More;


plan tests => 5;
diag "check that the driver provides all the methods expected by DBI";

my $driver = "DBD::Nagios";

use_ok($driver);
can_ok($driver, qw< driver CLONE >);
can_ok("$driver\::dr", qw< connect data_sources >);
can_ok("$driver\::db", qw< STORE FETCH prepare commit rollback >);
can_ok("$driver\::st", qw<
    STORE  FETCH
    bind_param  bind_param_array
    execute  execute_for_fetch
    fetchrow_arrayref  fetch
    rows  finish  DESTROY
>);
