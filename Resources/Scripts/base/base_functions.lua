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

-- Scene Manager Wrapper Functions
function pushScene(scene)
	SceneManager.getInstance():addScene(scene)
end

function activateScene(scene)
	SceneManager.getInstance():setActiveScene(scene.label)
end

-- pseudo round function using only floor and ceil
function round(in_number)
	
	print("Rouding")
	
	decimal_part = in_number - abs(in_number)
	
	if (decimal_part >= 0.5) then
		
		in_number = (in_number - decimal_part) + 1
		
	elseif (decimal_part < 0.5 ) then
		
		in_number = (in_number - decimal_part)
		
	end
end