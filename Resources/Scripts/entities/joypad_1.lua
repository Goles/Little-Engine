--[[
	entity.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

-- Never use the reserved keyword "GameEntity"
Joypad = 
{
	event_data =
	{
		listen_events = 
		{
			-- Since E_TOUCH is defined we must specify a "handle_touch_event function"
			"E_TOUCH"
		},
		
		handle_event = 
		function(this, in_event, in_data)
			-- Handle events there.
		end,
		
		handle_touch_event =
		function(this, in_x, in_y, in_touchIndex, in_touchId, in_touchType)
			-- Handle touch events here.
			this.components["gecJoystick"]:handle_touch(in_x, in_y, in_touchIndex, in_touchId, in_touchType)
		end		
	},	
	components = 
	{
		gecJoystick =
		{
			shape = {x = 60, y = 60, width = 42, height = 42},
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

return Joypad