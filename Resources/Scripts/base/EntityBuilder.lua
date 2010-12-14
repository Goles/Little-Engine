--[[
	EntityBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "base_functions"
require "event_manager"
require "ComponentBuilder"

function buildEntity(fileName)
	entityTable = dofile(filePath(fileName))
	entity = GameEntity()
	
	-- add the components to the entity in question
	for key,value in pairs(entityTable.components)	do
		
		if component_function_table[ key ] ~= nil then
			component = component_function_table[ key ]( value )
			component:setOwnerGE(entity)
			entity:setGEC(component)
			entity:setIsActive(true)
		end
		
	end
	
	for key, value in pairs(entityTable.register_events) do
		event:_add_listener(entity, value)
	end
		
		
	end
	
	return entity
end