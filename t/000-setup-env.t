#!/usr/bin/perl

use strict;
use warnings;

use Shell::Command;

use Test::Most;

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

my $STORAGE = '.metamonger';

open (my $FILE, '>', $STORAGE) or die $?;
print $FILE '{"config":{"program":"metamonger","storage_version":0,"strict_json":1,"tracked_metadata":{"atime":1,"gid":0,"mode":1,"mtime":1,"uid":0}}}';
close $FILE;


if (!-e 'metamonger') {
	system ("ln -s '../../metamonger'");
	die $? if $?;
}

lives_ok {
	touch '001';
	touch '002';
	touch '003';
	touch '004';
} 'touching files succeeds';

ok utime (1337, 42, '001'), 'utime succeeds';
lives_ok { chmod 775, '001' } 'Chmod succeeds';

ok utime (-1, 9001, '002'), 'utime on 002 succeeds';
ok utime (9002, -1, '003'), 'utime on 003 succeeds';

lives_ok { chmod 666, '004' } 'Chmod on 004 succeeds';

done_testing;
