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

	aScene.label = sceneTable.id

	for _, e in pairs(sceneTable.entities) do
		
		-- We build the entity
		local entity = buildEntity(e.file) 
		
		-- If we assign a position to the entity {x= 20, y=30}.
		if e.position then
			entity:setPosition(e.position.x, e.position.y)
		end
		
		-- entities[i]:setIsActive(true)
		aScene:addEntity(entity)	-- Add a coolDude to the scene.
	end
		
	return aScene
end