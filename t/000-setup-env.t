#!/usr/bin/perl

use strict;
use warnings;

use Shell::Command;

use Test::Most;

use File::Copy;

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

my $STORAGE = '.metamonger';

copy ('../files/.metamonger1', $STORAGE);

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
