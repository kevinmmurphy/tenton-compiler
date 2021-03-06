#!/usr/bin/perl

package ClassNode;
use Data::Dumper;


sub new {
     my $class = shift;
     my $self = { name => shift,
		  body => shift, 
		  variables => [],
		  adjectives => []};
     bless $self, $class;
     $self->parse();
     return $self;
}

sub parse { 
     my $self = shift;
     if ($self->{body} =~ /\{(.*)\}/)
     {
     	#my @variables = $1 =~ /\s*(\S+\s+\S+?\s*?\[.*?\];)/g;
        my @variables = split(/;/, $1); 
	
        #print Dumper(@variables);
	foreach my $variable (@variables)
     	{
     	   if ($variable =~ /\s*(\S+)\s+(\S+)\s*?(\[?.*?\]?)$/)
	   {
     	        #print "type:$1 name:$2 attributes:$3\n";
		my $type = $1;
	        my $name = $2;
		my $attributes = $3;
                if ($type =~ /^adjective$/)
		{
		     push($self->{adjectives}, $name);
		} 	
		else 
		{
		     $attributes =~ s/[\[\],]/ /g;
		     my @attrs= ($attributes =~ /(\w+)/g);
		     push($self->{variables}, {type => $type, name => $name, attributes => [@attrs],});
		}
           }
	}
     }
     else
     {
	print "Invalid class body!";
     }
     delete($self->{body});
     #print Dumper($self);
}

sub GetName {
     my $self = shift;
     return $self->{name};
}

sub GetAdjectives{
     my $self = shift;
     return $self->{adjectives};
}

sub GetVariables {
     my $self = shift;
     return $self->{variables};
}

1;
