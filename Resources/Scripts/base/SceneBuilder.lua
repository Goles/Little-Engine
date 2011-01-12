--[[
	SceneBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "EntityBuilder"

function buildScene(sceneName)

	assert(type(sceneName) == "string", "The Scene Name for buildScene must be a File Name")

	sceneTable = dofile(filePath(sceneName));

	aScene = Scene()
	entities = {}

	aScene.sceneId = sceneTable.id

	for k,v in pairs(sceneTable.entities) do
		
		-- We build the entity
		local entity = buildEntity(v.id) 
		
		-- If we assign a position to the entity {x= 20, y=30}.
		if(type(v.position) == "table") then
			entity:setPosition(v.position.x, v.position.y)
		end
		
		-- If we want to randomize the entity position within the device screen.
		if((v.random ~= nil) and (v.random == true)) then
			entity:setPosition(math.random(0,480), math.random(0,320))
		end
		
		-- entities[i]:setIsActive(true)
		aScene:addEntity(entity)	-- Add a coolDude to the scene.
	end
		
	return aScene
end