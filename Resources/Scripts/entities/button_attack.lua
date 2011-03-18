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
				{"hitbutton.png", 64, 64, 0.0, 1.0},
			},
			
			animations = 
			{
				{"normal", {0,0}, 0.1, "hitbutton.png", false, false},				
				{"hot", {0,0}, 0.1, "hitbutton.png", false, false},				
			},
		},
		
		gecButton = 
		{
			shape = {x = 430, y = 60, width = 64, height = 64},
		},
	},
	
	attributes = 
	{
		label = "BUTTON_ATTACK",
	},
}

return AttackButton