--[[
	SceneBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "EntityBuilder"

function buildScene(sceneName, root_scene)
	
	assert(type(sceneName) == "string", "The Scene Name for buildScene must be a File Name")
    
	if root_scene ~= nil then 
		assert(root_scene.label ~= nil, "Every Scene must have a label")
	else
		root_scene = Scene() 
	end
	
	sceneTable = dofile(filePath(sceneName));
	root_scene.label = sceneTable.label

	if sceneTable.children then
		return buildSceneGraph(sceneTable, root_scene)		
	else
		return buildSceneTable(sceneTable, root_scene)
	end
	
end

function buildSceneTable(t, root_scene)

	for _, e in pairs(t.entities) do		
		root_scene:addEntity( buildEntity(e) )
	end
	
	return root_scene
end

function buildSceneGraph(t, root_scene)

	for _, v in pairs(t.children) do
		local child = buildScene(v.scene_name, parent_scene)
		child.z_order = v.z_order
		root_scene:addChild(child)
	end

	return root_scene

end