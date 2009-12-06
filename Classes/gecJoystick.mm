//
//  gecJoystick.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecJoystick.h"
#import "GEComponent.h"
#import "gecAnimatedSprite.h"
#import "SharedInputManager.h"

std::string gecJoystick::mComponentID = "gecJoystick";

Boolean gecJoystick::regionHit(float x, float y)
{
	if(CGRectContainsPoint(shape, CGPointMake(x, y)))
		return true;
	
	return false;
}

Boolean gecJoystick::immGUI(float x, float y, int guiID)
{
	GEComponent *gec = this->getOwnerGE()->getGEC(std::string("CompVisual")); //we obtain a gecAnimatedSprite
	gecAnimatedSprite *gAni = static_cast<gecAnimatedSprite *> (gec);
	
	if(this->regionHit(x, y))
	{
		INPUT_MANAGER->GUIState.hotItem = guiID;
		if(INPUT_MANAGER->GUIState.fingerDown == true)
		{
			gAni->setCurrentAnimation("hot");
			std::cout << "Active!!!!!!" << std::endl;
			this->getOwnerGE()->x = x;
			this->getOwnerGE()->y = y;
			this->setShape(CGRectMake(x, y, shape.size.width, shape.size.height));
		}
		else if(INPUT_MANAGER->GUIState.fingerDown == false && INPUT_MANAGER->GUIState.hotItem == guiID) //they are releasing over me
		{
			//INPUT_MANAGER->GUIState.activeItem = guiID;
			gAni->setCurrentAnimation("normal");
			/*Return to center*/
			this->getOwnerGE()->x = center.x;
			this->getOwnerGE()->y = center.y;
			this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
			
			
			/*Trigger the activation methods of this particular button.*/
			
			return true;
		}
	}
	else {
		this->getOwnerGE()->x = center.x;
		this->getOwnerGE()->y = center.y;
		this->setShape(CGRectMake(center.x, center.y, shape.size.width, shape.size.height));
		gAni->setCurrentAnimation("normal");
	}
	
	return false; //button not activated.
}

void gecJoystick::setShape(CGRect aRect)
{
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width*0.5, 
					   aRect.origin.y - aRect.size.height*0.5, 
					   aRect.size.width, 
					   aRect.size.height);
}

void gecJoystick::setOuterShape(CGRect aRect)
{
	//We need to center our CGRect
	shape = CGRectMake(aRect.origin.x - aRect.size.width*0.5, 
					   aRect.origin.y - aRect.size.height*0.5, 
					   aRect.size.width, 
					   aRect.size.height);
}