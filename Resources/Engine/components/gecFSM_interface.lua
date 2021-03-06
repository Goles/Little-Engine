--[[
	gecFSM_interface.lua
	Copyright 2011 Nicolas Goles. All Rights Reserved. 
]]--

require "EntityMap"
require "even_manager"

function setState( in_state )
	
end

function getState(in_target_entity_uid)
	
end

-- Tells an entity FSM, which is fetched in the entityMap using the UID, to perform certain action.
function targetPerformAction(in_action, in_target_entity_uid)
	print("UID " .. in_target_entity_uid .. " ACTION " .. in_action)
	
	local entity = entity_manager:_fetchMapEntity( in_target_entity_uid )
	
	assert(entity, "An nil entity can't perform actions ( Lua: performAction )")
	
	local oldState = entity.fsm.currentState
	local newState = entity.fsm.states_matrix[oldState][in_action]
	
	if newState then

		-- set the current state to the corresponding resulting entity state.
		if( oldState ~= newState ) then
			entity.fsm.currentState = newState
		
			-- broadcast an event letting an entity know that it's state changed
			entity:handleEvent("E_STATE_CHANGE", newState)
		
		end
	
	end
		
end