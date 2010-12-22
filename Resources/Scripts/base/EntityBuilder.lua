--[[
	EntityBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "base_functions"
require "event_manager"
require "ComponentBuilder"
require "tableprint"

function buildEntity(fileName)
	entityTable = dofile(filePath(fileName))
	entity = GameEntity()
	entity.components = {}
		
	-- add the components to the entity in question
	for key,value in pairs(entityTable.components)	do
		
		if component_function_table[ key ] ~= nil then
			component = component_function_table[ key ]( value )
			entity:setGEC(component)
			entity.components[key] = component
			entity.id = entity:getId()			
			entity:setIsActive(true)
		end
		
	end
	
	-- set the event listener settings for this entity
	if entityTable.event_data ~= nil then
		assert(entityTable.event_data.listen_events, "Event Listening Entities MUST specify which events to listen for")		
		assert(entityTable.event_data.handle_event, "Event Listening Entities MUST implement a handle_event function")		
		
		-- set the event handling function defined in the entity.lua file
		entity.handle_event = entityTable.event_data.handle_event
		
		-- we set the entity handle_touch_event function if available.
		if(entityTable.event_data.handle_touch_event ~= nil) then
			entity.handle_touch_event = entityTable.event_data.handle_touch_event
		end
				
		-- set the entity as a listener for several events
		for i,v in ipairs(entityTable.event_data.listen_events) do
			event:_add_listener(entity, v)
		end
		
	end
	
	return entity
end