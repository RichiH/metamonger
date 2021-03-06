#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use Test::Most;

chdir 't/etc/' or die $!;

# Config = /dev/null so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.
my $output = `./metamonger --config=../files/config_empty diff`;

ok $output eq "filename - metadata - old ===> new
file: 001: atime: 1337 ==> 9001
file: 001: mode: 0775 ==> 0777
file: 001: mtime: 42 ==> 666\n";

done_testing;
