#ifndef IVISITABLE_H
#define IVISITABLE_H

class Visitor {
public: 
    void Visit(TestClass &c);

};

class Visitable {
public:
     void Accept(Visitor visitor);

};


#endif
