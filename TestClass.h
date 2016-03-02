#include "ISerializable.h"
#include "IStorable.h"





class TestClass: public Serializable,
		public Storable
{

public:
     void SetMyNumber( const int inarg){ m_MyNumber = inarg; }
     int GetMyNumber( void ) const { return m_MyNumber; }

     void SetMyOtherNumber( const int inarg){ m_MyOtherNumber = inarg; }
     int GetMyOtherNumber( void ) const { return m_MyOtherNumber; }

     void SetMyString( const string inarg){ m_MyString = inarg; }
     string GetMyString( void ) const { return m_MyString; }

     void SetMyBool( const bool inarg){ m_MyBool = inarg; }
     bool GetMyBool( void ) const { return m_MyBool; }

     std::wstring Serialize(void);
     
private:
     int m_MyNumber;

     int m_MyOtherNumber;

     string m_MyString;

     bool m_MyBool;


};
