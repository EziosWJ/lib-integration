local M = {}


local client_ = nil

function M.setClient(cli)
    client_ = cli
end

function M.read()
    if not client_ then
        return "No client connected"
    end
    local clientName = client_.name
    return clientName
end

return M