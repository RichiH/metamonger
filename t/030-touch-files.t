#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

chdir 't/etc/' or die $!;

ok utime ( 1337, 42, '001' ), 'utime succeeds';
ok utime ( 42, 9001, '002' ), 'utime succeeds';
lives_ok { chmod 0775, '001' } 'Chmod on 001 succeeds';

ok utime ( 17, 17, 'dira/001' );
ok utime ( 17, 17, 'dira/002' );

done_testing;
