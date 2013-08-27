#!/usr/bin/perl

#
# Guard against the bug fixed in 84ee7f6b65edc9be1c3095155b0ac7157899efad
#

use strict;
use warnings;

use JSON;
use Shell::Command;

use Test::Most;

use Data::Dumper;

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

my $STORAGE = '.metamonger';

if (!-e 'metamonger') {
	system ("ln -s '../../metamonger'");
	die $? if $?;
}

system ('mkdir a/');
system ('mkdir b/');
die $? if $?;

eval {
	touch '001';
	touch 'a/002';
	touch 'b/003';
	touch '004';
	touch 'a/005';
};
die $@ if $@;

system ('./metamonger --save');
die $? if $?;

eval {
	touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open(my $storage_fh, "<", $STORAGE) or die $!;

my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>1});

close $storage_fh;

my %metadata = %$metadata_ref;

ok $metadata{'metadata'}{'001'};
ok $metadata{'metadata'}{'a/002'};
ok $metadata{'metadata'}{'b/003'};
ok $metadata{'metadata'}{'004'};
ok $metadata{'metadata'}{'a/005'};

rm_rf '../etc';
done_testing;
