include(FetchContent)

FetchContent_Declare(
    eventbus
    GIT_REPOSITORY https://github.com/XQQYT/EventBus.git
    GIT_TAG        v1.1.2
)

# 获取属性而不调用 MakeAvailable (避免自动 add_subdirectory 可能带来的问题)
FetchContent_GetProperties(eventbus)
if(NOT eventbus_POPULATED) # 如果还没有被填充（下载）
    FetchContent_Populate(eventbus) # 下载并准备好源代码
    
    # 手动创建一个 INTERFACE 库
    add_library(eventbus INTERFACE)
    
    # 设置包含目录 (使用 _SOURCE_DIR 变量，由 Populate 填充)
    target_include_directories(eventbus 
        INTERFACE 
        ${eventbus_SOURCE_DIR}/include # 根据实际头文件位置调整
    )
endif()