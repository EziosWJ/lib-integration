#include <iostream>

#include "eventpp/eventdispatcher.h"
#include <thread>
#include <sstream>
eventpp::EventDispatcher<int, void()> dispatcher;

std::string getThreadId()
{
    std::stringstream ss;
    ss << std::this_thread::get_id();
    return ss.str();
}

int main(int, char **)
{
    std::cout << "Hello, from eventpp-starter!\n";
    dispatcher.appendListener(3, []()
                              { 
                                std::cout << getThreadId() << " : " ;
                                std::cout << "Got event 3." << std::endl; });
    dispatcher.appendListener(5, []()
                              { 
                                std::cout << getThreadId() << " : " ;std::cout << "Got event 5." << std::endl; });
    dispatcher.appendListener(5, []()
                              { 
                                std::cout << getThreadId() << " : " ;std::cout << "Got another event 5." << std::endl; });
    std::thread t1([](){
        // dispatch event 3
        dispatcher.dispatch(3);
    })  ;                              
    // dispatch event 5
    dispatcher.dispatch(5);
    t1.join();
}
