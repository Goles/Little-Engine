--[[
	base_functions.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "tableprint"

-- This function is bound to std::vector<float>
function makeFloatVector(t)
	vector = float_vector()
	
	if(type(t) == "number") then
		vector:push_back(t)
	end
	
	if(type(t) == "table") then
		for i,v in ipairs(t) do
			vector:push_back(v)
		end
	end
	
	return vector
end

-- This function is bound to std::vector<int>
function makeIntVector(t)
	vector = int_vector()
	
	for i,v in ipairs(t) do
		vector:push_back(v)
	end
	
	return vector
end

-- pseudo round function using only floor and ceil
function round(val, decimal)
  if (decimal) then
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
  else
    return math.floor(val+0.5)
  end
end

-- ======================
-- = MANAGER INTERFACES =
-- ======================

--
-- SceneManager Interface
--
function pushScene(scene)
	SceneManager.getInstance():addScene(scene)
end

function activateScene(scene)
	SceneManager.getInstance():setActiveScene(scene.label)
end

--
-- Font Manager Interface
--
function textRenderer(in_font_name, in_font_size)
	return FontManager.getInstance():getTextRenderer(in_font_name, in_font_size)
end

--
-- Simple Audio Engine Interface
--
function preloadBackgroundMusic(in_fileName)
	SimpleAudioEngine.getInstance():__preloadBackgroundMusic(in_fileName)
end

function stopBackgroundMusic()
	SimpleAudioEngine.getInstance():_stopBackgroundMusic(false)
end

function playBackgroundMusic(in_fileName, in_loop)
	
	if in_loop == nil then in_loop = false end
	
	SimpleAudioEngine.getInstance():_playBackgroundMusic(in_fileName, in_loop)
end

function pauseBackgroundMusic()
	SimpleAudioEngine.getInstance():_pauseBackgroundMusic()
end

function resumeBackgroundMusic()
	SimpleAudioEngine.getInstance():_resumeBackgroundMusic()
end

function setBackgroundMusicVolume(in_volume)
	assert(in_volume > 1.0, "ERROR: in_volume can't be higher than 1.0f")
	assert(in_volume < 0.0, "ERROR: in_volume can't be lower than 0.0f")
	SimpleAudioEngine.getInstance():_setBackgroundMusicVolume(in_volume)
end

function setEffectsVolume(in_volume)
	assert(in_volume > 1.0, "ERROR: in_volume can't be higher than 1.0f")
	assert(in_volume < 0.0, "ERROR: in_volume can't be lower than 0.0f")
	SimpleAudioEngine.getInstance():_setEffectsVolume(in_volume)
end

function playEffect(in_effectName)
	SimpleAudioEngine.getInstance():_playEffect(in_effectName)
end

function stopEffect(in_effectId)
	SimpleAudioEngine.getInstance():_stopEffect(in_effectId)
end

function preloadEffect(in_effectName)
	SimpleAudioEngine.getInstance():_preloadEffect(in_effectName)
end

function unloadEffect(in_effectName)
	SimpleAudioEngine.getInstance():_unloadEffect(in_effectName)
end