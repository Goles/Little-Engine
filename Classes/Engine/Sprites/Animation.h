//
//  Animation.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef __ANIMATION_H__
#define __ANIMATION_H__

#include <vector>

#include "ConstantsAndMacros.h"
#include "SpriteSheet.h"
#include "Frame.h"

enum {
	kDirection_Forward = 1,
	kDirection_Backwards = -1
};

typedef std::vector<Frame *> FRAMES_VECTOR;

class gecAnimatedSprite;
class CGPoint;

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
    float getCurrentFrameWidth();
    float getCurrentFrameHeight();
	const bool getIsRunning(){ return isRunning; }
	const bool getIsRepeating(){ return isRepeating; }	
	const bool getIsPingPong(){ return isPingPong; }
	std::string getAnimationLabel() const { return animation_label; }
	
	//Setters
	void	setCurrentFrame(int frame) { if(frame <= spriteFrames.size()) currentFrame = frame; }
	void	setIsRunning(bool inIsRunning) { isRunning = inIsRunning; }
	void	setIsRepeating(bool inIsRepeating) { isRepeating = inIsRepeating; }
	void	setIsPingPong(bool inIsPingPong) { isPingPong = inIsPingPong; }
	void	setFlipHorizontally(bool f);
	void	setFlipVertically(bool f);
	void	setAnimationLabel(const std::string &in_animation_label){ animation_label = in_animation_label; }
	void	setOwnerGAS(gecAnimatedSprite *gas) { ownerGAS = gas; }
	
	//Delegate
	void	notifyDelegate();
	
	//Debug
	void	debugPrintFrames();
	
	//inherited stuff.
	void draw();
	void update();
    
//------------------------------------------------------------------------------	
    
private:
	gecAnimatedSprite*	ownerGAS; 
	std::string			animation_label;
    Frame*              renderFrame;
	CGPoint				currentPoint;
	FRAMES_VECTOR		spriteFrames;
	float				frameTimer;
    int					direction;
	int					currentFrame;
	bool				isRunning;
	bool				isRepeating;
	bool				isPingPong;
	bool				isFlipped;
	bool				delegation;
	bool				notify;

};

#endif