#ifndef IVISITABLE_H
#define IVISITABLE_H
class Visitor;

class Visitable {
public:
     void Accept(Visitor visitor);

};


#endif
