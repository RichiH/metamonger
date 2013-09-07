#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

chdir 't/etc' or die $!;

my $output = `./metamonger --untracked=all`;

ok $output =~ qr#untracked/file#;
ok $output =~ /untracked_file1/;
ok $output =~ qr#untracked/dir1/file#;
ok $output =~ qr#untracked/dir2/#;
ok $output =~ /untracked_file2/;

system('./metamonger --save');

$output = `./metamonger --untracked=all`;

ok !$output;

$output = `./metamonger --untracked=invalid 2>&1`;

ok $output =~ qr/untracked=invalid: no such mode/;

done_testing;
