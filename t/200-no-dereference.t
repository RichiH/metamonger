#!usr/bin/env perl

use strict;
use warnings;

use File::Copy;
use JSON;
use Shell::Command;
use Test::Most;

my $STORAGE = '.metamonger';

system ("mkdir -p 't/etc/'");

die $? if $?;

chdir 't/etc/' or die $!;

if (!-e 'metamonger') {
    system ("ln -s '../../metamonger'");
    die $? if $?;
}

lives_ok {
    touch 'original';
};

lives_and {
    is ( symlink ('original', 'link'), 1 );
};

ok system ('touch -d "2012-01-01 00:00:00 +00:00" original') == 0;
ok system ('touch -h -d "1970-01-01 00:00:42 +00:00" link')  == 0;

my $output;


$output = `./metamonger --config=../files/config_empty save --no-act --no-dereference`;

ok $output =~ '"link":\{"mtime":42}';
ok $output =~ '"original":\{"mtime":1325376000}';


$output = `./metamonger --config=../files/config_empty save --no-act -P`;

ok $output =~ '"link":\{"mtime":42}';
ok $output =~ '"original":\{"mtime":1325376000}';


$output = `./metamonger --config=../files/config_empty save --no-act --dereference`;

ok $output =~ '"link":\{"mtime":1325376000}';
ok $output =~ '"original":\{"mtime":1325376000}';

$output = `./metamonger --config=../files/config_empty save --no-act -L`;

ok $output =~ '"link":\{"mtime":1325376000}';
ok $output =~ '"original":\{"mtime":1325376000}';


$output = `./metamonger --config=../files/config_empty save --no-act`;

ok $output =~ '"link":\{"mtime":1325376000}';
ok $output =~ '"original":\{"mtime":1325376000}';


rm_rf '../etc';

done_testing;
