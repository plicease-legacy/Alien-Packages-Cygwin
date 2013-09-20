# Alien::Packages::Cygwin

Get information from Cygwin's packages via cygcheck and LWP

# SYNOPSIS

    use Alien::Packages::Cygwin;
    
    foreach my $package (Alien::Packages::Cygwin->list_packages)
    {
      say 'Name:    ' . $package->{Name};
      say 'Version: ' . $package->{Version};
    }

    my $perl_package = Alien::Packages::Cygwin->list_owners('/usr/bin/perl');
    say 'Perl package is ' . $perl_package->{"/usr/bin/perl"}->[0]->{Package};

# DESCRIPTION

This module provides package information for the Cygwin environment.
It can also be used as a plugin for [Alien::Packages](http://search.cpan.org/perldoc?Alien::Packages), and will be
used automatically if the environment is detected.

# METHODS

## usable

    my $usable = Alien::Packages::Cygwin->usable

Returns true when when cygcheck command was found in the path.

## list\_packages

    my @packages = Alien::Packages::Cygwin->list_packages

Returns the list of installed _cygwin_ packages.

## list\_fileowners

    my %owners = Alien::Packages::Cygwin->list_fileowners

Returns the _cygwin_ packages that are associated with the requested files.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
