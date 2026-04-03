# 1. 包含 ProcessorCount 模块
include(ProcessorCount)

# 2. 调用 ProcessorCount 函数
#    这会将 CPU 核心数存储在一个变量中（例如 CPU_COUNT）
ProcessorCount(CPU_COUNT)

# 3. 使用获取到的核心数
if(CPU_COUNT EQUAL 0)
  # 如果无法获取核心数，则设为 1
  set(CPU_COUNT 1)
endif()

message(STATUS "Number of processors available: ${CPU_COUNT}")