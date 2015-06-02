#!/usr/bin/perl

package LangManager;

use ClassNode;
use Data::Dumper;

sub new {
     my $class = shift;
     my $self = {};
     return bless ($self, $class);
}

sub Generate {
     my $self = shift;
     my $classnode = shift;
     my @variables = $classnode->GetVariables();
     my @attributes = $classnode->GetAttribures();
     my $hname = $classnode->GetName() + ".h";
     my $iname = $classnode->GetName() + ".cpp";
     print "Header:$hname Implementation:$iname\n";
}


