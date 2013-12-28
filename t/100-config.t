#!/usr/bin/perl

use strict;
use warnings;

use JSON;
use Shell::Command;

use Test::Most;

use Data::Dumper;
use File::Copy;

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

my $STORAGE = '.metamonger';
my $CONFIG  = 'conf';

copy ("../files/$CONFIG", ".");

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

system ('./metamonger save 001');
die $? if $?;

eval {
	touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open(my $storage_fh, "<", $STORAGE) or die $!;

my $metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});

close $storage_fh;

my %metadata = %$metadata_ref;

ok $metadata{'metadata'}{'001'}{'mtime'} == 42;
ok !$metadata{'metadata'}{'001'}{'atime'};
ok !$metadata{'metadata'}{'001'}{'mode'};

utime ( 1, 1, '001' );

system ('./metamonger restore 001');

my (
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    $atime_1,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

ok $atime_1 == 1;
ok $mtime_1 == 42;

eval {
	touch $CONFIG unless -e $CONFIG;
};
die $@ if $@;

rm_f $STORAGE;

utime 1337, 42, '001';
chmod (775, '001');

system ("./metamonger save 001 --config $CONFIG");
die $? if $?;

eval {
	touch $STORAGE unless -e $STORAGE;
};
die $@ if $@;

open($storage_fh, "<", $STORAGE) or die $!;

$metadata_ref = from_json(do {local $/; <$storage_fh>}, {relaxed=>0});
%metadata = %$metadata_ref;

close $storage_fh;

ok !$metadata{'metadata'}{'001'}{'mtime'};
ok $metadata{'metadata'}{'001'}{'atime'} == 1337;
ok $metadata{'metadata'}{'001'}{'mode'} eq '0775';

chmod (777, '001');
utime ( 1, 1, '001' );

system ("./metamonger restore 001 --config $CONFIG");
die $? if $?;

my $mode_1;

(undef,                          # device number
    undef,                          # inode number
    $mode_1,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    $atime_1,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '004': $!"};

$mode_1 = sprintf ("%04o", $mode_1 & 07777);

ok $mtime_1 == 1;
ok $atime_1 == 1337;
ok $mode_1  == 775;

done_testing;
