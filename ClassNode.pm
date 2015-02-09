#!/usr/bin/perl

use Data::Dumper;

package ClassNode;

sub new {
     my $class = shift;
     my $self = { name => shift,
		  body => shift, 
		  variables => ()};
     bless $self, $class;
     return $self;
}

sub parse { 
     my $self = shift;
     if ($self->{body} =~ /\{(.*)\}/)
     {
     	my @variables = $1 =~ /\s*(\S+\s+\S+\s*\[.*\]);/g;
     	foreach my $variable(@variables)
     	{
     	   $variable =~ /\s*(\S+)\s+(\S+)\s*(\[.*\]);/g
     	   print "type:$1 name:$2 attributes:$3";
     	   push($self->{variables}, {type => $1, name => $2, attributes => $3,});
     	}
     }
     else
     {
	print "Invalid class body!";
     }
}
1;
