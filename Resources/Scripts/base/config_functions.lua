--[[
	config_functions.lua
	Copyright 2011 Nicolas Goles. All Rights Reserved. 
]]--

-- ===============================================
-- = Configuration Functions for System Managers =
-- ===============================================

function SceneManagerConfig(t)
	
	if t.window then
		SceneManager.getInstance().window = ggs(t.window.width, t.window.height)
	end
		
end