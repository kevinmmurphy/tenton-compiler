#!/usr/bin/perl

package ClassNode;

sub new {
     my $class = shift;
     my $self = { _input => shift, };
     bless $self, $class;
     return $self;
}

sub parse { 
     my $self  = @_;
     $input = $self->{_input}; 
     while (<$input>){
          print "$_";
     }
}
1;
