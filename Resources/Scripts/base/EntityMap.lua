--[[
	EntityMap.lua
	Copyright 2011 Nicolas Goles. All Rights Reserved. 
]]--

-- The game_entities table will contain references to all created game entities, this references will be based on the unique id's
-- of the aforementioned entities, e.g game_entities[ 3 ] , will refer to the Game Entity with uid == 3, if that entity
-- has been destroyed, game_entities[ 3 ] == nil

entity_manager = {
	map = {}
}
	
function entity_manager:addEntity( in_entity )
	self.map[ in_entity.id ] = in_entity
end

function entity_manager:fetchEntity( in_uid )
	return self.map[ in_uid ]
end

function entity_manager:deleteEntity( in_uid )
	self.map[ in_uid ] = nil
end