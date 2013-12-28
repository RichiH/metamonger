#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Test::Most;

chdir 't/etc/' or die $!;

# Config = /dev/null so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.
my $output = `./metamonger --config=../files/config_empty diff`;

ok $output eq "filename - metadata - old ===> new\n";

done_testing;
