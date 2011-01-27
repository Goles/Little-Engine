--[[
	SceneBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "EntityBuilder"

function buildScene(sceneName)

	assert(type(sceneName) == "string", "The Scene Name for buildScene must be a File Name")

	sceneTable = dofile(filePath(sceneName));

	aScene = Scene()
	aScene.label = sceneTable.label

	for _, e in pairs(sceneTable.entities) do
		aScene:addEntity( buildEntity(e) )
	end
		
	return aScene
end