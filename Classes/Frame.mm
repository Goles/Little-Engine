//
//  Frame.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Frame.h"

#pragma mark constructor_destructor
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