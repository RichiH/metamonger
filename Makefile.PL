#!/usr/bin/env perl

use inc::Module::Install;

name 'metamonger';
version '0.20130627';
perl_version '5.8.4';
author 'Metamonger contributors (https://github.com/RichiH/metamonger)';
license 'GPL2+';

all_from 'metamonger';

requires 'Config::Simple';
requires 'Data::Dumper';
requires 'File::Copy';
requires 'File::Util';
requires 'Getopt::Long';
requires 'Hash::Merge::Simple';
requires 'JSON';
requires 'Log::Contextual';
requires 'Log::Log4perl';
requires 'PadWalker';
requires 'Shell::Command';
requires 'utf8::all';

test_requires 'Test::Most';

install_script 'metamonger';
auto_install;
WriteAll;
