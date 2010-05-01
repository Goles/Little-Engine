//
//  Animation.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "Animation.h"
#include "GameEntity.h"

#pragma mark -
#pragma mark constructor
Animation::Animation()
{
	currentPoint	= CGPointZero;
	currentFrame	= 0;
	frameTimer		= 0;
	isRunning		= false;
	isRepeating		= false;
	isPingPong		= false;
	notify			= false;
	delegation		= false;
	isFlipped		= false;
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
	notify			= false;
	delegation		= false;
	isFlipped		= false;	
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
	notify		 = false;
	delegation	 = false;
	isFlipped		= false;	
	direction	 = kDirection_Forward;
	
	for (int i = 0; i < positions.size(); i+= 2)
	{
		this->addFrameWithImage(inSheet->getSpriteAt(positions[i],positions[i+1]), 0.1f);
	}
}

#pragma mark -
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
				
				/*
				 * Enable the notification flag.
				 * Basically this means that we have arrived the end of this Sprite sequence.
				 */
				notify = true;
			}
		}
	}
}

void Animation::renderAtPoint(CGPoint inPoint)
{
	Frame *aFrame = spriteFrames.at(currentFrame);
	aFrame->getFrameImage()->renderAtPoint(inPoint, true);
	this->notifyDelegate();	
}

void Animation::draw()
{
	Frame *aFrame = spriteFrames.at(currentFrame);
	aFrame->getFrameImage()->renderAtPoint(currentPoint, true);
	this->notifyDelegate();
}

void Animation::update()
{
	//here I should update the animation.
}

#pragma mark -
#pragma mark getters
Image* Animation::getCurrentFrameImage()
{
	return (spriteFrames.at(currentFrame)->getFrameImage());
}

Frame* Animation::getFrame(GLuint frameNumber)
{
	if(frameNumber > spriteFrames.size())
	{
		printf("WARNING: Requested frame %d is out of bounds\n", frameNumber);
		return NULL;
	}
	
	return (spriteFrames.at(frameNumber));
}

GLuint Animation::getCurrentFrameNumber()
{
	return currentFrame;
}

GLuint Animation::getAnimationFrameCount()
{
	return (spriteFrames.size());
}

void Animation::setFlipHorizontally(bool f)
{	

	FRAMES_VECTOR::iterator it;	
	if(isFlipped != f)
	{
		for(it = spriteFrames.begin(); it < spriteFrames.end(); ++it)
		{
			Image *im = (*it)->getFrameImage();
			im->setFlipHorizontally(f);
		}
		
		isFlipped = f;
	}
}

void Animation::setFlipVertically(bool f)
{
	FRAMES_VECTOR::iterator it;
	for(it = spriteFrames.begin(); it < spriteFrames.end(); ++it)
	{
		((*it)->getFrameImage())->setFlipVertically(f);
	}
}

#pragma mark -
#pragma mark delegate
void Animation::setDelegate(const AnimationTrigger::slot_type& slot)
{
	delegate.connect(slot);
	delegation = true; //Activate delegation for this Animation.
}

void Animation::notifyDelegate()
{
	/*
	 *	If we have enabled delegation, this Animation will let a subscriber
	 *	know, when is the sprite sequence finished.
	 */
	if(delegation)
	{
		if(notify)
		{
			delegate();
			notify = false;
		}
	}
}

#pragma mark -
#pragma mark debug
void Animation::debugPrintFrames()
{
	std::cout << "** DEBUG PRINT FRAMES **" << std::endl;
	std::cout << "Number of Frames: " << spriteFrames.size() << std::endl;
	FRAMES_VECTOR::iterator it;
		
	it = spriteFrames.begin();
	
	while ( it != spriteFrames.end() )
	{
		std::cout << (*it) << std::endl;		
		++it;
	}	
}

#pragma mark -
#pragma mark destructor
Animation::~Animation()
{
	//Destroy something.
}
