#!/usr/bin/perl

package Visitable;




sub new {
  my $class = shift;
  my $self = {};
  return bless($self, $class);
}


sub DeclareMethods {

     $self = shift;
     $fh   = shift;

     print $fh "\n     void Accept(Visitor visitor);\n";
}

sub DefineMethods {

     $self = shift;
     $fh   = shift;
     $classnode = shift; 

     print $fh "\nvoid $classname\::accept(Visitor visitor){\n";
     print $fh "     visitor.Visit(this);\n}\n";
}


1; 
