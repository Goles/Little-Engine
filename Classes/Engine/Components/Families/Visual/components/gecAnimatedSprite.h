//
//  gecAnimatedSprite.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/26/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
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
//------------------------------------------------------------------------------
	/** Constructor */
	gecAnimatedSprite();
	
//------------------------------------------------------------------------------
	/** Returns the id of this component*/
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	
	/** Implemented render() method from gecVisual */
	virtual void render() const;
    
	/** Update method inherited from gecComponent*/
	virtual void update(float delta);
	
//------------------------------------------------------------------------------
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
    
//------------------------------------------------------------------------------	
	/** Set's the active animation to animationName
		@param animationName must be a std::string "key" in the componentAnimations map
	 */
	void setCurrentAnimation(const std::string &animationName);
	
	/** Returns a pointer to the current animation.
		@remarks
			Note that we don't return a const pointer, this is in case we want 
			to make some changes to the returned Animation*.
		
	 */
	Animation* getCurrentAnimation() { return currentAnimation; }
	
	/** Returns an animation present in the map.
		@param animationName is the std::string	"key" of the animation in componentAnimations.
		@returns Animation pointer to the requested animation or NULL if the animation is not found.
	 */
	Animation* getAnimation(const std::string &animationName);
	
	/** Set the current animation mode to "running" or "active". */
	void setCurrentRunning(bool isRunning){ currentAnimation->setIsRunning(isRunning); }
	
	/** Set the current animation mode to "repeating"
		@remarks
			This means that for a 3 frames Animation it will go, 0,1,2,0,1,2,0,1,2
	 */
	void setCurrentRepeating(bool isRepeating){ currentAnimation->setIsRepeating(isRepeating); } 
	
	/** Set the current animation mode to "pingPong"
		@remarks
			This means that for a 3 frames animation it will go, 0,1,2,1,0,1,2,1,0
	 */
	void setCurrentPingPong(bool isPingPong){ currentAnimation->setIsPingPong(isPingPong); }
	
	/** Flips an Animation horizontally.*/
	void setFlipHorizontally(bool f);
	
	/** Flips an Animation vertically. */
	void setFlipVertically(bool f);
	
//------------------------------------------------------------------------------	
	/** Internal debug function
		@remarks Print's the information of the animations available in the map.
	 */
	void debugPrintAnimationMap();

//------------------------------------------------------------------------------	
private:
	typedef std::map<const std::string, Animation*> AnimationMap;		/** < Typedef to manipulate an Animation std::map easily */
	typedef std::pair<const std::string, Animation*> AnimationMapPair;	/** < Typedef  to manipulate an AnimationMap iterator easily*/
	
	static gec_id_type mGECTypeID;		/** < Label of this kind of component */
	AnimationMap componentAnimations;   /** < Map with all the animations of the component */
	Animation *currentAnimation;		/** < Animation pointer to the current active Animation */
    
    bool m_dirtyColor;                
    bool flipHorizontally;
	bool flipVertically;
};

#endif