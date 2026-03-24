cmake_minimum_required(VERSION 3.10.0)
project(teb VERSION 0.1.0 LANGUAGES C CXX)

add_executable(teb main.cpp)

include(cmake/eventbus.cmake)

target_link_libraries(teb eventbus)

