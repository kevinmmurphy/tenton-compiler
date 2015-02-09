#!/usr/bin/perl

use Data::Dumper;

package ClassNode;

sub new {
     my $class = shift;
     my $self = { name => shift,
		  body => shift, };
     bless $self, $class;
     return $self;
}

sub parse { 
     my $self = shift;
     if ($self->{body} =~ /\{(.*)\}/)
     {
	while ($1 =~ /\s*(\S+)\s+(\S+)\s*(\[.*\]);/g)
	{
	  print "type:$1 name:$2";
	}
     }
     else
     {
	print "Invalid class body!";
     }
}
1;
