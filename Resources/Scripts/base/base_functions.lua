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

function activateScene(sceneName)
	SceneManager.getInstance():setActiveScene(sceneName)
end