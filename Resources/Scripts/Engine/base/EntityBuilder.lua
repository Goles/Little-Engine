--[[
	EntityBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "base_functions"
require "event_manager"
require "ComponentBuilder"
require "EntityMap"

-- ====================================== --
--         ENTITY BUILDER FUNCTION        --
-- ====================================== --
function buildEntity (e)	
	entityTable = dofile (filePath(e.file))
	
	assert(entityTable, "ERROR: EntityTable == nil, maybe forgot to return the GameEntity at the end of " .. e.file)
	
	-- create a new entity
	entity = GameEntity(); 
	
	-- assign the entity a unique_id.
	entity.id = entity:getId()
	
	-- add entity attributes
	if entityTable.attributes then	
		addAttributes (entityTable.attributes, entity) 
	end
		
	-- add the scene defined position to the entity
	if e.position then 
		entity:setPosition(e.position.x, e.position.y) 
	end

	-- attach the respective components to the entity	
	if entityTable.components then 
		addComponents (entityTable.components, entity) 
	end

	-- attach the respective event listening data to the entity	
	if entityTable.event_data then 
		addEventData (entityTable.event_data, entity) 
	end
	
	-- Add the component access interface to the entity
	addComponentInterface (entity)
	
	-- Add Actions interface
	addActionsInterface (entity)
	
	-- Map the entity to store a reference
	addMapEntity (entity)
	
	return entity
end

-- Adds components from a component table to a given entity.
function addComponents ( in_components , in_entity )
	
	in_entity.components = {}
	
	-- add the corresponding components to the entity in question
	for key,value in pairs(in_components)	do
		
		if component_function_table[ key ] ~= nil then
			component = component_function_table[ key ]( value )
			component.ownerGE = in_entity
			in_entity:setGEC(component)
			in_entity.components[ key ] = component					
			in_entity.active = true
		end
		
	end
	
end

-- Adds event data from a event_data table to a given entity.
function addEventData ( in_event_data, in_entity)
	assert(in_event_data, "Event Listening Entities MUST specify which events to listen for")		
	assert(in_event_data, "Event Listening Entities MUST implement a handle_event function")
	
	-- set the event listener settings for this entity
	if in_event_data ~= nil then
	
		-- set the event handling function defined in the entity.lua file		
		in_entity.handle_event = in_event_data.handle_event
		
		-- we set the entity handle_touch_event function if available.
		if(in_event_data.handle_touch_event ~= nil) then
			in_entity.handle_touch_event = in_event_data.handle_touch_event
		end
				
		-- set the entity as a listener for several events
		for i,v in ipairs(in_event_data.listen_events) do
			event:_add_listener(in_entity, v)
		end
		
	end
	
end

-- Adds atributes to the entity ( this function is subject to dissappear in the future)
function addAttributes ( in_attributes, in_entity )
	
	if( in_attributes.speed ~= nil ) then		
		in_entity.speed = in_attributes.speed		
	end
	
	if (in_attributes.label ~= nil) then	
		in_entity.label = in_attributes.label
	end
	
end

-- Adds the component interface to the entity
function addComponentInterface (in_entity)

	in_entity.component = function (this, in_component_name)

		assert(type(in_component_name) == "string", "The component Name must be type string.")

		return this.components[in_component_name]

	end

end

-- Adds the Actions interface to the entity
function addActionsInterface (in_entity)
	
	print "Actions Interface"
	
	in_entity.attachAction = function (this, in_action)
		
		in_action:startWithTarget(this)
		addAction(in_action)
		
	end
	
end