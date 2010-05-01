//
//  gecAnimatedSprite.m
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "gecAnimatedSprite.h"

std::string gecAnimatedSprite::mGECTypeID = "gecAnimatedSprite";

#pragma mark -
#pragma mark gecAnimatedSprite Interface.
gecAnimatedSprite::gecAnimatedSprite()
{
	flipHorizontally	= false;
	flipVertically		= false;	
}

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

void gecAnimatedSprite::addAnimation(const std::string &animationName, Animation *animation)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if(it != componentAnimations.end())
		return;
	
	componentAnimations.insert(AnimationMapPair(animationName, animation));
}

void gecAnimatedSprite::setCurrentAnimation(const std::string &animationName)
{	
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if(it != componentAnimations.end()) //if the texture IS in the map, we switch the current texture.
	{	
		currentAnimation = componentAnimations[animationName];
	}
	else {
		std::cout << "Warning, " << animationName << " is not present in the animation Map, animation NOT being changed. " << std::endl;
	}	
}

Animation* gecAnimatedSprite::getAnimation(const std::string& animationName)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if(it != componentAnimations.end())
		return it->second;
	
	return NULL;
}

void gecAnimatedSprite::setFlipHorizontally(bool f)
{
	AnimationMap::iterator it;
	for(it = componentAnimations.begin(); it != componentAnimations.end(); ++it)
	{
		((Animation*)(*it).second)->setFlipHorizontally(f);
	}
}

void gecAnimatedSprite::setFlipVertically(bool f)
{
	AnimationMap::iterator it;
	
	for(it = componentAnimations.begin(); it != componentAnimations.end(); ++it)
	{
		(it->second)->setFlipVertically(f);
	}
}

#pragma mark -
#pragma mark gecVisual Interface
void gecAnimatedSprite::render() const
{
	GameEntity *ge = this->getOwnerGE();
	currentAnimation->renderAtPoint(CGPointMake(ge->x,ge->y));
}

void gecAnimatedSprite::update(float delta)
{
	GameEntity *ge = this->getOwnerGE();
	currentAnimation->setFlipHorizontally(ge->getFlipHorizontally());
	currentAnimation->update(delta);
}

void gecAnimatedSprite::debugPrintAnimationMap()
{
	AnimationMap::iterator it;
	
	std::cout << "**DEBUG ANIMATION MAP ** "<< std::endl;
	
	for(it = componentAnimations.begin(); it != componentAnimations.end(); it++)
	{
		//Print Animation Name & Address
		std::cout << (*it).first <<" " <<  (*it).second;
		Animation *a = (*it).second;
		//Print the animation Frames.
		a->debugPrintFrames();
	}
}