AnImage =
{
	event_data =
	{
		listen_events = 
		{
			"E_SCENE_ACTIVE"
		},

		handle_event = function (this, in_event, in_data)
			
			--
			--	EVENT ACTIVE SCENE
			--
			if (in_event == "E_SCENE_ACTIVE") then
				this:attachAction(MoveBy(240, 160, 4.0))
			end
			
		end
	},
	
	components = 
	{
		gecImage = {file="gando_box.png"}
	},
}

return AnImage