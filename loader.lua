local HUB_URL = "https://raw.githubusercontent.com/NateeDevvvvvv/code-saa/main/main.lua"
local CURRENT_VERSION = "v3.1"

local success, hub = pcall(function()
	return game:HttpGet(HUB_URL, true)
end)

if success and hub then
	loadstring(hub)()
else
	warn("Failed to load NateeHubb main.lua from GitHub")
end
