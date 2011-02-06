--[[
	zero.lua
	Copyright 2011 Nicolas Goles. All Rights Reserved. 
]]--

Zero =
{
	components = 
	{
		gecAnimatedSprite =
		{
			spritesheets = 
			{
				{"sprite_test.png", 98, 140, 0.0, 1.0}
			},

			animations =
			{
				-- Animation name, Animation spritesheet coords, Animation frame duration.
				-- {id=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"S_STAND", {0,0,1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0}, 0.05, "sprite_test.png", true, true},				
			},
		},
		
		gecFSM =
		{
			rules =
			{
				-- current state, input action, resulting state.
				{"S_STAND", "A_ATTACK", "S_ATTACK"},
				{"S_STAND", "A_DRAG_GAMEPAD", "S_WALK"},
				{"S_STAND", "A_HIT", "S_HIT"},
				{"S_WALK", "A_DRAG_GAMEPAD", "S_WALK"},
				{"S_WALK", "A_STOP_GAMEPAD", "S_STAND"},
				{"S_WALK", "A_ATTACK", "S_ATTACK"},
				{"S_WALK", "A_HIT", "S_HIT"},
				{"S_ATTACK", "A_STOP_ATTACK","S_STAND"},			
				{"S_ATTACK", "A_ATTACK", "S_ATTACK"},			
				{"S_ATTACK", "A_DRAG_GAMEPAD", "S_ATTACK"},				
				{"S_ATTACK", "A_STOP_GAMEPAD", "S_ATTACK"},				
				{"S_ATTACK", "A_HIT","S_HIT"},
				{"S_HIT", "A_STOP_HIT", "S_STAND"},																	
			},
		},

	},
	
	event_data =
	{
		listen_events = 
		{
			"E_SCENE_ACTIVE",
			"E_DRAG_GAMEPAD",
		},
		
		handle_event =  function(this, in_event, in_data)
		
			if (in_event == "E_SCENE_ACTIVE") then
				
				local c = this.components["gecAnimatedSprite"]
				c:setCurrentAnimation("S_STAND")
				c:setCurrentRunning(true)
				c:setCurrentRepeating(true)
	
			elseif in_event == "E_DRAG_GAMEPAD" then
				
				this.flipHorizontally = in_data.dx_negative			
				local delta_speed = in_data.delta * this.speed
				local movement_x = delta_speed * in_data.latest_speed.x
				local movement_y = delta_speed * in_data.latest_speed.y
				
				this.x = this.x + round(movement_x) 
				this.y = this.y + round(movement_y)

			end
		end
	},	
	
	attributes =
	{
		speed = 60
	},

}

return Zero