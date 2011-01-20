--[[
	test.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

TestEntity = 
{	
	register_events =
	{
		event_handler = "zombie_event_handler.lua",
		events = 
		{
			"E_HIT",
		},
	},	
	components = 
	{
		gecAnimatedSprite =
		{
			spritesheets = 
			{
				{"hitter1_1.png", 80, 80, 0.0, 1.0}
			},
			animations =
			{
				-- Animation name, Animation spritesheet coords, Animation frame duration.
				-- {id=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"stand", {0,0,1,0,2,0,3,0}, 0.10, "hitter1_1.png", true, true},				
				{"walk", {4,0,5,0,6,0,7,0}, 0.10, "hitter1_1.png", true, false},
				{"attack",{8,0,9,0,10,0}, 0.08, "hitter1_1.png", false, false},
			},
		},
	},
}