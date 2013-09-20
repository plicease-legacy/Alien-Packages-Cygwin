use strict;
use warnings;
use v5.10;
use Test::More tests => 1;

BEGIN { eval q{ use EV } }

my @modules = sort qw(
  Alien::Packages
);

pass 'okay';

diag '';
diag '';
diag '';

diag sprintf "%-20s %s", 'perl', $^V;

foreach my $module (@modules)
{
  if(eval qq{ use $module; 1 })
  {
    diag sprintf "%-20s %s", $module, eval qq{ \$$module\::VERSION } // 'undef';
  }
  else
  {
    diag sprintf "%-20s none", $module;
  }
}

diag '';
diag '';
diag '';

