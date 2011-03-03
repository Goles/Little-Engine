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

-- SceneManager Interface
function pushScene(scene)
	SceneManager.getInstance():addScene(scene)
end

function activateScene(scene)
	SceneManager.getInstance():setActiveScene(scene.label)
end

-- Font Manager Interface
function textRenderer(in_font_name, in_font_size)
	return FontManager.getInstance():getTextRenderer(in_font_name, in_font_size)
end
