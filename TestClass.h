#include "ISerializable.h"





class TestClass : public Serializable
{

public:
     TestClass(void);
     ~TestClass(void);

     void SetMyNumber( const int inarg){ m_MyNumber = inarg; };
     int GetMyNumber( void ) const { return m_MyNumber; };

     void SetMyOtherNumber( const int inarg){ m_MyOtherNumber = inarg; };
     int GetMyOtherNumber( void ) const { return m_MyOtherNumber; };

     void SetMyString( const string inarg){ m_MyString = inarg; };
     string GetMyString( void ) const { return m_MyString; };

     void SetMyBool( const bool inarg){ m_MyBool = inarg; };
     bool GetMyBool( void ) const { return m_MyBool; };

     string Serialize(void) const;
     void Deserialize(const string &instr);

private:
     int m_MyNumber;

     int m_MyOtherNumber;

     string m_MyString;

     bool m_MyBool;


};
