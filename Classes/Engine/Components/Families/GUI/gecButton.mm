//
//  gecButton.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "gecButton.h"
#include "TouchableManager.h"
#include "GameEntity.h"
#include "GEComponent.h"
#include "gecAnimatedSprite.h"
#include "EventBroadcaster.h"

std::string gecButton::mComponentID = "gecButton";

#pragma mark contructor
gecButton::gecButton(gg::event::IEventBroadcaster *broadcaster)
    : m_broadcaster(broadcaster)
{	
	this->registerTouchable(this);
}

#pragma mark -
#pragma mark gecButton_interface
Boolean gecButton::regionHit(float x, float y)
{
	if(CGRectContainsPoint(shape, CGPointMake(x, y)))
	   return true;
	
	return false;
}

Boolean gecButton::handle_touch(float x, float y, int touchIndex, int touchID, int touchType)
{
	GEComponent *gec = this->getOwnerGE()->getGEC(std::string("CompVisual")); //we obtain a gecAnimatedSprite
	gecAnimatedSprite *gAni = static_cast<gecAnimatedSprite *> (gec);
	
	if(this->regionHit(x, y))
	{
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			if(TOUCHABLE_MANAGER->GUIState[i].touchID == touchID)
			{
				//First hit inside the button
				if(TOUCHABLE_MANAGER->GUIState[i].fingerDown && TOUCHABLE_MANAGER->GUIState[i].hitFirst)
				{
					gAni->setCurrentAnimation("hot");					
					this->broadcastButtonPress();					
					return true;
				}
				
				//Release finger inside the button
				else if(!TOUCHABLE_MANAGER->GUIState[i].fingerDown)
				{
					gAni->setCurrentAnimation("normal");
					this->broadcastButtonRelease();
					return false;
				}
			}
		}
	}else {
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			if(!TOUCHABLE_MANAGER->GUIState[i].fingerDown)
			{
				gAni->setCurrentAnimation("normal");				
				return false;
			} 
		}
	}

	return false; //button not activated.	
}

void gecButton::setShape(CGRect aRect)
{	
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width * 0.5, 
					   aRect.origin.y - aRect.size.height * 0.5, 
					   aRect.size.width, 
					   aRect.size.height);
}

void gecButton::setParentSharedShape(CGRect aRect)
{
	//Set our shape and then set that same shape with our parent.
	//This could eventually be different, let's say you want to build a menu.
	//The menu could contain several buttons, but his shape could be different,
	//this allows flexibility.
	this->setShape(aRect);
	this->getOwnerGE()->height = aRect.size.height;
	this->getOwnerGE()->width  = aRect.size.width;
}

void gecButton::broadcastButtonPress()
{
    //TODO: Fix this
//	luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
//	payload["label"] = this->getOwnerGE()->getLabel();
//    m_broadcaster->broadcast("E_BUTTON_PRESS", payload);
}

void gecButton::broadcastButtonRelease()
{
    //TODO: Fix this
//	luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
//	payload["label"] = this->getOwnerGE()->getLabel();
//    m_broadcaster->broadcast("E_BUTTON_RELEASE", payload);
}