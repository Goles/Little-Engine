--[[
	entity.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

-- Never use the reserved keyword "GameEntity"
TestEntity = 
{
	event_data =
	{
		listen_events = 
		{
			-- Events to listen
		},
		
		handle_event = 
		function(this, in_event, in_data)
			-- Handle events there.
		end
	},
	
	components = 
	{
		gecJoystick =
		{
			shape = {width = 42, height = 42}
		},
		
		gecAnimatedSprite =
		{
			spritesheets = 
			{
				{"joypad_move.png", 42, 42, 0.0, 1.0}
			},
			animations =
			{
				-- Animation name, Animation spritesheet coords, Animation frame duration.
				-- {id=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"normal", {0,0}, 0.1, "joypad_move.png", false, false},				
				{"hot", {0,0}, 0.1, "joypad_move.png", true, false},
				{"active",{0,0}, 0.1, "joypad_move.png", false, false},
			},
		},
	},
}

return TestEntity