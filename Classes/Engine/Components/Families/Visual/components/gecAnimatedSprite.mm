//
//  gecAnimatedSprite.m
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "gecAnimatedSprite.h"
#include "GameEntity.h"
#include "Image.h"
#include "ConstantsAndMacros.h"

std::string gecAnimatedSprite::mGECTypeID = "gecAnimatedSprite";

#pragma mark -
#pragma mark gecAnimatedSprite Interface.
gecAnimatedSprite::gecAnimatedSprite() : flipHorizontally(false),
										 flipVertically(false),
										 currentAnimation(NULL),
                                         m_dirtyColor(false)
{
}

//Adds an Animation with default parameters.
void gecAnimatedSprite::addAnimation(const std::string &animationName, Animation *animation)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if (it != componentAnimations.end())
		return;
	
	//set the GameEntity "owner" uid of this animation ( used as payload for animations
	animation->setOwnerGAS(this);
	componentAnimations.insert(AnimationMapPair(animationName, animation));
}

//Adds an Animation with the default time frame. (0.10f)
//void gecAnimatedSprite::addAnimation(const std::string &animationName, 
//									 const std::vector<int> &positions, 
//									 SpriteSheet *ss)
//{
//	AnimationMap::iterator it = componentAnimations.find(animationName);
//	
//	//The animation is already in the map
//	if (it != componentAnimations.end()) 
//		return;
//	
//	//If the key is not in the map	
//	Animation *newAnimation = new Animation(positions, ss);
//	componentAnimations.insert(AnimationMapPair(animationName, newAnimation));	
//}

//Adds an Animation with a specific TimeFrame per Frame.
//void gecAnimatedSprite::addAnimation(const std::string &animationName,
//									 const std::vector<int> &positions,
//									 const std::vector<float> &durations,
//									 SpriteSheet *ss)
//{
//	AnimationMap::iterator it = componentAnimations.find(animationName);
//	
//	//The animation is already in the map
//	if (it != componentAnimations.end()) 
//		return;
//	
//	//Create a new animation if the "Animation Map Key" is not found in the map
//	Animation *newAnimation = new Animation(positions, durations, ss);
//	componentAnimations.insert(AnimationMapPair(animationName, newAnimation));
//}

void gecAnimatedSprite::setCurrentAnimation(const std::string &animationName)
{	
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if (it != componentAnimations.end()) { //if the texture IS in the map, we switch the current texture.
		currentAnimation = componentAnimations[animationName];
        currentAnimation->setIsRunning(true);
	} else {
		std::cout << "Warning, " << animationName << " is not present in the animation Map, animation NOT being changed. " << std::endl;
	}	
}

Animation* gecAnimatedSprite::getAnimation(const std::string& animationName)
{
	AnimationMap::iterator it = componentAnimations.find(animationName);
	
	if (it != componentAnimations.end())
		return it->second;
	
	return NULL;
}

void gecAnimatedSprite::setFlipHorizontally(bool f)
{
	AnimationMap::iterator it;
	for (it = componentAnimations.begin(); it != componentAnimations.end(); ++it) {
		((Animation*)(*it).second)->setFlipHorizontally(f);
	}
}

void gecAnimatedSprite::setFlipVertically(bool f)
{
	AnimationMap::iterator it;
	
	for (it = componentAnimations.begin(); it != componentAnimations.end(); ++it) {
		(it->second)->setFlipVertically(f);
	}
}

#pragma mark -
#pragma mark gecVisual Interface
void gecAnimatedSprite::render() const
{
    GameEntity *ge = this->getOwnerGE();
	
	if(!currentAnimation)
		assert(currentAnimation != NULL);
  
    glPushMatrix();

    //Anchor Point Translate
    glTranslatef(-m_anchor.x * currentAnimation->getCurrentFrameWidth(), -m_anchor.y * currentAnimation->getCurrentFrameHeight(), 0.0);
    
    //Translate to Entity coords.    
    glTranslatef(ge->getPositionX(), ge->getPositionY(), 0);
 
    if (gecVisual::m_dirtyScale)
       glScalef(m_scale.x, m_scale.y, 1.0);
    
    if (gecVisual::m_dirtyTransform)
        glMultMatrixf(m_transform);

    if (gecVisual::m_dirtyColor) {
        Image* frame = currentAnimation->getCurrentFrameImage();
        frame->setColorFilter(m_color[0], m_color[1], m_color[2], m_color[3]);
    }

    //Translate Back to screen coords.
    glTranslatef(-1 * ge->getPositionX(), -1 * ge->getPositionY(), 0);    
    currentAnimation->renderAtPoint(ge->getPosition());
    glPopMatrix();
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
	
	for (it = componentAnimations.begin(); it != componentAnimations.end(); it++) {
		//Print Animation Name & Address
		std::cout << (*it).first <<" " <<  (*it).second;
		Animation *a = (*it).second;
		//Print the animation Frames.
		a->debugPrintFrames();
	}
}