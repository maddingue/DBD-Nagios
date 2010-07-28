#!perl -T
use strict;
use Test::More tests => 1;

use_ok( "DBD::Nagios" );
diag( "Testing DBD::Nagios $DBD::Nagios::VERSION, Perl $], $^X" );
