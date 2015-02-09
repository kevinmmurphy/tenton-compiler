#!/usr/bin/perl

package ClassNode;
use Data::Dumper;


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
     	#my @variables = $1 =~ /\s*(\S+\s+\S+?\s*?\[.*?\];)/g;
        my @variables = split(/;/, $1); 
	
        print Dumper(@variables);
	foreach my $variable (@variables)
     	{
     	   if ($variable =~ /\s*(\S+)\s+(\S+)\s*?(\[?.*?\]?)$/)
	   {
     	        print "type:$1 name:$2 attributes:$3\n";
     	        #push($self->{variables}, {type => $1, name => $2, attributes => $3,});
           }
	}
     }
     else
     {
	print "Invalid class body!";
     }
}
1;
