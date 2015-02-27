#!/usr/bin/env perl

use strict;
use warnings;

use Shell::Command;

use Test::Most;

chdir 't' or die $!;

ok rm_rf 'etc/', 'Removing test dir succeeds';

done_testing;
