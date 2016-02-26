#!/usr/bin/perl

package LangManager;

use ClassNode;
use Data::Dumper;
use IO::File;



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
     
     $iname = $iname . ".cpp";
     $hname = $hname . ".h";

     $self->GenerateHeader($hname, $classnode);
     $self->GenerateImplementation($iname, $classnode);
}

sub GenerateHeader {
     my $self = shift;
     my $filename = shift;
     my $class = shift;

     $fh = IO::File->new();
     if ($fh->open("> $filename")) {
          
          print $fh "#include stdio.h\n";
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          my $classname = $class->GetName();
          print $fh "class $classname {\n";
          print $fh "\n";
          print $fh "public:\n";
          #
          # print the getters and setters
	  # 
          my $variables = $class->GetVariables();
          foreach my $v (@$variables) {
               my $varname = $v->{name};
               my $type = $v->{type};
               
               print $fh "     void Set$varname\( const $type inarg){ m_$varname = inarg; }\n";
               print $fh "     $type Get$varname\( void ){ return m_$varname; }\n";
               print $fh "\n";	
          }


          print $fh "\n";
          print $fh "private:\n";
          #
          # print the member variables
          # 
          foreach my $v (@$variables) {
               my $varname = $v->{name};
               my $type = $v->{type};
               
               print $fh "     $type m_$varname;\n";
               print $fh "\n";	
          }
          print $fh "\n";
          print $fh "};\n";

	  $fh->close(); 
     } 


}

sub GenerateImplementation {



}


1;
