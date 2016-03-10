#!/usr/bin/perl

package LangManager;

use ClassNode;
use Data::Dumper;
use IO::File;
use Module::Load;


sub new {
     my $class = shift;
     my $self = {};
     return bless ($self, $class);
}

sub Generate {
     my $self = shift;
     my $classnode = shift;
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
          my $variables = $class->GetVariables();
          my $adjectives = $class->GetAdjectives();
          #
          # print out headers and includes
          # 
          #print $fh "#include stdio.h\n";
          foreach my $a (@$adjectives)
          {
               print $fh "#include \"I$a.h\"\n"; 
          }
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          print $fh "\n";
          my $classname = $class->GetName();
          print $fh "class $classname : ";
          #
          # write out inheritance
          #
          my @inhr;
	  foreach my $b (@$adjectives)
          {
             push(@inhr, "public " . $b);
          }
          my $inheritance = join(",\n\t\t", @inhr);
          print $fh $inheritance;
          #
          # Open class definition
          #
          print $fh "\n{\n";
          print $fh "\n";
          print $fh "public:\n";
          #
          # Define class constructor
          #
          print $fh "     $classname(void);\n";
          #
          # Define class destructor
          #
          print $fh "     ~$classname(void);\n\n";
          #
          # print the getter for the Type
          # 
          print $fh "     std::string GetType( void ) const { return std::string(\"$classname\"); };\n\n";
          #
          # print the getters and setters
	  # 
          foreach my $v (@$variables) {
               my $varname = $v->{name};
               my $type = $v->{type};
               
               print $fh "     void Set$varname\( const $type inarg){ m_$varname = inarg; };\n";
               print $fh "     $type Get$varname\( void ) const { return m_$varname; };\n";
               print $fh "\n";	
          }
	  #
          # Write Interface methods
          #
          foreach my $class (@$adjectives)
    	  {
               print "Loading package $class...\n"; 
	       load($class);
               my $temp = $class->new();
	       if ($temp->can('DeclareMethods')) 
               {
                    $temp->DeclareMethods($fh);
               }
               else 
               {
                    print "Unable to call method!\n";
               }
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
     my $self = shift;
     my $filename = shift;
     my $classnode = shift;


     $fh = IO::File->new();
     if ($fh->open("> $filename")) {
          print "Opened implementation file.\n";
          my $classname = $classnode->GetName();

          print $fh "#include \"$classname.h\"\n\n"; 
          
          #
          # Write Class Constructor
          # 
          print $fh "$classname\::$classname(void) :";
          my $variables = $classnode->GetVariables();
          my @varnames;
          foreach my $v (@$variables) {
               my $varname = $v->{name};
               my $type = $v->{type};

               if ($type eq "int"){
                    push(@varnames, "m_$varname" . "(DEFAULT_INT)");
               } elsif ($type eq "string"){
                    push(@varnames, "m_$varname" . "(DEFAULT_STR)");
               } elsif ($type eq "bool"){
                    push(@varnames, "m_$varname" . "(DEFAULT_BOOL)");
               }
          }
          my $varinits = join(",\n\t\t\t\t", @varnames);
          print $fh "$varinits\n";

          print $fh "{\n";
          print $fh "}\n";
          #
          # Write Class Destructor
          #

          print $fh "$classname\::~$classname(void){}\n"; 
	  #
          # Write Interface methods
          #
          my $adjectives = $classnode->GetAdjectives();
          foreach my $class (@$adjectives)
    	  {

	       load($class);
               my $temp = $class->new();
	       if ($temp->can('DefineMethods')) 
               {
                   print "Implementing methods for $class.\n";
                   $temp->DefineMethods($fh, $classnode);
               }
               else 
               {
                    print "Unable to call method!\n";
               }
          }
          $fh->close(); 
     }
}


1;
