//
//  gecJoystick.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "gecJoystick.h"
#include "GEComponent.h"
#include "GameEntity.h"
#include "TouchableManager.h"
#include "EventBroadcaster.h"
#include "gecAnimatedSprite.h"
#include "EventScheduler.h"

std::string gecJoystick::mComponentID = "gecJoystick";

#pragma mark Contrstructor
gecJoystick::gecJoystick(gg::event::IEventBroadcaster *scheduler)
    :	inRadius(0.0f)
    ,   outRadius(0.0f)
    ,   active(false)
    ,   firstTouch(true)
    ,   dx_negative(false)
    ,   currentTouchID(0)
    ,   m_broadcaster(scheduler)
{
	shape = CGRectZero;
	center = CGPointZero;
	latestVelocity = CGPointZero;
	this->registerTouchable(this);
}

#pragma mark gec_gui_interface
void gecJoystick::update(float delta)
{	
	if(latestVelocity.x != 0.0 || latestVelocity.y != 0.0f)
	{			
		luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
		payload["latest_speed"] = latestVelocity;
		payload["delta"] = delta;
		payload["dx_negative"] = dx_negative;
        m_broadcaster->broadcast("E_DRAG_GAMEPAD", payload);
	}
}

#pragma mark gec_joystick_interface
Boolean gecJoystick::regionHit(float x, float y)
{
	if(CGRectContainsPoint(shape, CGPointMake(x, y)))
		return true;
	
	return false;
}

Boolean	gecJoystick::outerRegionHit()
{
	float _x = this->getOwnerGE()->getPositionX();
	float _y = this->getOwnerGE()->getPositionY();
	float cX = center.x;
	float cY = center.y;
	
	float d = sqrtf((_x - cX) * (_x - cX) - (_y - cY) * (_y - cY));
	
	if(d == (outRadius - inRadius))
		return true;

	return false;
}

void gecJoystick::updateVelocity(float x, float y)
{
	// Calculate distance and angle from the center.
	float dx = x - center.x;
	float dy = y - center.y;
	CGPoint velocity;
	
	float distance = sqrtf(dx * dx + dy * dy);
	float angle = atan2f(dy, dx); // in radians
	
	// NOTE: Velocity goes from -1.0 to 1.0.
	// BE CAREFUL: don't just cap each direction at 1.0 since that
	// doesn't preserve the proportions.
	if (distance > inRadius) {
		dx = cosf(angle) * inRadius;
		dy = sinf(angle) * inRadius;
	}
	
	velocity = CGPointMake(dx/inRadius, dy/inRadius);
	
	// Constrain the thumb so that it stays within the joystick
	// boundaries.  This is smaller than the joystick radius in
	// order to account for the size of the thumb.
	if (distance > outRadius) {
		x = center.x + cosf(angle) * outRadius;
		y = center.y + sinf(angle) * outRadius;
	}
	
	// Update the thumb's position
	this->getOwnerGE()->setPositionX(x);
	this->getOwnerGE()->setPositionY(y);
	this->setShape(CGRectMake(x, y, shape.size.width, shape.size.height));
	
	//We update the "latest" velocity ( that's what we will use as a cached reference.
	latestVelocity = velocity;
	
	//Used as an event argument to flip our entity if we face right or left.
	if(dx < 0)
		dx_negative = true;
	else {
		dx_negative = false;
	}
}

Boolean gecJoystick::handle_touch(float x, float y, int touchIndex, int touchID, int touchType)
{
	//we obtain a gecAnimatedSprite for the Joystick
	GEComponent *gec = this->getOwnerGE()->getGEC(std::string("CompVisual"));
	gecAnimatedSprite *gAni = static_cast<gecAnimatedSprite *> (gec);
	
	//If we are touching inside the Joystick bounds.
	if(this->regionHit(x, y))
	{	
		//If this is the first time that we hit the joystick, we save the touch.
		if(firstTouch)
		{
			currentTouchID = touchID;
			firstTouch = false;
		}
		
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			//Holding inside the joystick bounds
			if(TOUCHABLE_MANAGER->GUIState[i].fingerDown && TOUCHABLE_MANAGER->GUIState[i].touchID == touchID)
			{
				//Activate joystick and update our entity state.
				active = true;
				gAni->setCurrentAnimation("hot");
				this->updateVelocity(x, y);
			}
			//Releasing inside the Joystick bounds.
			else if(TOUCHABLE_MANAGER->GUIState[i].fingerDown == false && TOUCHABLE_MANAGER->GUIState[i].touchID == touchID)
			{
				//De-activate Joystick
				active = false;
				gAni->setCurrentAnimation("normal");

				luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
				m_broadcaster->broadcast("E_STOP_GAMEPAD", payload);
				
				//Return to center.
				this->getOwnerGE()->setPositionX(center.x);
				this->getOwnerGE()->setPositionY(center.y);
				this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
				latestVelocity = CGPointZero;
				
				// We reset the joystick first touch. This means that we will 
				// touch it for the "first time" now.				
				firstTouch = true;
				currentTouchID = NULL;
				
				return true;
			}
		}
	}
	
	//If we didin't hit the Joystick bounds.
	else if (active)
	{
		for(int i = 0; i < MAX_TOUCHES; i++)
		{

			/*  DEBUG COUT
				std::cout << "********" << std::endl;
				std::cout << "Finger " << i << " down : " << TOUCHABLE_MANAGER->GUIState[i].fingerDown << std::endl;
				std::cout << "Finger " << i << " touchID: " << TOUCHABLE_MANAGER->GUIState[i].touchID << std::endl;
				std::cout << "Current TouchID: " << currentTouchID << std::endl;
			 */
			
			//releasing outside joystick bounds with
			if(TOUCHABLE_MANAGER->GUIState[i].fingerDown == false && TOUCHABLE_MANAGER->GUIState[i].touchID == currentTouchID)
			{
				//We de-activate our joystick and set it's "normal" animation
				//if there's a normal animation.
				active = false;
				gAni->setCurrentAnimation("normal");

				luabind::object payload = luabind::newtable(LR_MANAGER_STATE);	
				m_broadcaster->broadcast("E_STOP_GAMEPAD", payload);				
				
				//Return to the center
				this->updateVelocity(x, y);
				this->getOwnerGE()->setPositionX(center.x);
				this->getOwnerGE()->setPositionY(center.y);
				this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
				latestVelocity = CGPointZero;
				
				// We reset the joystick first touch. This means that we will 
				// touch it for the "first time" now.				
				firstTouch = true;
				currentTouchID = NULL;
				
				//Added so we don't broadcast the stop gamepad twice
				return true;
			}
			//Holding outside joystick bounds
			//This is useful when we drag our finger OUTSIDE of the joystick
			//bounds, and still want the joystick to keep responding.
			 if((TOUCHABLE_MANAGER->GUIState[i].fingerDown == true) && (touchID == currentTouchID))
			{
				active = true;
				gAni->setCurrentAnimation("hot");	
				this->updateVelocity(x, y);
			}
		}
	}
	return false; //button not activated.
}

void gecJoystick::setShape(CGRect aRect)
{
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width * 0.5, 
					   aRect.origin.y - aRect.size.height * 0.5, 
					   aRect.size.width, 
					   aRect.size.height);
	
	this->setInRadius(aRect.size.width * 0.5);	//We set the joystick paddle radius
	this->setOutRadius(aRect.size.width * 0.5 + aRect.size.width * 0.25);	//We set the outer circle radius ( usually 2x inner paddle )
}
