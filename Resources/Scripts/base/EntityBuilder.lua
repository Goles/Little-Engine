--[[
	EntityBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "base_functions"
require "event_manager"
require "ComponentBuilder"
require "EntityMap"

function buildEntity(fileName)
	entityTable = dofile(filePath(fileName))
	
	-- create a new entity
	entity = GameEntity()
	entity.components = {}
	
	-- assign the entity a unique_id.
	entity.id = entity:getId()
	
	-- add attributes
	if (entityTable.attributes ~= nil) then
		
		addAttributes(entityTable.attributes, entity)		
		
	end

	-- attach the respective components to the entity	
	if (entityTable.components ~= nil) then
		
		addComponents(entityTable.components, entity)
		
	end

	-- attach the respective event listening data to the entity	
	if (entityTable.event_data ~= nil) then
		
		addEventData(entityTable.event_data, entity)
		
	end
	
	-- Map the entity to store a reference
	entity_manager:_addMapEntity(entity)

	return entity
end

-- Adds components from a component table to a given entity.
function addComponents( in_components , in_entity )
	
	-- add the corresponding components to the entity in question
	for key,value in pairs(in_components)	do
		
		if component_function_table[ key ] ~= nil then
			component = component_function_table[ key ]( value )
			entity:setGEC(component)
			entity.components[key] = component					
			entity:setIsActive(true)
		end
		
	end
	
end

-- Adds event data from a event_data table to a given entity.
function addEventData( in_event_data, in_entity)
	assert(in_event_data, "Event Listening Entities MUST specify which events to listen for")		
	assert(in_event_data, "Event Listening Entities MUST implement a handle_event function")
	
	-- set the event listener settings for this entity
	if in_event_data ~= nil then
	
		-- set the event handling function defined in the entity.lua file
		entity.handle_event = in_event_data.handle_event
		
		-- we set the entity handle_touch_event function if available.
		if(in_event_data.handle_touch_event ~= nil) then
			entity.handle_touch_event = in_event_data.handle_touch_event
		end
				
		-- set the entity as a listener for several events
		for i,v in ipairs(in_event_data.listen_events) do
			event:_add_listener(entity, v)
		end
		
	end
	
end

-- Adds atributes to the entity ( this function is subject to dissappear in the future)
function addAttributes( in_attributes, in_entity )
	
	if( in_attributes.speed ~= nil ) then
		
		in_entity.speed = in_attributes.speed
		
	end
	
end