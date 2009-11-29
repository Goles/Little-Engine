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
	currentPoint	= CGPointZero;
	currentFrame	= 0;
	frameTimer		= 0;
	isRunning		= false;
	isRepeating		= false;
	isPingPong		= false;
	direction		= kDirection_Forward;
}

Animation::Animation(CGPoint inCurrentPoint)
{
	currentPoint	= inCurrentPoint;
	currentFrame	= 0;
	frameTimer		= 0;
	isRunning		= false;
	isRepeating		= false;
	isPingPong		= false;
	direction		= kDirection_Forward;
}

Animation::Animation(const std::vector<int>& positions, SpriteSheet *inSheet)
{
	currentPoint = CGPointZero;
	currentFrame = 0;
	frameTimer	 = 0;
	isRunning	 = false;
	isRepeating  = false;
	isPingPong	 = false;
	direction	 = kDirection_Forward;
	
	for (int i = 0; i < positions.size(); i+= 2)
	{
		this->addFrameWithImage(inSheet->getSpriteAt(positions[i],positions[i+1]), 0.1f);
	}
	
	this->debugPrintFrames();
}

#pragma mark action_methods
void Animation::addFrameWithImage(Image *inImage, float delay)
{
	Frame *aFrame = new Frame(inImage, delay);
	spriteFrames.push_back(aFrame);
}

void Animation::update(float delta)
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

void Animation::renderAtPoint(CGPoint inPoint)
{
	Frame *aFrame = spriteFrames.at(currentFrame);
	aFrame->getFrameImage()->renderAtPoint(inPoint, true);
}

void Animation::draw()
{
	Frame *aFrame = spriteFrames.at(currentFrame);
	aFrame->getFrameImage()->renderAtPoint(currentPoint, true);
}

void Animation::update()
{
	//here I should update the animation.
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

#pragma mark debug
void Animation::debugPrintFrames()
{
	FRAMES_VECTOR::iterator it;
		
	it = spriteFrames.begin();
	
	while ( it != spriteFrames.end() )
	{
		std::cout << (*it) << std::endl;
		
		it++;
	}
	
}

#pragma mark destructor
Animation::~Animation()
{
	//Destroy something.
}
