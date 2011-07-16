AnImage =
{
	event_data =
	{
		listen_events = 
		{
			"E_SCENE_ACTIVE"
		},

		handle_event = function (this, in_event, in_data)
			
			--	EVENT SCENE ACTIVE
			if (in_event == "E_SCENE_ACTIVE") then
				this:attachAction(MoveBy(32, 0, 2.0))
			end
			
		end
	},
	
	components = 
	{
		gecImage = {file="gando_box.png"}
	},
}

return AnImage