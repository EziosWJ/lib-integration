cmake_minimum_required(VERSION 3.10.0)
project(eventpp-starter VERSION 0.1.0 LANGUAGES C CXX)

add_executable(eventpp-starter main.cpp)
add_executable(eventpp-starter2 main2.cpp)

include(cmake/eventpp.cmake)

target_link_libraries(eventpp-starter eventpp)
target_link_libraries(eventpp-starter2 eventpp)