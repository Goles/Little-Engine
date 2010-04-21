//
//  gecAnimatedSprite.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _GECANIMATEDSPRITE_H_
#define _GECANIMATEDSPRITE_H_

#include "gecVisual.h"
#include "SpriteSheet.h"
#include "Animation.h"
#include <map>

class gecAnimatedSprite : public gecVisual
{
	//GEComponent interface
public:
	gecAnimatedSprite(){}
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	
	//gecVisual interface
public:
	virtual void render() const;
	virtual void update(float delta);
	
	//gecAnimatedSprite interface
public:
	void addAnimation(const std::string &animationName, const std::vector<int> &positions, SpriteSheet *inSheet);
	void addAnimation(const std::string &animationName, Animation *animation);
	void setCurrentAnimation(const std::string &animationName);
	Animation* getAnimation(const std::string&animationName);
	void setCurrentRunning(Boolean isRunning){ currentAnimation->setIsRunning(isRunning); }
	void setCurrentRepeating(Boolean isRepeating){ currentAnimation->setIsRepeating(isRepeating); } 
	void setCurrentPingPong(Boolean isPingPong){ currentAnimation->setIsPingPong(isPingPong); }  
	void debugPrintAnimationMap();
	
private:
	typedef std::map<const std::string, Animation*> AnimationMap;
	typedef std::pair<const std::string, Animation*> AnimationMapPair;
	
	static gec_id_type	mGECTypeID;
	Animation*			currentAnimation;
	AnimationMap		componentAnimations;
};

#endif