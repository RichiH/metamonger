#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use Shell::Command;

use Test::Most;

use Data::Dumper;

chdir 't/etc/' or die $!;

# Config = empty so we don't use ~/.config/metamonger,
# or /etc/metamonger/config.
system ('./metamonger save 001 002 dira/001 dira/002 --config=../files/config_empty');
die $? if $?;

ok utime ( 1, 1, 'dira/001' );
ok utime ( 1, 1, 'dira/002' );
ok utime ( 1, 1, '001' );
ok utime ( 1, 1, '002' );

system ('./metamonger restore 001 002');

my (undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

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
) = lstat('002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_2 == 9001;

my (undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_1 == 1;

my (undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_2 == 1;

ok utime ( 42, 42, '001' ), 'utime succeeds';
ok utime ( 42, 42, '002' ), 'utime succeeds';

ok utime ( 17, 17, 'dira/001' );
ok utime ( 17, 17, 'dira/002' );

system ('./metamonger save 001 002 dira/001 dira/002 --config=../files/config_empty');
die $? if $?;

ok utime ( 1, 1, 'dira/001' );
ok utime ( 1, 1, 'dira/002' );
ok utime ( 1, 1, '001' );
ok utime ( 1, 1, '002' );

system ('./metamonger restore dira/');

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_1 == 1;

(
    undef,                          # device number
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
) = lstat('002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_2 == 1;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_1 == 17;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_2 == 17;

ok utime ( 42, 42, '001' ), 'utime succeeds';
ok utime ( 42, 42, '002' ), 'utime succeeds';

ok utime ( 17, 17, 'dira/001' );
ok utime ( 17, 17, 'dira/002' );

system ('./metamonger save 001 002 dira/001 dira/002 --config=../files/config_empty');
die $? if $?;

ok utime ( 1, 1, 'dira/001' );
ok utime ( 1, 1, 'dira/002' );
ok utime ( 1, 1, '001' );
ok utime ( 1, 1, '002' );

system ('./metamonger restore 001 dira/');

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_1 == 42;

(
    undef,                          # device number
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
) = lstat('002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_2 == 1;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_1 == 17;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_2 == 17;

ok utime ( 42, 42, '001' ), 'utime succeeds';
ok utime ( 42, 42, '002' ), 'utime succeeds';

ok utime ( 17, 17, 'dira/001' );
ok utime ( 17, 17, 'dira/002' );

system ('./metamonger save 001 002 dira/001 dira/002 --config=../files/config_empty');
die $? if $?;

ok utime ( 1, 1, 'dira/001' );
ok utime ( 1, 1, 'dira/002' );
ok utime ( 1, 1, '001' );
ok utime ( 1, 1, '002' );

system ('./metamonger restore dira/002');

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_1 == 1;

(
    undef,                          # device number
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
) = lstat('002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_2 == 1;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_1 == 1;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_2 == 17;

ok utime ( 42, 42, '001' ), 'utime succeeds';
ok utime ( 42, 9001, '002' ), 'utime succeeds';

ok utime ( 17, 17, 'dira/001' );
ok utime ( 17, 17, 'dira/002' );

system ('./metamonger save 001 002 003 004 dira/* --config=../files/config_empty');
die $? if $?;

eval {
	touch '001';
	touch '002';
	touch '003';
};
die $@ if $@;

chmod 777, '004';

system ('./metamonger restore');

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_1 == 42;

(
    undef,                          # device number
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

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_1,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/001') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_1 == 17;

(
    undef,                          # device number
    undef,                          # inode number
    undef,
    undef,                          # number of (hard) links
    undef,
    undef,
    undef,                          # device identifier
    undef,                          # total size
    undef,
    $mtime_dir_2,
    undef,                          # ctime; can not be set on Unix
    undef,                          # preferred block size
    undef,                          # blocks allocated
) = lstat('dira/002') or log_fatal {"Could not stat '001': $!"};

ok $mtime_dir_2 == 17;

done_testing;
