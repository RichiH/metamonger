#!/usr/bin/perl

use strict;
use warnings;

use JSON;
use Shell::Command;

use Test::Most;

use Data::Dumper;

chdir 't/etc/' or die $!;

# Config = /dev/null so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.
system ('./metamonger --save 001 --config=../files/config_empty');
die $? if $?;

my $STORAGE = '.metamonger';

eval {
	touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open(my $storage_fh, "<", $STORAGE) or die $!;
my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

my %metadata = %$metadata_ref;

ok $metadata{'metadata'}{'001'}{'mtime'} == 42;
ok $metadata{'metadata'}{'001'}{'atime'} == 1337;

ok $metadata{'metadata'}{'001'}{'mode'} eq '0775';

ok !$metadata{'metadata'}{'shoudlnt_save'}, 'directories are ignored.';

done_testing;
