#!usr/bin/perl

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

ok system ('touch -d "2042-01-01 00:00:00 +00:00" original') == 0;
ok system ('touch -h -d "1970-01-01 00:00:42 +00:00" link')  == 0;

my $output = `./metamonger --config=../files/config_empty --save --no-act --no-dereference`;

ok $output =~ '"link":{"mtime":42}';
ok $output =~ '"original":{"mtime":2272147200}';

$output = `./metamonger --config=../files/config_empty --save --no-act`;

ok $output =~ '"link":{"mtime":2272147200}';
ok $output =~ '"original":{"mtime":2272147200}';


rm_rf '../etc';

done_testing;
