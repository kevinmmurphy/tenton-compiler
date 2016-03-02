#!/usr/bin/perl

package Serializable;


use ClassNode;

sub new { 
  my $class = shift;
  my $self = {};
  return bless($self, $class);
}

sub DeclareMethods {
     $self = shift;
     $fh   = shift;

     print $fh "std::wstring Serialize(void) const;\n";
     print $fh "void Deserialize(const std::wstring &instr);\n";
}

sub DefineMethods {
     $self = shift;
     $fh = shift;
     $classnode = shift; 

     $classname = $classnode->GetName();
     $variables = $classnode->GetVariables();
     
     #
     # Define Serialize method
     #

     print $fh "std::string $classname\::Serialize(void) const {\n";
     #
     # iterate the variables and write them to a string
     #
     print $fh "     std::string retval;\n"; 
     print $fh "     retval << \'{\'\n";
     @methodsstring;
     foreach my $v (@$variables) {
          my $varname = $v->{name};
          my $type = $v->{type};


my $line = <<"EOT";
     retval << "\\\"$varname\\\":\\\"" << m_$varname << "\\\"";
EOT


          print $fh $line;

     }
      
     print $fh "     retval << \'}\'\n";
     print $fh "     return retval;";
     print $fh "\n}\n";


     #
     # Define Deserialize method
     #

     print $fh "void $classname\::Deserialize(const std::string &instr) {\n";



     print $fh "\n}\n";

     

}

1;
