local M = {}

-- 自动检测环境
local bit_lib = nil
if _VERSION >= "Lua 5.3" then
    -- 5.3+ 不需要额外库，使用原生操作符
    bit_lib = "native"
    print("使用 Lua 5.3+ 原生位运算")
else
    local ok, lib = pcall(require, "bit32")
    if not ok then ok, lib = pcall(require, "bit") end
    if ok then bit_lib = lib end
end

function M.lshift(val, n)
    if bit_lib == "native" then return val << n end
    return bit_lib.lshift(val, n)
end

function M.rshift(val, n)
    if bit_lib == "native" then return val >> n end
    return bit_lib.rshift(val, n)
end

function M.get_bit(val, n)
    if bit_lib == "native" then
        return (val >> n) & 1
    else
        return bit_lib.band(bit_lib.rshift(val, n), 1)
    end
end

function M.to_hex(val, width, upper)
    local fmt = "%"
    if width then fmt = fmt .. "0" .. tostring(width) end
    fmt = fmt .. (upper and "X" or "x")
    return string.format(fmt, val)
end

return M