//
//  Animation.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef _ANIMATION_H_
#define _ANIMATION_H_

#include "SpriteSheet.h"
#include "Frame.h"
#include <vector>
#include <boost/signal.hpp>
#include <boost/bind.hpp>

class GameEntity;

enum {
	kDirection_Forward = 1,
	kDirection_Backwards = -1
};

typedef std::vector<Frame *> FRAMES_VECTOR;
typedef boost::signal<void ()> AnimationTrigger; //gets notified when an animation ends ( displays last frame )

class Animation
{
public:
	//Constructors & destructor
	Animation();
	Animation(CGPoint startPoint);
	Animation(const std::vector<int>& positions, SpriteSheet *inSheet);
	Animation(const std::vector<int>& positions, const std::vector<float>& durations, SpriteSheet *ss);
	~Animation();
	
	//Action methods
	void	addFrame(Frame *aFrame);
	void	addFrameWithImage(Image *inImage, float delay);
	void	update(float delta);
	void	renderAtPoint(CGPoint inPoint);
	
	//Getters
	Image*	getCurrentFrameImage();
	Frame*	getFrame(GLuint frameNumber);
	GLuint	getCurrentFrameNumber();
	GLuint	getAnimationFrameCount();
	const bool getIsRunning(){ return isRunning; }
	const bool getIsRepeating(){ return isRepeating; }	
	const bool getIsPingPong(){ return isPingPong; }
	
	//Setters
	void	setCurrentFrame(int frame) { if(frame <= spriteFrames.size()) currentFrame = frame; }
	void	setIsRunning(bool inIsRunning) { isRunning = inIsRunning; }
	void	setIsRepeating(bool inIsRepeating) { isRepeating = inIsRepeating; }
	void	setIsPingPong(bool inIsPingPong) { isPingPong = inIsPingPong; }
	void	setFlipHorizontally(bool f);
	void	setFlipVertically(bool f);
	
	//Delegate
	void	setDelegate(const AnimationTrigger::slot_type& slot);
	void	notifyDelegate();
	
	//Debug
	void	debugPrintFrames();
	
	//inherited stuff.
	void draw();
	void update();
	
//------------------------------------------------------------------------------
/** Lua Interface
 @remarks
 This methods are to expose this class to the Lua runtime.
 */
	static void registrate(void)
	{	
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<Animation>("Animation")	/** < Binds the GameEntity class*/
		 .def(luabind::constructor<>())				/** < Binds the GameEntity constructor  */
		 .def("addFrame", &Animation::addFrame)
		 .property("running", &Animation::getIsRunning, &Animation::setIsRunning)
		 .property("repeating", &Animation::getIsRepeating, &Animation::setIsRepeating)
		 .property("pingpong", &Animation::getIsPingPong, &Animation::setIsPingPong)
		 ];
	}
	
private:
	CGPoint				currentPoint;
	FRAMES_VECTOR		spriteFrames;
	float				frameTimer;
	bool				isRunning;
	bool				isRepeating;
	bool				isPingPong;
	bool				isFlipped;
	bool				delegation;
	bool				notify;
	int					direction;
	int					currentFrame;
	AnimationTrigger	delegate;		//This is used to let a subscriber know when certain animation finishes displaying. (not used all the time)
};

#endif