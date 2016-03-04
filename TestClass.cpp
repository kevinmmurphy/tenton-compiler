#include "TestClass.h"

TestClass::TestClass(void){
}
TestClass::~TestClass(void){}
#include "Jzon.h"
std::string TestClass::Serialize(void) const {
     std::string retval;
     Jzon::Writer writer;
     Jzon::Node node = Jzon::object();

     node.add("MyNumber", m_MyNumber);
     node.add("MyOtherNumber", m_MyOtherNumber);
     node.add("MyString", m_MyString);
     node.add("MyBool", m_MyBool);
     writer.writeString(node, retval);
     writer.setFormat(Jzon::NoFormat);
     return retval;
}
void TestClass::Deserialize(const std::string &instr) {
     Jzon::Parser parser;
     Jzon::Node object = parser.parseString(instr);
     if (object.isValid() && object.isObject() ) {
          Jzon::Node node;

          node = object.get("MyNumber");
          if (node.isNumber()) { m_MyNumber = node.toInt(); }
          else { throw; }

          node = object.get("MyOtherNumber");
          if (node.isNumber()) { m_MyOtherNumber = node.toInt(); }
          else { throw; }

          node = object.get("MyString");
          if (node.isString()) { m_MyString = node.toString(); }
          else { throw; }

          node = object.get("MyBool");
          if (node.isBool()) { m_MyBool = node.toBool(); }
          else { throw; }

     }
     else { throw; }

}
