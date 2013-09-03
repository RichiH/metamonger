#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

chdir 't/etc/' or die $!;

ok utime ( 1337, 42, '001' ), 'utime succeeds';
lives_ok { chmod 0775, '001' } 'Chmod on 001 succeeds';

done_testing;
