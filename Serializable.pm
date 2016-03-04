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
     # Include headers
     # 
     print $fh "#include \"Jzon.h\"\n";
     #
     # Define Serialize method
     #
     print $fh "std::string $classname\::Serialize(void) const {\n";
     print $fh "     std::string retval;\n"; 
     print $fh "     Jzon:Writer writer;\n";
     print $fh "     Jzon::Node node = Jzon::object();\n\n"; 
     foreach my $v (@$variables) {
          my $varname = $v->{name};
          my $type = $v->{type};

my $line = <<"EOT";
     node.add("$varname", m_$varname);
EOT
          print $fh $line;

     }
     print $fh "     writer.writeString(node, retval);\n"; 
     print $fh "     return retval;\n";
     print $fh "}\n";
     #
     # Define Deserialize method
     #
     print $fh "void $classname\::Deserialize(const std::string &instr) {\n";
     print $fh "     Jzon::Parser parser;\n";
     print $fh "     Jzon::Node object = parser.parseString(instr);\n";
     print $fh "     if (object.isValid()) {\n";



     print $fh "     }\n";
     print $fh "     else { throw; }\n";

     print $fh "\n}\n";

     

}

1;
