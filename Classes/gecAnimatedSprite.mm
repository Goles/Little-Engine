//
//  gecAnimatedSprite.m
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecAnimatedSprite.h"

std::string gecAnimatedSprite::mGECTypeID = "gecAnimatedSprite";

void gecAnimatedSprite::addAnimation(const std::string &animationName, const std::vector<int> &positions, SpriteSheet *inSheet)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	/*The animation is already in the map*/
	if (it != componentAnimations.end()) 
		return;
	
	/*If the key is not in the map*/	
	Animation *newAnimation = new Animation(positions, inSheet);
	componentAnimations.insert(AnimationMapPair(animationName, newAnimation));	
}

void gecAnimatedSprite::setCurrentAnimation(const std::string &animationName)
{	
	currentAnimation = componentAnimations[animationName];
}

void gecAnimatedSprite::render() const
{
	GameEntity *ge = this->getOwnerGE();
	currentAnimation->renderAtPoint(CGPointMake(ge->x,ge->y));
}

void gecAnimatedSprite::update(float delta) const
{
	currentAnimation->update(delta);
}

void gecAnimatedSprite::debugPrintAnimationMap()
{
	AnimationMap::iterator it;
	
	std::cout << "**DEBUG ANIMATION MAP ** "<< std::endl;
	
	for(it = componentAnimations.begin(); it != componentAnimations.end(); it++)
	{
		std::cout << (*it).first <<" " <<  (*it).second << std::endl;
	}
	
}