cmake_minimum_required(VERSION 3.10.0)
project(lua-integration VERSION 0.1.0 LANGUAGES C CXX)

add_executable(${PROJECT_NAME} main.cpp)

# 导入Lua库
include(cmake/lua.cmake)
add_lua()

# 链接Lua库到项目
target_link_libraries(${PROJECT_NAME} PRIVATE lua)

# 导入sol2库
add_lua_sol2()
add_executable(sol_use sol_use.cpp)
target_link_libraries(sol_use PRIVATE lua sol2)