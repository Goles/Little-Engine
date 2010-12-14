--[[
	tableprint.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

function tableprint( in_object, in_indent )
    
    -- HANDLE CONSOLE INDENTATION FOR READABILITY
    
    local in_indent = in_indent or 0
   
    local _indentation = "  "
    
    if in_indent then
        for x = 1, in_indent do
            _indentation = _indentation .. "  "
        end
    end
    
    print( _indentation .. "*** START print_object ***" )
    
     -- PRINT OUT OUR PROTOTYPE? IF WE HAVE ONE
    local _metatable = getmetatable( in_object )
    
    if _metatable then
        print( _indentation .. "*** START print metatable ***" )
        print_object( _metatable, in_indent + 1 )
        print( _indentation .. "*** END print metatable ***" )
    end
    
    -- GETS ALL THE KEY VALUE PARS IN THE OBJECT 
    for key, value in pairs( in_object ) do
     
        print( _indentation .. tostring( key ) .. " = " .. tostring( value ) )
           
        if  key ~= "__index" and type( value ) == "table" then
            -- FOUND A TABLE RECURSE TO PRINT ITS VALUES
            print_object( value, in_indent + 1 )
        end
    
    end
    
    print( _indentation .. "*** END print_object ***" )
    
end