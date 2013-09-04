#!usr/bin/perl

use strict;
use warnings;

use Test::Most;
use Shell::Command;

use Data::Dumper;

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

if (!-e 'metamonger') {
	system ("ln -s '../../metamonger'");
	die $? if $?;
}

# This check depends on the '.metamonger' from t/100-config.t
system ("./metamonger --save 001 --config .metamonger 2>/dev/null");
ok $?;

rm_rf '../etc';
done_testing;
