#include <iostream>
#include "EventBus/EventBus.hpp"
#include <sstream>
std::string getThreadId()
{
    std::stringstream ss;
    ss << std::this_thread::get_id();
    return ss.str();
}
int main(int, char **)
{
    EventBus bus;
    EventBus::EventBusConfig config{
        EventBus::ThreadModel::DYNAMIC, // 线程池模式
        EventBus::TaskModel::NORMAL,    // 任务模式
        2,                              // 最小线程数
        4,                              // 最大线程数
        1024                            // 队列容量
    };
    bus.initEventBus(config);

    bus.registerEvent("LambdaTest");
    bus.subscribe("LambdaTest", [](int a, int b)
                  { std::cout << getThreadId() << " : "  << "LambdaTest: a+b=" << a + b << std::endl; });
    bus.publish("LambdaTest", 77, 88);
    bus.publish("LambdaTest", 77, 88);
    bus.publish("LambdaTest", 77, 88);
    bus.publish("LambdaTest", 77, 88);

    return 0;
}
