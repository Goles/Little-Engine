Weapon1 =
{
	event_data =
	{
		listen_events =
		{
			"E_CHARACTER_ATTACK",
			"E_CHARACTER_ATTACK_STOP",
		},
		
		handle_event = function (this, in_event, in_data)
								
			--
			--	EVENT CHARACTER ATTACK
			--						
			if in_event == "E_CHARACTER_ATTACK" then
				this.active = true
				this.x = in_data.x + 40
				this.y = in_data.y

			--
			--	EVENT CHARACTER ATTACK STOP
			--
			elseif in_event == "E_CHARACTER_ATTACK_STOP" then
				this.active = false
			
			end
			
		end
	},
		
	components = 
	{
		gecBoxCollisionable =
		{
			size = {width=30, height=30}
		}
	},
}

return Weapon1