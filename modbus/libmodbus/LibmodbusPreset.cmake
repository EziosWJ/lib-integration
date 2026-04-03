# 检测必要的工具
find_program(AUTOCONF_EXECUTABLE autoconf)
find_program(AUTORECONF_EXECUTABLE autoreconf)
find_program(ACLOCAL_EXECUTABLE aclocal)
find_program(AUTOMAKE_EXECUTABLE automake)

if(NOT AUTOCONF_EXECUTABLE OR NOT AUTORECONF_EXECUTABLE)
    message(FATAL_ERROR 
        "Required autotools not found:\n"
        "  autoconf: ${AUTOCONF_EXECUTABLE}\n"
        "  autoreconf: ${AUTORECONF_EXECUTABLE}\n"
    )
endif()

include(FetchContent)

FetchContent_Declare(
    libmodbus
    GIT_REPOSITORY https://github.com/EziosWJ/libmodbus.git
    GIT_TAG udp_support
    GIT_SHALLOW TRUE
)


# 这会在cmake配置阶段就下载
# 只下载源码，不使用 MakeAvailable
FetchContent_GetProperties(libmodbus)
if(NOT libmodbus_POPULATED)
    FetchContent_Populate(libmodbus)
endif()
if(EXISTS ${libmodbus_SOURCE_DIR}/build-aux)
    message(STATUS "LibModbus已经autoconf...")
else ()
    message(STATUS "LibModbus执行./autogen.sh...")
    # 在源码目录执行autotools命令
    execute_process(
            COMMAND ./autogen.sh
            WORKING_DIRECTORY ${libmodbus_SOURCE_DIR}
            RESULT_VARIABLE LIBMODBUS_CMD_RESULT
            OUTPUT_VARIABLE LIBMODBUS_CMD_OUTPUT
            ERROR_VARIABLE LIBMODBUS_CMD_ERROR
    )
    message(STATUS ${LIBMODBUS_CMD_OUTPUT})
endif ()
# 检测是否配置
if(EXISTS ${libmodbus_SOURCE_DIR}/config.h)
    message(STATUS "LibModbus已经configure...")
else ()
    message(STATUS "LibModbus执行./configure...")
    execute_process(
            COMMAND ./configure
            --prefix=${libmodbus_BINARY_DIR}/
            --disable-shared
            --enable-static
            --disable-tests
            --disable-doxygen
            CFLAGS=-fPIC
            WORKING_DIRECTORY ${libmodbus_SOURCE_DIR}
            RESULT_VARIABLE LIBMODBUS_CMD_RESULT
            OUTPUT_VARIABLE LIBMODBUS_CMD_OUTPUT
            ERROR_VARIABLE LIBMODBUS_CMD_ERROR
    )
    message(STATUS ${LIBMODBUS_CMD_OUTPUT})
endif ()
# 添加为静态库
add_library(modbus STATIC ${libmodbus_SOURCE_DIR}/src/modbus-data.c
        ${libmodbus_SOURCE_DIR}/src/modbus-rtu.c
        ${libmodbus_SOURCE_DIR}/src/modbus-tcp.c
        ${libmodbus_SOURCE_DIR}/src/modbus-udp.c
        ${libmodbus_SOURCE_DIR}/src/modbus.c
)
target_include_directories(modbus PUBLIC ${libmodbus_SOURCE_DIR}/src ${libmodbus_SOURCE_DIR})
