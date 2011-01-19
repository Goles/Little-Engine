--[[
	gecFSM_interface.lua
	Copyright 2011 Nicolas Goles. All Rights Reserved. 
]]--

require "EntityMap"
require "even_manager"

function setState( in_state )
	
end

function getState(in_entity_uid)
	
end

function performAction(in_action, in_entity_uid)
	
	print("UID " .. in_entity_uid .. " ACTION " .. in_action)
	
	local entity = entity_manager:_fetchMapEntity( in_entity_uid )
	
	assert(entity == nil, "An nil entity can't perform actions ( Lua: performAction )")
	
	local oldState = entity.fsm.currentState
	local newState = entity.fsm.states_matrix[oldState][in_action]

	-- set the current state to the corresponding resulting entity state.	
	if( oldState ~= newState ) then
		entity.fsm.currentState = newState
		
		-- broadcast an event letting an entity know that it's state changed
		entity.handleEvent("E_STATE_CHANGE", newState)
		
	end
		
end