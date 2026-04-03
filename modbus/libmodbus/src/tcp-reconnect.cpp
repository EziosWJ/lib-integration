#include <iostream>
#include "modbus-tcp.h"

int main(int, char **)
{
    std::cout << "Hello, from baselibmodbus!\n";
    auto ctx = modbus_new_tcp("127.0.0.1", 9999);
    
    modbus_connect(ctx);
    modbus_set_slave(ctx, 1);
    for (size_t i = 0; i < 10; i++)
    {
        sleep(2);
        std::cout << "Loop -> " << i << std::endl;
        /* code */
        uint16_t tab_reg[32] = {0};
        int rc = modbus_read_registers(ctx, 0, 10, tab_reg);
        if(rc == -1)
        {
            auto err = errno;
            std::cerr << "Read failed: " << err << " - " << modbus_strerror(err) << std::endl;
            if(err == 32 || err == 104 || err == 9){ // Broken pipe or Connection reset by peer
                std::cerr << "Connection lost, trying to reconnect..." << std::endl;
                modbus_close(ctx);
                modbus_connect(ctx);
            }
            continue;
        }
        for (int j = 0; j < 10; ++j)
        {
            std::cout << "reg[" << j << "]=" << tab_reg[j] << std::endl;
        }
    }

    return 0;
}
