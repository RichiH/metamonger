#!/usr/bin/perl

use strict;
use warnings;

use Test::Most;

chdir 't/etc' or die $!;

my $output = `./metamonger status --untracked=all`;

ok $output =~ qr#untracked/file#;
ok $output =~ /untracked_file1/;
ok $output =~ qr#untracked/dir1/file#;
ok $output =~ /untracked_file2/;
ok $output =~ qr#untracked/dir1/dir2/file#;

system('./metamonger save');

$output = `./metamonger status --untracked=all`;

ok !$output;

$output = `./metamonger status --untracked=invalid 2>&1`;

ok $output =~ qr/untracked=invalid: no such mode/;

done_testing;
