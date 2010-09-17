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

/** Container for Sprite Animations
	@remarks
		The gecAnimatedSprite is a container for Animations, which are sequences
		of sprites. Each animation has a key (std::string) and a pointer to an Animation
		object.
 */
class gecAnimatedSprite : public gecVisual
{
public:
	/** Constructor */
	gecAnimatedSprite();
	
	/** Returns the id of this component*/
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	
	/** Inherited render() method from gecVisual */
	virtual void render() const;
	
	/** Update method inherited from gecComponent*/
	virtual void update(float delta);
	
	/** Adds an animation to the componentAnimations map.
		@param animationName will be the "key" used to obtain the animation.
		@param animation will be a pointer to an Animation object.
	 */
	void addAnimation(const std::string &animationName, 
					  Animation *animation);
	
	/** Adds an anitmation to the componentAnimations map.
		@param animationName will be the "key" used to obtain the animation.
		@param positions will be a vector containing the coordinates of the Sprite Frames
		in the SpriteSheet. - The positions are in the format, [COL, ROW] 1,0 is COL 1, ROW 0-
		@param ss is a pointer to a SpriteSheet object.
	 */
	void addAnimation(const std::string &animationName, 
					  const std::vector<int> &positions, 
					  SpriteSheet *ss);

	/** Adds an anitmation to the componentAnimations map.
		@param animationName will be the "key" used to obtain the animation.
		@param positions will be a vector containing the coordinates of the Sprite Frames
		in the SpriteSheet. - The positions are in the format, [COL, ROW] 1,0 is COL 1, ROW 0-
		@param durations will be a vector<float> with the duration of each frame of an animation.
		@param ss is a pointer to a SpriteSheet object.
	 */
	void addAnimation(const std::string &animationName,
					  const std::vector<int> &positions,
					  const std::vector<float> &durations,
					  SpriteSheet *ss);
	void setCurrentAnimation(const std::string &animationName);
	Animation* getCurrentAnimation() { return currentAnimation; }
	Animation* getAnimation(const std::string&animationName);
	void setCurrentRunning(Boolean isRunning){ currentAnimation->setIsRunning(isRunning); }
	void setCurrentRepeating(Boolean isRepeating){ currentAnimation->setIsRepeating(isRepeating); } 
	void setCurrentPingPong(Boolean isPingPong){ currentAnimation->setIsPingPong(isPingPong); }
	void setFlipHorizontally(bool f);
	void setFlipVertically(bool f);
	void debugPrintAnimationMap();
	
private:
	typedef std::map<const std::string, Animation*> AnimationMap;
	typedef std::pair<const std::string, Animation*> AnimationMapPair;
	
	static gec_id_type	mGECTypeID;
	Animation*			currentAnimation;
	AnimationMap		componentAnimations;
	bool				flipHorizontally;
	bool				flipVertically;
};

#endif