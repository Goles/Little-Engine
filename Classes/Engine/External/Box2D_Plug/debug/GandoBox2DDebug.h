/*
 *  GandoBox2DDebug.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/5/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef __GANDO_BOX_2D_DEBUG_H__
#define __GANDO_BOX_2D_DEBUG_H__

#include "Image.h"
#include "Box2D.h"

typedef struct
{
	Image *img;
	float x,y;
	b2Manifold manifold;
	b2PolygonShape shape;
	b2Transform transform;
} Gbox;

#endif
