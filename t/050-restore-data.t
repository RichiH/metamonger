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
system ('./metamonger --save 001 002 003 004 --config=../files/config_empty');
die $? if $?;

eval {
	touch '001';
	touch '002';
	touch '003';
};
die $@ if $@;

chmod 777, '004';

system ('./metamonger --restore');

my (undef,                          # device number
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

ok $atime_1 == 1337;
ok $mtime_1 == 42;

my (undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('002') or log_fatal {"Could not stat '002': $!"};

ok $mtime_2 == 9001;

my (undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    $atime_3,
    undef,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('003') or log_fatal {"Could not stat '003': $!"};

ok $atime_3 = 9002;

my (undef,                          # device number
    undef,                          # inode number
    $mode_4,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    undef,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('004') or log_fatal {"Could not stat '004': $!"};

$mode_4 = sprintf ("%04o", $mode_4 & 07777);

ok $mode_4 == 666;

done_testing;
