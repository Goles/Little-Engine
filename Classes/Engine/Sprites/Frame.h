//
//  Frame.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

//#import <Foundation/Foundation.h>

#ifndef _FRAME_H_
#define _FRAME_H_

#include "Image.h"

class Frame
{
public:
	//Constructor & Destructor
	Frame();
	
	//getters
	Image*	getFrameImage() const { return frameImage; }
	float	getFrameDelay() const { return frameDelay; }
	
	//Setters
	void	setFrameImage(Image* _image) { frameImage = _image; }
	void	setFrameDelay(float _delay) { frameDelay = _delay; }
	
private:
	Image *frameImage;
	float frameDelay;
};

#endif