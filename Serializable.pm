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

     print $fh "     string Serialize(void) const;\n";
     print $fh "     void Deserialize(const string &instr);\n";
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
     print $fh "\n\n#include \"Jzon.h\"\n";
     #
     # Define Serialize method
     #
     print $fh "std::string $classname\::Serialize(void) const {\n";
     print $fh "     std::string retval;\n"; 
     print $fh "     Jzon::Writer writer;\n";
     print $fh "     Jzon::Node node = Jzon::object();\n\n"; 
     #
     # Serialize a object type
     #
     print $fh "     node.add(\"Type\", \"$classname\");\n";
     #
     # Serialize each data member
     #
     foreach my $v (@$variables) {
          my $varname = $v->{name};
          my $type = $v->{type};

my $line = <<"EOT";
     node.add("$varname", m_$varname);
EOT
          print $fh $line;

     }
     print $fh "     writer.setFormat(Jzon::NoFormat);\n";
     print $fh "     writer.writeString(node, retval);\n"; 
     print $fh "     return retval;\n";
     print $fh "}\n\n\n";
     #
     # Define Deserialize method
     #
     print $fh "void $classname\::Deserialize(const std::string &instr) {\n";
     print $fh "     Jzon::Parser parser;\n";
     print $fh "     Jzon::Node object = parser.parseString(instr);\n";
     print $fh "     if (object.isValid() && object.isObject() ) {\n";
     print $fh "          Jzon::Node node;\n\n"; 
     #
     # Deserialize the type memeber and throw if not our class
     #
     print $fh "          node = object.get(\"Type\");\n";
     print $fh "          if (!node.isString() || !(node.toString().compare(\"$classname\") == 0)){\n"; 
     print $fh "               throw;\n";
     print $fh "          }\n";
     #
     # Deserialize each of the members
     #
     foreach my $v (@$variables) {
          my $varname = $v->{name};
          my $type = $v->{type};

     print $fh "          node = object.get(\"$varname\");\n"; 
          if ($type eq "int"){
     print $fh "          if (node.isNumber()) { m_$varname = node.toInt(); }\n";
          } elsif ($type eq "string"){
     print $fh "          if (node.isString()) { m_$varname = node.toString(); }\n";
          } elsif ($type eq "bool"){
     print $fh "          if (node.isBool()) { m_$varname = node.toBool(); }\n";
          }
     print $fh "          else { throw; }\n\n";
     }

     print $fh "     }\n";
     print $fh "     else { throw; }\n";

     print $fh "\n}\n";

     

}

1;
