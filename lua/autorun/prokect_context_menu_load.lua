-- Loader file for 'prokect_context_menu'
-- Automatically created by gcreator (github.com/wasied)
ProkectContext = {}

-- Make loading functions
local function Inclu(f) return include("prokect_context_menu/"..f) end
local function AddCS(f) return AddCSLuaFile("prokect_context_menu/"..f) end
local function IncAdd(f) return Inclu(f), AddCS(f) end

-- Load addon files
IncAdd("config.lua")
-- IncAdd("constants.lua")

if SERVER then

	-- Inclu("server/sv_functions.lua")
	-- Inclu("server/sv_hooks.lua")
	-- Inclu("server/sv_network.lua")

	AddCS("client/cl_functions.lua")
	AddCS("client/cl_hooks.lua")
	AddCS("client/cl_network.lua")

else

	Inclu("client/cl_functions.lua")
	Inclu("client/cl_hooks.lua")
	Inclu("client/cl_network.lua")

end
