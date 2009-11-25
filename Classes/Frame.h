//
//  Frame.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"


class Frame
{
public:
	//Constructor & Destructor
	Frame(Image* inFrameImage, float inFrameDelay);
	~Frame();
	
	//getters
	Image*	getFrameImage();
	float	getFrameDelay();
	
private:
	Image *frameImage;
	float frameDelay;
};

