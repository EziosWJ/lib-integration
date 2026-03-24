#include "eventpp/eventqueue.h"
#include <iostream>
#include <thread>
#include <sstream>
eventpp::EventQueue<int, void(const std::string &, const bool)> queue;
std::string getThreadId()
{
    std::stringstream ss;
    ss << std::this_thread::get_id();
    return ss.str();
}
int main(char **)
{
    queue.appendListener(3, [](const std::string s, bool b)
                         { std::cout << getThreadId() << " : " ;std::cout << std::boolalpha << "Got event 3, s is " << s << " b is " << b << std::endl; });
    queue.appendListener(5, [](const std::string s, bool b)
                         { std::cout << getThreadId() << " : " ;std::cout << std::boolalpha << "Got event 5, s is " << s << " b is " << b << std::endl; });

    // The listeners are not triggered during enqueue.
    queue.enqueue(3, "Hello", true);
    queue.enqueue(5, "World", false);

    std::cout << getThreadId() << " : " << "process" << std::endl;
    std::thread t1([](){
        // Process the event queue, dispatch all queued events.
        queue.process();
    })  ;
    // Process the event queue, dispatch all queued events.
    // queue.process();
    t1.join();
    return 0;
}