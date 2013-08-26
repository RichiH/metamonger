#!/usr/bin/perl

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
my $CONFIG  = 'metamonger.conf';

if (!-e 'metamonger') {
    system ("ln -s '../../metamonger'");
    die $? if $?;
}

eval {
    touch '001';
};
die $@ if $@;

utime 1337, 42, '001';
chmod (775, '001');

system ('./metamonger --save 001');
die $? if $?;

eval {
    touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open(my $storage_fh, "<", $STORAGE) or die $!;

my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>1});

close $storage_fh;

my %metadata = %$metadata_ref;

ok $metadata{'metadata'}{'001'}{'mtime'} == 42;
ok !$metadata{'metadata'}{'001'}{'atime'};
ok !$metadata{'metadata'}{'001'}{'mode'};

eval {
    touch $CONFIG unless -e $CONFIG;
};
die $@ if $@;

open (FILE, ">$CONFIG") or die $?;
print FILE '{"tracked_metadata":{"atime":1,"gid":0,"mode":1,"mtime":0,"uid":0}}';
close FILE;

rm_f $STORAGE;

system ("./metamonger --save 001 --config $CONFIG");
die $? if $?;

eval {
    touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open($storage_fh, "<", $STORAGE) or die $!;

$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>1});
%metadata = %$metadata_ref;

close $storage_fh;

ok !$metadata{'metadata'}{'001'}{'mtime'};
ok $metadata{'metadata'}{'001'}{'atime'} == 1337;
ok $metadata{'metadata'}{'001'}{'mode'} eq '0775';


rm_rf '../etc';
done_testing;
