function UnisonActions(...)
	
	local action = UnisonAction()
	
	for _, v in ipairs(arg) do action:addChildAction(v) end
	
	return action

end

function FadeIn (in_duration, in_repeatTimes)
	
	local action = FadeInAction();
	action:setDuration(in_duration)
	if in_repeatTimes then action:setRepeatTimes(in_repeatTimes) end
	return action
	
end

function FadeOut (in_duration, in_repeatTimes)
	
	local action = FadeOutAction();
	action:setDuration(in_duration);
	if in_repeatTimes then action:setRepeatTimes(in_repeatTimes) end
	return action

end

function MoveBy (in_x, in_y, in_duration, in_repeatTimes)
	
	local action = MoveByAction()
	action:setDuration(in_duration)
	action:setMovementOffset( ggp(in_x, in_y) )
	if in_repeatTimes then action:setRepeatTimes(in_repeatTimes) end
	return action

end

function MoveTo (in_x, in_y, in_duration, in_repeatTimes)
	
	local action = MoveToAction()
	action:setDuration(in_duration)
	action:setEndPoint( ggp(in_x, in_y) )
	if in_repeatTimes then action:setRepeatTimes(in_repeatTimes) end	
	return action
	
end

function ScaleTo (in_x, in_y, in_duration, in_repeatTimes)
	
	local action = ScaleToAction()
	action:setDuration(in_duration)
	action:setEndScale( ggp(in_x, in_y) )
	if in_repeatTimes then action:setRepeatTimes(in_repeatTimes) end
	return action
	
end
