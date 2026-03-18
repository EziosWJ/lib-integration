local t2_module = require("t2_module")
local client_ = { name = "TestClient" }
print("Client Name:", t2_module.read())

t2_module.setClient(client_)
print("Client Name after setting client:", t2_module.read())