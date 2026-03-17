#include <iostream>
// 初始化Lua环境
extern "C" {
    #include <lua.h>
    #include <lauxlib.h>
    #include <lualib.h>
}
int main(int, char **)
{
    std::cout << "Hello, from lua!\n";
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    if (luaL_dostring(L, "print('Hello from Lua!')") != LUA_OK)
    {
        std::cerr << "Error executing Lua code: " << lua_tostring(L, -1) << std::endl;
        lua_pop(L, 1); // Remove error message from the stack
    }
    lua_close(L);
    return 0;
}
