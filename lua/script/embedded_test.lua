-- 假设有一个数字
local num = 255 -- 二进制: 11111111

-- ==========================================
-- 1. 移位运算
-- ==========================================

-- 左移 (Left Shift): num << n
local left_shift = num << 2 
print("255 左移 2 位:", left_shift) -- 输出: 1020 (二进制: 1111111100)

-- 右移 (Right Shift): num >> n
local right_shift = num >> 4
print("255 右移 4 位:", right_shift) -- 输出: 15 (二进制: 1111)

-- ==========================================
-- 2. 取某一位的值 (Get bit at position n)
-- ==========================================
-- 注意：通常位置从 0 开始计数 (第0位是最低位)
-- 公式: (num >> n) & 1

local function get_bit(value, n)
    return (value >> n) & 1
end

local val = 10 -- 二进制: 1010
print("10 的第 0 位:", get_bit(val, 0)) -- 0
print("10 的第 1 位:", get_bit(val, 1)) -- 1
print("10 的第 2 位:", get_bit(val, 2)) -- 0
print("10 的第 3 位:", get_bit(val, 3)) -- 1

-- ==========================================
-- 3. 数字转十六进制字符串
-- ==========================================

-- 小写 hex (例如: "ff")
local hex_lower = string.format("%x", num)
print("255 转十六进制(小写):", hex_lower)

-- 大写 HEX (例如: "FF")
local hex_upper = string.format("%X", num)
print("255 转十六进制(大写):", hex_upper)

-- 带前缀和固定宽度 (例如: "0x00FF")
local hex_formatted = string.format("0x%04X", num)
print("255 转十六进制(格式化):", hex_formatted)