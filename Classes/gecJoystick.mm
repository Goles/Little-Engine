//
//  gecJoystick.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "GEComponent.h"
#include "gecJoystick.h"
#include "gecAnimatedSprite.h"
#include "gecFSM.h"
#include "SharedInputManager.h"
#include "BehaviourActions.h"

std::string gecJoystick::mComponentID = "gecJoystick";

#pragma mark Contrstructor
gecJoystick::gecJoystick()
{
	shape.origin.x		= 0.0f;
	shape.origin.y		= 0.0f;
	shape.size.width	= 0.0f;
	shape.size.height	= 0.0f;	
	center.x			= 0.0f;
	center.y			= 0.0f;
	latestVelocity.x	= 0.0f;
	latestVelocity.y	= 0.0f;
	active				= false;
	firstTouch			= true;
	fsm					= NULL;
	subscribedGE		= NULL;
	currentTouchID		= NULL;
}

#pragma mark gec_gui_interface
void gecJoystick::update(float delta)
{
	float delta_velocity	= delta*subscribedGE->getSpeed();
	
	/*Updating the component or other components dependant of it happens here*/
	if(subscribedGE != NULL)
	{
		subscribedGE->x += floor(latestVelocity.x * delta_velocity);
		subscribedGE->y += floor(latestVelocity.y * delta_velocity);
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
	float _x = this->getOwnerGE()->x;
	float _y = this->getOwnerGE()->y;
	float cX = center.x;
	float cY = center.y;
	
	float d = sqrtf((_x - cX)*(_x - cX) -
					(_y - cY)*(_y - cY));
	
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
	this->getOwnerGE()->x = x;
	this->getOwnerGE()->y = y;
	this->setShape(CGRectMake(x, y, shape.size.width, shape.size.height));
	
	//We update the "latest" velocity ( that's what we will use as a cached reference.
	latestVelocity = velocity;
	
	//Flip our entity if we face right or left.
	
	if(dx < 0)
	{
		subscribedGE->setFlipHorizontally(true);
	}else {
		subscribedGE->setFlipHorizontally(false);
	}

}

Boolean gecJoystick::immGUI(float x, float y, int touchIndex, void *touchID, int touchType)
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
			if(INPUT_MANAGER->GUIState[i].fingerDown && INPUT_MANAGER->GUIState[i].touchID == touchID)
			{
				//Activate joystick and update our entity state.
				active = true;
				gAni->setCurrentAnimation("hot");
				this->updateSubscriberState(kBehaviourAction_dragGamepad);	
				this->updateVelocity(x, y);
			}
			//Releasing inside the Joystick bounds.
			else if(INPUT_MANAGER->GUIState[i].fingerDown == false && INPUT_MANAGER->GUIState[i].touchID == touchID)
			{
				//De-activate Joystick
				active = false;
				gAni->setCurrentAnimation("normal");
				this->updateSubscriberState(kBehaviourAction_stopGamepad);
				
				//Return to center.
				this->getOwnerGE()->x = center.x;
				this->getOwnerGE()->y = center.y;
				this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
				latestVelocity = CGPointZero;
				return true;
			}
		}
	}
	
	//If we didin't hit the Joystick bounds.
	else
	{
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			//releasing outside joystick bounds with
			if(INPUT_MANAGER->GUIState[i].fingerDown == false && INPUT_MANAGER->GUIState[i].touchID == currentTouchID)
			{
				//We de-activate our joystick and set it's "normal" animation
				//if there's a normal animation.
				active = false;
				gAni->setCurrentAnimation("normal");
				this->updateSubscriberState(kBehaviourAction_stopGamepad);
				
				//Return to the center
				this->updateVelocity(x, y);
				this->getOwnerGE()->x = center.x;
				this->getOwnerGE()->y = center.y;
				this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
				latestVelocity = CGPointZero;
				
				// We reset the joystick first touch. This means that we will 
				// touch it for the "first time" now.				
				firstTouch = true;
				currentTouchID = NULL;
			}
			//Holding outside joystick bounds
			//This is useful when we drag our finger OUTSIDE of the joystick
			//bounds, and still want the joystick to keep responding.
			 if((INPUT_MANAGER->GUIState[i].fingerDown == true) && (touchID == currentTouchID) && active)
			{
				active = true;
				gAni->setCurrentAnimation("hot");
				this->updateSubscriberState(kBehaviourAction_dragGamepad);	
				this->updateVelocity(x, y);
			}
		}
	}
	return false; //button not activated.
}

void gecJoystick::subscribeGameEntity(GameEntity *gE)
{	
	subscribedGE = gE;
	fsm = ((gecFSM *)subscribedGE->getGEC("CompBehaviour"));
	if(fsm == NULL)
	{
		std::cout << "WARNING: You shouldn't be using a gecJoystick with a GameEntity that doesn't have a gecFSM" << std::endl;
		assert(fsm != NULL);
	}
}

void gecJoystick::updateSubscriberState(kBehaviourAction a)
{
	if(fsm != NULL)
		fsm->performAction(a);
	else {
		std::cout << "WARNING: You shouldn't be using a gecJoystick with a GameEntity that doesn't have a gecFSM" << std::endl;
		assert(fsm != NULL);
	}
}

void gecJoystick::setShape(CGRect aRect)
{
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width * 0.5, 
					   aRect.origin.y - aRect.size.height * 0.5, 
					   aRect.size.width, 
					   aRect.size.height);
	
	this->setInRadius(aRect.size.width * 0.5);	//We set the joystick paddle radius
	this->setOutRadius(aRect.size.width * 0.5 + aRect.size.width*0.25);	//We set the outer circle radius ( usually 2x inner paddle )
}
