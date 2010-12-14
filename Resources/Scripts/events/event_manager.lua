--[[
	event_manager.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

event = {
    listeners = {},
}

function event:_add_listener( in_object, in_event )
	--print( "event:add_listener" )
	--print( in_event )

    local _objects = self.listeners[ in_event ]
    
    -- MAKE A NEW LIST OF OBJECTS    
    if not _objects then
        _objects = {}
        -- ADD OBJECT LIST TO LINSTENERS
        self.listeners[ in_event ] = _objects
    end
    
    -- ADD LISTENER TO LIST OF OBJECTS
    --_objects[ #_objects + 1 ] = in_object 
    _objects[ in_object ] = in_object

end

function event:_remove_listener( in_object )
	self:remove_events_for_object( in_object )
end

function event:_remove_events_for_object( in_object )
    --print( "event:remove_events_for_object" )

    -- SEARCH ALL THE EVENTS
    for objects_key, objects_value in pairs( self.listeners ) do
        
        -- LOOK FOR EVENT OBJECT LIST TO FIND OBJECT
        for object_key, object_value in pairs( objects_value ) do
        
            if object_key == in_object then
                
                -- REMOVE EVENT            
                --table.remove( self.events, key )
                objects_value[ object_key ] = nil
            end
        
        end
        
    end

end

function event:_broadcast( in_event, in_data )
	--print( "event:broadcast" )
	--print( in_event )

    -- FIND LISTENERS
    local _objects = self.listeners[ in_event ]

    if _objects then
        -- INFORM LISTNERS
        for key, value in pairs( _objects ) do
            key:event( in_event, in_data )
        end
    --else
    --	print( "EVENT NOT FOUND" )
    end
end

-- Public Functions to expose to C++ ... should be removed when I learn how to properly call event:XXXX(t) from C++
function broadcast(in_event, in_data)
--	print(in_event)
	event:_broadcast(in_event, in_data)
end
