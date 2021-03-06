//
//  Frame.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "Frame.h"

#pragma mark constructor_destructor
Frame::Frame() 
    : frameImage(NULL)
    , frameDelay(0.0)
{
}

#pragma mark getters
Image* Frame::getFrameImage() const
{
	return frameImage;
}

float Frame::getFrameDelay()
{
	return frameDelay;
}