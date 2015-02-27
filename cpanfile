requires 'Config::Simple';
requires 'Data::Dumper';
requires 'File::Copy';
requires 'File::Util';
requires 'Getopt::Long';
requires 'Hash::Diff';
requires 'Hash::Merge::Simple';
requires 'JSON';
requires 'Log::Contextual';
requires 'Log::Log4perl';
requires 'PadWalker';
requires 'Shell::Command';
requires 'utf8::all';

on test => sub {
	requires 'Test::More', 0.88;
};
