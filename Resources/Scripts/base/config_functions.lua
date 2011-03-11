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

function ParticleManagerConfig(t)
	
	assert(t.maxParticles ~= nil, "ERROR: Didn't specify a 'maxParticles' value for ParticleManager (config.lua)")
	assert(t.maxParticles ~= 0, "ERROR: Specify a 'maxParticles' value other than zero for ParticleManager (config.lua)")
	
	ParticleManager.getInstance():setMaxParticles(t.maxParticles)
	
end
	