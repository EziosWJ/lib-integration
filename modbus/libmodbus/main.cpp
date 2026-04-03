#include <iostream>
#include "modbus-tcp.h"

int main(int, char **)
{
    auto ctx = modbus_new_tcp("127.0.0.1", 9999);

    modbus_connect(ctx);
    modbus_set_slave(ctx, 1);

    /* code */
    uint16_t tab_reg[32] = {0};
    int rc = modbus_read_registers(ctx, 0, 10, tab_reg);
    for (int j = 0; j < 10; ++j)
    {
        std::cout << "reg[" << j << "]=" << tab_reg[j] << std::endl;
    }

    return 0;
}
