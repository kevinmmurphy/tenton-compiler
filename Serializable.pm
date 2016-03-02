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

     print $fh "std::wstring Serialize(void);\n";
}

sub DefineMethods {
     $self = shift;
     $fh = shift;
     $classnode = shift; 

     $classname = $classnode->GetName();
     $variables = $classnode->GetVariables();
     

     print $fh "std::string $classname\::Serialize(void) {\n";
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
      
     print $fh "     retval << \'}\'";
     print $fh "\n}\n"

}

1;
