local bit_lib = require("bit_ops")

local result = bit_lib.get_bit(10, 1) -- 获取10的第1位，应该返回1
print("结果:", result)