#!/usr/bin/perl

package Cplusplus;

sub new {
     my $class = shift;
     my $self = {};
     return bless ($self, $class);
}

sub Generate {
     my $self = shift;
     my $classnode = shift;
     my @variables = $classnode->GetVariables();
     my @attributes = $classnode->GetAttributes();
     my $hname = $classnode->GetName();
     my $iname = $classnode->GetName();
     print "Header:$hname Implementation:$iname\n";
}

1;
