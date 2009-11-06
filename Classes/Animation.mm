//
//  Animation.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"

#pragma mark constructor

Animation::Animation()
{
	currentFrame	= 0;
	frameTimer		= 0;
	isRunning		= false;
	isRepeating		= false;
	isPingPong		= false;
	direction		= kDirection_Forward;
}

#pragma mark action_methods
void	Animation::addFrameWithImage(Image *inImage, float delay)
{
	Frame *aFrame = new Frame(inImage, delay);
	spriteFrames.push_back(aFrame);
}

void	Animation::update(float delta)
{
	if(isRunning)
	{
		frameTimer += delta;
		
		if(frameTimer > (spriteFrames.at(currentFrame))->getFrameDelay())
		{
			currentFrame += direction;
			frameTimer = 0;
			if(currentFrame > (spriteFrames.size() - 1) || currentFrame < 0)
			{
				if (isPingPong) 
				{
					direction = -direction;
					currentFrame += direction;
				}
				if (isRepeating)
					currentFrame = 0;
				if (!isRepeating && !isPingPong) 
				{
					isRunning		= false;
					currentFrame	= 0;
				}
			}
		}
	}
		
}

void	Animation::renderAtPoint(CGPoint inPoint)
{
	Frame *aFrame = spriteFrames.at(currentFrame);
	
	aFrame->getFrameImage()->renderAtPoint(inPoint, true);
}

#pragma mark getters

Image*	Animation::getCurrentFrameImage()
{
	return (spriteFrames.at(currentFrame)->getFrameImage());
}

Frame*	Animation::getFrame(GLuint frameNumber)
{
	if(frameNumber > spriteFrames.size())
	{
		printf("WARNING: Requested frame %d is out of bounds\n", frameNumber);
		return NULL;
	}
	
	return (spriteFrames.at(frameNumber));
}

GLuint	Animation::getCurrentFrameNumber()
{
	return currentFrame;
}

GLuint	Animation::getAnimationFrameCount()
{
	return (spriteFrames.size());
}

#pragma mark setters
void	Animation::setIsRunning(BOOL inIsRunning)
{
	isRunning = inIsRunning;
}

void	Animation::setIsRepeating(BOOL inIsRepeating)
{
	isRepeating = inIsRepeating;
}