cmake_minimum_required(VERSION 3.10.0)
project(baselibmodbus VERSION 0.1.0 LANGUAGES C CXX)

add_executable(baselibmodbus main.cpp)

include(LibmodbusPreset.cmake)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE modbus)