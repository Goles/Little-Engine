//
//  Animation.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _ANIMATION_H_
#define _ANIMATION_H_

#include "SpriteSheet.h"
#include "Frame.h"
#include <vector>

class GameEntity;

enum {
	kDirection_Forward = 1,
	kDirection_Backwards = -1
};

typedef std::vector<Frame *> FRAMES_VECTOR;

class Animation
{
public:
	//constructors & destructor
	Animation();
	Animation(CGPoint startPoint);
	Animation(const std::vector<int>& positions, SpriteSheet *inSheet);
	~Animation();
	
	//Action methods
	void	addFrameWithImage(Image *inImage, float delay);
	void	update(float delta);
	void	renderAtPoint(CGPoint inPoint);
	
	//Getters
	Image*	getCurrentFrameImage();
	Frame*	getFrame(GLuint frameNumber);
	GLuint	getCurrentFrameNumber();
	GLuint	getAnimationFrameCount();
	
	//Setters
	void	setIsRunning(Boolean inIsRunning) { isRunning = inIsRunning; }
	void	setIsRepeating(Boolean inIsRepeating) { isRepeating = inIsRepeating; }
	void	setIsPingPong(Boolean inIsPingPong) { isPingPong = inIsPingPong; }
	
	//Debug
	void debugPrintFrames();
	
	//inherited stuff.
	void draw();
	void update();
	
private:
	CGPoint			currentPoint;
	FRAMES_VECTOR	spriteFrames;
	float			frameTimer;
	bool			isRunning;
	bool			isRepeating;
	bool			isPingPong;
	int				direction;
	int				currentFrame;
};

#endif