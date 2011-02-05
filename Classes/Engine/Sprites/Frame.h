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
#include "LuaRegisterManager.h"

class Frame
{
public:
	//Constructor & Destructor
	Frame();
	
	//getters
	Image*	getFrameImage() const;
	float	getFrameDelay();
	
	//Setters
	void	setFrameImage(Image* _image) { frameImage = _image; }
	void	setFrameDelay(float _delay) { frameDelay = _delay; }
	
	
	/** Lua Interface
	 @remarks
		This methods are to expose this class to the Lua runtime.
	 */
	static void registrate(void)
	{	
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<Frame>("Frame")	/** < Binds the GameEntity class */
		 .def(luabind::constructor<>())		/** < Binds the GameEntity constructor */
		 .property("image", &Frame::getFrameImage, &Frame::setFrameImage)
		 .property("delay", &Frame::getFrameDelay, &Frame::setFrameDelay)
		 ];
	}
	
private:
	Image *frameImage;
	float frameDelay;
};

#endif