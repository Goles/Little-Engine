/*
 *  GandoBox2D.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GANDO_BOX_2D_H_
#define _GANDO_BOX_2D_H_

#define GBOX_2D GandoBox2D::getInstance()
#define GBOX_2D_WORLD GandoBox2D::getInstance()->getWorld()

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

#include <iostream>
#include <vector>

#include "Box2D.h"
#include "GandoBox2DDebug.h"

class GLESDebugDraw;

class	GandoBox2D
{
	//Action interface.
public:
	~GandoBox2D();
	static GandoBox2D*	getInstance();
	void				update(float delta);
	b2World*			getWorld() const;
	void				initBaseWorld();	
	void				initWorld(const b2Vec2 &gravity, bool doSleep);
	
	//Debug interface.
public:	
	void				initDebugDraw();
	void				debugRender();
	void				addDebugSpriteWithCoords(float x, float y);
	
protected:
	GandoBox2D();
	
private:
	b2World*			world; //Box2d World.
	static GandoBox2D*	instance;
	GLESDebugDraw*		debugDraw;
	
	//Just for debug, list of Animations
	std::vector<Gbox *> boxes;
};

#endif