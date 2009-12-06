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

/*Boolean gecJoystick::regionHit(float x, float y) 
{	
	float dx = (x - center.x);
	float dy = (y - center.y);
	return (outRadius >= sqrt( (dx * dx) + (dy * dy) ));
}*/

Boolean	gecJoystick::outerRegionHit()
{
	float _x = this->getOwnerGE()->x;
	float _y = this->getOwnerGE()->y;
	float cX = center.x;
	float cY = center.y;
	
	float d = sqrtf((_x - cX)*(_x - cX) -
					(_y - cY)*(_y - cY));
	
	std::cout << d << std::endl;	
	if(d == (outRadius - inRadius))
	{
		std::cout << "YES!! " << std::endl;
		return true;
	}

	return false;
}

void gecJoystick::updateVelocity(float x, float y)
{
	// Calculate distance and angle from the center.
	float dx = x - center.x;
	float dy = y - center.y;
	CGPoint velocity;
	
	float distance = sqrt(dx * dx + dy * dy);
	float angle = atan2(dy, dx); // in radians
	
	// NOTE: Velocity goes from -1.0 to 1.0.
	// BE CAREFUL: don't just cap each direction at 1.0 since that
	// doesn't preserve the proportions.
	if (distance > inRadius) {
		dx = cos(angle) * inRadius;
		dy = sin(angle) *  inRadius;
	}
	
	velocity = CGPointMake(dx/inRadius, dy/inRadius);
	
	// Constrain the thumb so that it stays within the joystick
	// boundaries.  This is smaller than the joystick radius in
	// order to account for the size of the thumb.
	if (distance > outRadius) {
		x = center.x + cos(angle) * outRadius;
		y = center.y + sin(angle) * outRadius;
	}
	
	std::cout << velocity.x << " " << velocity.y << std::endl;
	
	// Update the thumb's position
	this->getOwnerGE()->x = x;
	this->getOwnerGE()->y = y;
	this->setShape(CGRectMake(x, y, shape.size.width, shape.size.height));
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
			/*if(!outerRegionHit())
			{

			}*/
			this->updateVelocity(x, y);
			
			
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
		std::cout << "RESET" << std::endl;
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
	
	this->setInRadius(aRect.size.width * 0.5);	//We set the joystick paddle radius
	this->setOutRadius(aRect.size.width* 0.5 + aRect.size.width*0.25);	//We set the outer circle radius ( usually 2x inner paddle )
}
