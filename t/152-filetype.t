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

system ("mkdir -p container/ container/folder");
die $? if $?;

eval {
	touch 'container/file';
	touch 'container/folder/file';
};
die $@ if $@;

system ('./metamonger --save container --type=f');

open(my $storage_fh, "<", $STORAGE) or die $!;
my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

my %metadata = %$metadata_ref;

ok $metadata{'metadata'}{'container/folder/file'};
ok $metadata{'metadata'}{'container/file'};

ok !$metadata{'metadata'}{'container'};
ok !$metadata{'metadata'}{'container/folder'};

system ("rm $STORAGE");

system ('./metamonger --save container');

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{'metadata'}{'container/folder/file'};
ok $metadata{'metadata'}{'container/file'};

ok !$metadata{'metadata'}{'container'};
ok !$metadata{'metadata'}{'container/folder'};

system ("rm $STORAGE");

system ('./metamonger --save container --type=d');

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok !$metadata{'metadata'}{'container/folder/file'};
ok !$metadata{'metadata'}{'container/file'};

ok $metadata{'metadata'}{'container'};
ok $metadata{'metadata'}{'container/folder'};

system ("rm $STORAGE");

system ('./metamonger --save container --type=fd');

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{'metadata'}{'container/folder/file'};
ok $metadata{'metadata'}{'container/file'};

ok $metadata{'metadata'}{'container'};
ok $metadata{'metadata'}{'container/folder'};

system ("rm $STORAGE");

system ('./metamonger --save container --type=df');

open($storage_fh, "<", $STORAGE) or die $!;
$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
close $storage_fh;

%metadata = %$metadata_ref;

ok $metadata{'metadata'}{'container/folder/file'};
ok $metadata{'metadata'}{'container/file'};

ok $metadata{'metadata'}{'container'};
ok $metadata{'metadata'}{'container/folder'};

my $output = `./metamonger --save container --type=Q 2>&1`;
ok $output =~ /Q isn't a valid --type option/;

$output = `./metamonger --save container --type=Qf 2>&1`;
ok $output =~ /Q isn't a valid --type option/;

system ('rm -rf ../etc');

done_testing;
