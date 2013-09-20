use strict;
use warnings;
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
    my $ver = eval qq{ \$$module\::VERSION };
    $ver = 'undef' unless defined $ver;
    diag sprintf "%-20s %s", $module, $ver;
  }
  else
  {
    diag sprintf "%-20s none", $module;
  }
}

diag '';
diag '';
diag '';

