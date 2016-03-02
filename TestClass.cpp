std::string TestClass::Serialize(void) {
     std::string retval;
     retval << '{'
     retval << "\"MyNumber\":\"" << m_MyNumber << "\"";
     retval << "\"MyOtherNumber\":\"" << m_MyOtherNumber << "\"";
     retval << "\"MyString\":\"" << m_MyString << "\"";
     retval << "\"MyBool\":\"" << m_MyBool << "\"";
     retval << '}'
}
