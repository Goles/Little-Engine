//
//  Frame.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "Frame.h"

#pragma mark constructor_destructor
Frame::Frame() : frameImage(NULL), frameDelay(0.0)
{
	//Do nothing here.
}

Frame::Frame(Image* inFrameImage, float inFrameDelay)
{
	this->frameImage = inFrameImage;
	this->frameDelay = inFrameDelay;
}

Frame::~Frame()
{
	//Destroy something.
}

#pragma mark getters
Image* Frame::getFrameImage()
{
	return frameImage;
}

float Frame::getFrameDelay()
{
	return frameDelay;
}