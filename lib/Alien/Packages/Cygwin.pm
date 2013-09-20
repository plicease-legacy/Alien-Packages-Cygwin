package Alien::Packages::Cygwin;

use strict;
use warnings;
use IPC::Cmd qw( can_run );

# ABSTRACT: Get information from Cygwin's packages via cygcheck and LWP
# VERSION

=head1 SYNOPSIS

 use Alien::Packages::Cygwin;
 
 foreach my $package (Alien::Packages::Cygwin->list_packages)
 {
   say 'Name:    ' . $package->{Name};
   say 'Version: ' . $package->{Version};
 }

 my $perl_package = Alien::Packages::Cygwin->list_owners('/usr/bin/perl');
 say 'Perl package is ' . $perl_package->{"/usr/bin/perl"}->[0]->{Package};

=head1 DESCRIPTION

This module provides package information for the Cygwin environment.
It can also be used as a plugin for L<Alien::Packages>, and will be
used automatically if the environment is detected.

=cut

if(eval { require Alien::Packages::Base; 1 })
{
  our @ISA = qw( Alien::Packages::Base );
}

my $cygcheck;

=head1 METHODS

=head2 usable

 my $usable = Alien::Packages::Cygwin->usable

Returns true when when cygcheck command was found in the path.

=cut

sub usable
{
  unless(defined $cygcheck)
  {
    $cygcheck = can_run 'cygcheck';
  }
  
  $cygcheck;
}

=head2 list_packages

 my @packages = Alien::Packages::Cygwin->list_packages

Returns the list of installed I<cygwin> packages.

=cut

sub list_packages
{
  my @packages;

  __PACKAGE__->usable;
  
  foreach my $line (`$cygcheck -c -d`)
  {
    next if $line =~ /^(Cygwin Package Information|Package\s+Version)/;
    chomp $line;
    my($package,$version) = split /\s+/, $line;
    push @packages, {
      Package     => $package,
      Version     => $version,
      Description => '',
    };
  }
  
  @packages;
}

=head2 list_fileowners

 my %owners = Alien::Packages::Cygwin->list_fileowners

Returns the I<cygwin> packages that are associated with the requested files.

=cut

sub list_fileowners
{
  my($self, @files) = @_;
  my %owners;

  __PACKAGE__->usable;

  foreach my $file (@files)
  {
    my $output = `$cygcheck -f $file`; # FIXME: files with spaces
    if($output =~ s/-[^-]*-[^-]*\s+//)
    {
      push @{ $owners{$file} }, { Package => $output };
    }
  }  
  
  %owners;
}

1;
