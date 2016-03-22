#ifndef IVISITABLE_H
#define IVISITABLE_H


#include "Visitor.h"
//class Visitor   {
// virtual void Visit( CLASSTYPE &class);
//};

class Visitable {
public:
     void Accept(Visitor visitor);

};


#endif
