//
//  gecButton.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "gecButton.h"
#include "GEComponent.h"
#include "gecAnimatedSprite.h"
#include "SharedInputManager.h"

std::string gecButton::mComponentID = "gecButton";

#pragma mark contructor
gecButton::gecButton()
{
	//TODO: INPUT_MANAGER GIVE ME A NEW ID
	this->setGuiID(INPUT_MANAGER->giveID());

	 //We don't assign button actions by default.
	buttonActions[0] = kBehaviourAction_none;
	buttonActions[1] = kBehaviourAction_none;
}

gecButton::~gecButton()
{
	INPUT_MANAGER->removeGameEntity(this->getGuiID()); //we ask the input manager to remove us.
}

#pragma mark -
#pragma mark signal binding
void gecButton::addSignal(const TriggerSignal::slot_type& slot)
{
	triggerSignal.connect(slot);
}

void gecButton::call(kBehaviourAction action)
{
	triggerSignal(action);
}

#pragma mark -
#pragma mark gecButton_interface
Boolean gecButton::regionHit(float x, float y)
{
	if(CGRectContainsPoint(shape, CGPointMake(x, y)))
	   return true;
	
	return false;
}

Boolean gecButton::immGUI(float x, float y, int touchIndex, void *touchID, int touchType)
{
	GEComponent *gec = this->getOwnerGE()->getGEC(std::string("CompVisual")); //we obtain a gecAnimatedSprite
	gecAnimatedSprite *gAni = static_cast<gecAnimatedSprite *> (gec);
	
	if(this->regionHit(x, y))
	{
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			if(INPUT_MANAGER->GUIState[i].touchID == touchID)
			{
				if(INPUT_MANAGER->GUIState[i].fingerDown && INPUT_MANAGER->GUIState[i].hitFirst)
				{
					gAni->setCurrentAnimation("hot");
					
					// If we have some behavior to trigger && it's not touch
					// moved over button.
					if(buttonActions[0] > kBehaviourAction_none && touchType != kTouchType_moved)
						this->call(buttonActions[0]);
					
					return true;
				}
				else if(!INPUT_MANAGER->GUIState[i].fingerDown)
				{
					gAni->setCurrentAnimation("normal");		
					return false;
				}
			}
		}
	}else {
		for(int i = 0; i < MAX_TOUCHES; i++)
		{
			if(INPUT_MANAGER->GUIState[i].fingerDown == false && i != touchIndex)
			{
				gAni->setCurrentAnimation("normal");
			} 
		}
	}

	return false; //button not activated.	
}

void gecButton::setShape(CGRect aRect)
{	
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width*0.5, 
			   aRect.origin.y - aRect.size.height*0.5, 
			   aRect.size.width, 
			   aRect.size.height);
}
