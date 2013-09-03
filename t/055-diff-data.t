#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Test::Most;

chdir 't/etc/' or die $!;

my $output = `./metamonger --config=/dev/null --diff`;

ok $output eq "filename - metadata - old ===> new\n";

done_testing;
