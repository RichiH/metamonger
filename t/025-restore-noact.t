#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Test::Most;

chdir 't/etc/' or die $!;

open (my $fh, '../files/restore-noact') or die $!;

my $expected = do { local $/; <$fh>; };

# Config = /dev/null so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.

my $output = `./metamonger --config=../files/config_empty restore --no-act`;

ok $output eq $expected;

done_testing;
