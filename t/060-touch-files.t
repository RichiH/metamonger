#!/usr/bin/perl

use strict;
use warnings;

use Shell::Command;
use Test::Most;

chdir 't/etc/' or die $!;

system ('mkdir -p untracked/');
ok !$@;

system ('mkdir -p untracked/dir1');
ok !$@;

system ('mkdir -p untracked/dir2');
ok !$@;

eval {
	touch 'untracked_file1';
	touch 'untracked_file2';

	touch 'untracked/file';
	touch 'untracked/dir1/file';
};

ok !$@;

done_testing;
