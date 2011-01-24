AttackButton = 
{		
	event_data =
	{
		listen_events = 
		{
			-- Since E_TOUCH is defined we must specify a "handle_touch_event function"
			"E_TOUCH"
		},
		
		handle_touch_event =
		function(this, in_x, in_y, in_touchIndex, in_touchId, in_touchType)
			-- Handle touch events here.
			this.components["gecButton"]:handle_touch(in_x, in_y, in_touchIndex, in_touchId, in_touchType)
		end		
	},
	
	components = 
	{
		gecAnimatedSprite = 
		{
			spritesheets =
			{
				{"button_attack.png", 42, 42, 0.0, 1.0},
			},
			
			animations = 
			{
				{"normal", {0,0}, 0.1, "button_attack.png", false, false},				
				{"hot", {1,0}, 0.1, "button_attack.png", false, false},				
			},
		},
		
		gecButton = 
		{
			shape = {x = 430, y = 60, width = 42, height = 42},
		},
	},
	
	attributes = 
	{
		label = "BUTTON_ATTACK",
	},
}

return AttackButton