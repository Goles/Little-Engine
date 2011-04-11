function UnisonActions(...)
	
	local action = UnisonAction()
	
	for _, v in ipairs(arg) do action:addAction(v) end
	
	return action

end

function FadeIn (in_duration)
	
	local action = FadeInAction();
	action:setDuration(in_duration)
	return action
	
end

function FadeOut (in_duration)
	
	local action = FadeOutAction();
	action:setDuration(in_duration);
	return action

end

function MoveTo (in_x, in_y, in_duration)
	
	local action = MoveToAction()
	action:setDuration(in_duration)
	action:setEndPoint(ggp(240.0, 180.0))
	return action
	
end
