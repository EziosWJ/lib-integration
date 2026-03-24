#include <eventpp/eventqueue.h>
#include <thread>
#include <iostream>

// 直接使用 ThreadSafePolicy，无需额外头文件
using SafeEventQueue = eventpp::EventQueue<
    int,                          // 事件类型
    void(int),                    // 回调签名
    eventpp::DefaultPolicies,
    eventpp::ThreadSafePolicy     // ✅ 已内置，可直接用
>;

SafeEventQueue queue;

void producer() {
    for (int i = 0; i < 5; ++i) {
        queue.enqueue(100, i); // 安全入队
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }
}

void consumer() {
    while (true) {
        if (!queue.process()) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        // 实际项目中应有退出机制
    }
}

int main(int argc, char const *argv[])
{
    
    return 0;
}
