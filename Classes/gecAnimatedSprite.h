//
//  gecAnimatedSprite.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecVisual.h"
#import "SpriteSheet.h"
#import "Animation.h"
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
	virtual void update(float delta) const;
	
	//gecAnimatedSprite interface
public:
	void addAnimation(const std::string &animationName, const std::vector<int> &positions, SpriteSheet *inSheet);
	void setCurrentAnimation(const std::string &animationName);
	void switchToAnimation(const std::string &animationName);
	void setCurrentRunning(Boolean isRunning){ currentAnimation->setIsRunning(isRunning); }
	void setCurrentRepeating(Boolean isRepeating){ currentAnimation->setIsRepeating(isRepeating); } 
	void debugPrintAnimationMap();
	
private:
	typedef std::map<const std::string, Animation*> AnimationMap;
	typedef std::pair<const std::string, Animation*> AnimationMapPair;
	
	static gec_id_type mGECTypeID;
	Animation *currentAnimation;
	AnimationMap componentAnimations;
};