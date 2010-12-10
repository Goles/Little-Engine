require "EntityBuilder"
require "tableprint"
function buildScene(sceneName)

	assert(type(sceneName) == "string", "The Scene Name for build scene must be a File Name")

	sceneTable = dofile(filePath(sceneName));

	aScene = Scene()
	entities = {}

	aScene.sceneId = sceneTable.id
	
	i = 1

	for k,v in pairs(sceneTable.entities) do
		entities[i] = buildEntity(v.id) 
		
		-- If we assign a position to the entity {x= 20, y=30}.
		if(type(v.position) == "table") then
			entities[i]:setPosition(v.position.x, v.position.y)
		end
		
		-- If we want to randomize the entity position within the device screen.
		if((v.random ~= nil) and (v.random == true)) then
			entities[i]:setPosition(math.random(0,480), math.random(0,320))
		end
		
		-- entities[i]:setIsActive(true)
		aScene:addEntity(entities[i])	-- Add a coolDude to the scene.
		
		i = i + 1
	end
		
	return aScene
end