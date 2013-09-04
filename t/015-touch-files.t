#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

chdir 't/etc/' or die $!;

ok utime (9001, 666, '001'), 'utime succeeds';
lives_ok { chmod 0777, '001' } 'Chmod on 001 succeeds';

done_testing;
