#!usr/bin/env perl

use strict;
use warnings;

use File::Copy;
use JSON;
use Shell::Command;
use Test::Most;

my $STORAGE = '.metamonger';

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

if (!-e 'metamonger') {
	system ("ln -s '../../metamonger'");
	die $? if $?;
}

system ("mkdir -p dira");
die $? if $?;

system ('mkdir -p dira/dirb');
die $? if $?;

eval {
	touch 'dira/b';
	touch 'dira/.sekrit';
	touch 'dira/dirb/c';
};
die $@ if $@;

copy ("../files/metamongerignore1", "./.metamongerignore");

system ("./metamonger save dira");

open(my $storage_fh, "<", $STORAGE) or die $!;
my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

my %metadata = %$metadata_ref;

ok !$metadata{metadata}{'dira'};
ok !$metadata{metadata}{'dira/.sekrit'};
ok !$metadata{metadata}{'dira/b'};
ok !$metadata{metadata}{'dira/dirb'};
ok !$metadata{metadata}{'dira/dirb/c'};

rm_f $STORAGE;

copy ("../files/metamongerignore2", "./.metamongerignore");

system ("./metamonger save dira");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'dira/b'};
ok $metadata{metadata}{'dira/.sekrit'};
ok !$metadata{metadata}{'dira/dirb'};
ok !$metadata{metadata}{'dira/dirb/c'};

rm_f $STORAGE;

copy ("../files/metamongerignore3", "./.metamongerignore");

system ("./metamonger save dira");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'dira/.sekrit'};
ok !$metadata{metadata}{'dira/b'};
ok !$metadata{metadata}{'dira/dirb'};
ok !$metadata{metadata}{'dira/dirb/c'};

rm_f $STORAGE;

copy ("../files/metamongerignore4", "./.metamongerignore");

system ("./metamonger save dira");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'dira/.sekrit'};
ok !$metadata{metadata}{'dira/b'};
ok $metadata{metadata}{'dira/dirb/c'};

rm_f $STORAGE;

rm_rf '../etc';

done_testing;
