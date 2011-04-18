function UnisonActions(...)
	
	local action = UnisonAction()
	
	for _, v in ipairs(arg) do action:addChildAction(v) end
	
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
	action:setEndPoint( ggp(in_x, in_y) )
	return action
	
end

function ScaleTo (in_x, in_y, in_duration)
	
	local action = ScaleToAction()
	action:setDuration(in_duration)
	action:setEndScale( ggp(in_x, in_y) )
	return action
	
end
