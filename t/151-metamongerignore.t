#!usr/bin/perl

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

system ("mkdir -p container container/a/b/c container/a/b/d container/a/b/e container/a/f container/g/h container/g/i container/j container/k");
die $? if $?;


eval {
	touch 'container/file1';
	touch 'container/file2';
	touch 'container/.sekit';

	touch 'container/a/file1';
	touch 'container/a/file2';
	touch 'container/a/.sekrit';

	touch 'container/a/b/file1';
	touch 'container/a/b/file2';
	touch 'container/a/b/.sekrit';

	touch 'container/a/b/c/file1';
	touch 'container/a/b/c/file2';
	touch 'container/a/b/c/.sekit';

	touch 'container/a/b/d/file1';
	touch 'container/a/b/d/file2';
	touch 'container/a/b/d/.sekrit';

	touch 'container/a/b/e/file1';
	touch 'container/a/b/e/file2';
	touch 'container/a/b/e/.sekrit';

	touch 'container/a/f/file1';
	touch 'container/a/f/file2';
	touch 'container/a/f/.sekrit';

	touch 'container/g/file1';
	touch 'container/g/file2';
	touch 'container/g/.sekrit';

	touch 'container/g/h/file1';
	touch 'container/g/h/file2';
	touch 'container/g/h/.sekrit';

	touch 'container/g/i/file1';
	touch 'container/g/i/file2';
	touch 'container/g/i/.sekrit';

	touch 'container/j/file1';
	touch 'container/j/file2';
	touch 'container/j/.sekrit';
};
die $@ if $@;

copy ("../files/metamongerignore10", "./.metamongerignore");

system ("./metamonger save container");

open(my $storage_fh, "<", $STORAGE) or die $!;
my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

my %metadata = %$metadata_ref;

ok !$metadata{metadata};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore15", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok !$metadata{metadata};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore20", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok !$metadata{metadata}{'container/file1'};
ok !$metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok !$metadata{metadata}{'container/a/file1'};
ok !$metadata{metadata}{'container/a/file2'};
ok !$metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok !$metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok !$metadata{metadata}{'container/a/f/file1'};
ok !$metadata{metadata}{'container/a/f/file2'};
ok !$metadata{metadata}{'container/a/f/.sekrit'};

ok !$metadata{metadata}{'container/g/file1'};
ok !$metadata{metadata}{'container/g/file2'};
ok !$metadata{metadata}{'container/g/.sekrit'};

ok !$metadata{metadata}{'container/g/h/file1'};
ok !$metadata{metadata}{'container/g/h/file2'};
ok !$metadata{metadata}{'container/g/h/.sekrit'};

ok !$metadata{metadata}{'container/g/i/file1'};
ok !$metadata{metadata}{'container/g/i/file2'};
ok !$metadata{metadata}{'container/g/i/.sekrit'};

ok !$metadata{metadata}{'container/j/file1'};
ok !$metadata{metadata}{'container/j/file2'};
ok !$metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore30", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok !$metadata{metadata}{'container/a/file1'};
ok !$metadata{metadata}{'container/a/file2'};
ok !$metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok !$metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok !$metadata{metadata}{'container/a/f/file1'};
ok !$metadata{metadata}{'container/a/f/file2'};
ok !$metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore35", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok !$metadata{metadata}{'container/a/file1'};
ok !$metadata{metadata}{'container/a/file2'};
ok !$metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok !$metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok !$metadata{metadata}{'container/a/f/file1'};
ok !$metadata{metadata}{'container/a/f/file2'};
ok !$metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore40", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok !$metadata{metadata}{'container/a/file1'};
ok !$metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok !$metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok !$metadata{metadata}{'container/a/f/file1'};
ok !$metadata{metadata}{'container/a/f/file2'};
ok !$metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore50", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok !$metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore60", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok !$metadata{metadata}{'container/a/b/file1'};
ok !$metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok !$metadata{metadata}{'container/a/b/d/file1'};
ok !$metadata{metadata}{'container/a/b/d/file2'};
ok !$metadata{metadata}{'container/a/b/d/.sekrit'};

ok !$metadata{metadata}{'container/a/b/e/file1'};
ok !$metadata{metadata}{'container/a/b/e/file2'};
ok !$metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore70", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok !$metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore80", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok !$metadata{metadata}{'container/a/b/c/file1'};
ok !$metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore90", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok !$metadata{metadata}{'container/g/file1'};
ok !$metadata{metadata}{'container/g/file2'};
ok !$metadata{metadata}{'container/g/.sekrit'};

ok !$metadata{metadata}{'container/g/h/file1'};
ok !$metadata{metadata}{'container/g/h/file2'};
ok !$metadata{metadata}{'container/g/h/.sekrit'};

ok !$metadata{metadata}{'container/g/i/file1'};
ok !$metadata{metadata}{'container/g/i/file2'};
ok !$metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore100", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok !$metadata{metadata}{'container/g/file1'};
ok !$metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok !$metadata{metadata}{'container/g/h/file1'};
ok !$metadata{metadata}{'container/g/h/file2'};
ok !$metadata{metadata}{'container/g/h/.sekrit'};

ok !$metadata{metadata}{'container/g/i/file1'};
ok !$metadata{metadata}{'container/g/i/file2'};
ok !$metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore110", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok !$metadata{metadata}{'container/g/h/file1'};
ok !$metadata{metadata}{'container/g/h/file2'};
ok !$metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore120", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok !$metadata{metadata}{'container/g/h/file1'};
ok !$metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore130", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok !$metadata{metadata}{'container/g/i/file1'};
ok !$metadata{metadata}{'container/g/i/file2'};
ok !$metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore140", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok !$metadata{metadata}{'container/g/i/file1'};
ok !$metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore150", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok !$metadata{metadata}{'container/j/file1'};
ok !$metadata{metadata}{'container/j/file2'};
ok !$metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

#################################

copy ("../files/metamongerignore160", "./.metamongerignore");

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok !$metadata{metadata}{'container/j/file1'};
ok !$metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;




#################################

rm_f './.metamongerignore';

system ("./metamonger save container");

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{metadata}{'container/file1'};
ok $metadata{metadata}{'container/file2'};
ok $metadata{metadata}{'container/.sekit'};

ok $metadata{metadata}{'container/a/file1'};
ok $metadata{metadata}{'container/a/file2'};
ok $metadata{metadata}{'container/a/.sekrit'};

ok $metadata{metadata}{'container/a/b/file1'};
ok $metadata{metadata}{'container/a/b/file2'};
ok $metadata{metadata}{'container/a/b/.sekrit'};

ok $metadata{metadata}{'container/a/b/c/file1'};
ok $metadata{metadata}{'container/a/b/c/file2'};
ok $metadata{metadata}{'container/a/b/c/.sekit'};

ok $metadata{metadata}{'container/a/b/d/file1'};
ok $metadata{metadata}{'container/a/b/d/file2'};
ok $metadata{metadata}{'container/a/b/d/.sekrit'};

ok $metadata{metadata}{'container/a/b/e/file1'};
ok $metadata{metadata}{'container/a/b/e/file2'};
ok $metadata{metadata}{'container/a/b/e/.sekrit'};

ok $metadata{metadata}{'container/a/f/file1'};
ok $metadata{metadata}{'container/a/f/file2'};
ok $metadata{metadata}{'container/a/f/.sekrit'};

ok $metadata{metadata}{'container/g/file1'};
ok $metadata{metadata}{'container/g/file2'};
ok $metadata{metadata}{'container/g/.sekrit'};

ok $metadata{metadata}{'container/g/h/file1'};
ok $metadata{metadata}{'container/g/h/file2'};
ok $metadata{metadata}{'container/g/h/.sekrit'};

ok $metadata{metadata}{'container/g/i/file1'};
ok $metadata{metadata}{'container/g/i/file2'};
ok $metadata{metadata}{'container/g/i/.sekrit'};

ok $metadata{metadata}{'container/j/file1'};
ok $metadata{metadata}{'container/j/file2'};
ok $metadata{metadata}{'container/j/.sekrit'};

rm_f $STORAGE;

rm_rf '../etc';

done_testing;
