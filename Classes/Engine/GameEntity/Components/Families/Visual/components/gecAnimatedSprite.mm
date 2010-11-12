//
//  gecAnimatedSprite.m
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "gecAnimatedSprite.h"
#include "LuaRegisterManager.h"
#include "GameEntity.h"

std::string gecAnimatedSprite::mGECTypeID = "gecAnimatedSprite";

#pragma mark -
#pragma mark gecAnimatedSprite Interface.
gecAnimatedSprite::gecAnimatedSprite() : flipHorizontally(false),
										 flipVertically(false),
										 currentAnimation(NULL)
{
}

//Adds an Animation with default parameters.
void gecAnimatedSprite::addAnimation(const std::string &animationName, Animation *animation)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if(it != componentAnimations.end())
		return;
	
	componentAnimations.insert(AnimationMapPair(animationName, animation));
}

//Adds an Animation with the default time frame. (0.10f)
void gecAnimatedSprite::addAnimation(const std::string &animationName, 
									 const std::vector<int> &positions, 
									 SpriteSheet *ss)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	//The animation is already in the map
	if (it != componentAnimations.end()) 
		return;
	
	//If the key is not in the map	
	Animation *newAnimation = new Animation(positions, ss);
	componentAnimations.insert(AnimationMapPair(animationName, newAnimation));	
}

//Adds an Animation with a specific TimeFrame per Frame.
void gecAnimatedSprite::addAnimation(const std::string &animationName,
									 const std::vector<int> &positions,
									 const std::vector<float> &durations,
									 SpriteSheet *ss)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	//The animation is already in the map
	if (it != componentAnimations.end()) 
		return;
	
	//Create a new animation if the "Animation Map Key" is not found in the map
	Animation *newAnimation = new Animation(positions, durations, ss);
	componentAnimations.insert(AnimationMapPair(animationName, newAnimation));
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
	
	if(!currentAnimation)
	{
		std::cout << "ERROR: currentAnimation can't be NULL in gecAnimatedSprite... aborting (use setCurrentAnimation)." << std::endl;
		abort();
	}

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