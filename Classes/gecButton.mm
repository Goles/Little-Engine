//
//  gecButton.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecButton.h"
#import "GEComponent.h"
#import "gecAnimatedSprite.h"
#import "SharedInputManager.h"

std::string gecButton::mComponentID = "gecButton";

#pragma mark contructor
gecButton::gecButton()
{
	//TODO: INPUT_MANAGER GIVE ME A NEW ID
	
	guiID = INPUT_MANAGER->giveID();
}

gecButton::~gecButton()
{
	INPUT_MANAGER->removeGameEntity(this->getGuiID()); //we ask the input manager to remove us.
}

#pragma mark gecButton_interface
Boolean gecButton::regionHit(float x, float y)
{
	if(CGRectContainsPoint(shape, CGPointMake(x, y)))
	   return true;
	
	return false;
}

Boolean gecButton::immGUI(float x, float y, int guiID)
{
	GEComponent *gec = this->getOwnerGE()->getGEC(std::string("CompVisual")); //we obtain a gecAnimatedSprite
	gecAnimatedSprite *gAni = static_cast<gecAnimatedSprite *> (gec);
	
	if(this->regionHit(x, y))
	{
		INPUT_MANAGER->GUIState.hotItem = guiID;
		if(INPUT_MANAGER->GUIState.fingerDown == true)
		{
			gAni->setCurrentAnimation("hot");
		}
		else if(INPUT_MANAGER->GUIState.fingerDown == false && INPUT_MANAGER->GUIState.hotItem == guiID) //they are releasing over me
		{
			//INPUT_MANAGER->GUIState.activeItem = guiID;
			gAni->setCurrentAnimation("normal");
			/*Trigger the activation methods of this particular button.*/
			std::cout << "Active!!!!!!" << std::endl;
			return true;
		}
	}
	else {
		gAni->setCurrentAnimation("normal");
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
