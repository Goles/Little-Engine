-- This function is bound to std::vector<float>
function makeFloatVector(...)
	vector = float_vector()	
	
	for i,v in ipairs(arg) do
		vector:push_back(v)
	end
	
	return vector
end

-- This function is bound to std::vector<int>
function makeIntVector(...)
	vector = int_vector()	
	
	for i,v in ipairs(arg) do
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
