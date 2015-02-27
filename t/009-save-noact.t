#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use Test::Most;

chdir 't/etc/' or die $!;

# Config = /dev/null so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.

my $output = `./metamonger --config=../files/config_empty save --no-act`;

ok $output =~ '"001":{"atime":1337,"mode":"0775","mtime":42}';
ok $output =~ /"004":{\S+,"mode":"0666",\S+}/;



done_testing;
