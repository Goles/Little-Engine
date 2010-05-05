/*
 *  GandoBox2D.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "GandoBox2D.h"
#include "GLES-Render.h"
#include "GandoBox2DDebug.h"

GandoBox2D* GandoBox2D::instance = NULL;

#pragma mark -
#pragma mark init
GandoBox2D::GandoBox2D()
{
	world = NULL;
}

void GandoBox2D::initWorld(const b2Vec2 &gravity, bool doSleep)
{
	if(world == NULL)
	{
		world = new b2World(gravity, doSleep);
		world->SetContinuousPhysics(true);
	}
}

void GandoBox2D::initDebugDraw()
{
	if(world != NULL)
	{
		//Set World debug drawer.
		uint32 flags = 0;
		flags += b2DebugDraw::e_shapeBit;
		debugDraw->SetFlags(flags);
		debugDraw = new GLESDebugDraw(PTM_RATIO);
		world->SetDebugDraw(debugDraw);
	}
	else {
		std::cout << "World should be non-null." << std::endl;
		assert(world != NULL);
	}
}

#pragma mark -
#pragma mark actions
GandoBox2D* GandoBox2D::getInstance()
{
	if(instance == NULL)
		instance = new GandoBox2D();
	
	return instance;
}

void GandoBox2D::addDebugSpriteWithCoords(float x, float y)
{
	//Create and add a placeholder BoxSprite to our debug sprite vector.
	Gbox *box = (Gbox *)malloc(sizeof(Gbox));
	box->x = x;
	box->y = y;
	box->img->initWithTextureFile("gando_box.png");
	this->boxes.push_back(box);
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(x/PTM_RATIO, y/PTM_RATIO);
	bodyDef.userData = box;
	b2Body *body = this->world->CreateBody(&bodyDef);
	
	// Define box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
}

#pragma mark -
#pragma mark cleanup
GandoBox2D::~GandoBox2D()
{
	if(debugDraw != NULL)
		delete debugDraw;
	
	delete world;
}