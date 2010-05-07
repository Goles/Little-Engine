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
#include "ConstantsAndMacros.h"

GandoBox2D* GandoBox2D::instance = NULL;

#pragma mark -
#pragma mark init
GandoBox2D::GandoBox2D()
{
	world = NULL;
}

void GandoBox2D::initBaseWorld()
{
	//Init a World with no gravity and with no sleeping entities
	//this setup is the ideal one if we want to control our entities
	//directly from our external engine.
	if(world == NULL)
	{
		b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
		bool doSleep = false;
		world = new b2World(gravity, doSleep);
	}
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
		//Alloc debug Draw
		debugDraw = new GLESDebugDraw(PTM_RATIO);
		//Set World debug drawer.
		uint32 flags = 0;
		flags += b2DebugDraw::e_shapeBit;
		debugDraw->SetFlags(flags);
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

b2World* GandoBox2D::getWorld() const
{
	if( world == NULL)
	{
		std::cout << "ERROR: World should be non null!" << std::endl;
		assert(world != NULL);
	}
	
	return world;
}

void GandoBox2D::update(float delta)
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(delta, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the Sprites position and rotation with the corresponding body
			Gbox* box = (Gbox*)b->GetUserData();
			box->x = b->GetPosition().x * PTM_RATIO;
			box->y = b->GetPosition().y * PTM_RATIO;
			box->img->setRotation( -1 * CC_RADIANS_TO_DEGREES(b->GetAngle()));
		}	
	}
}

#pragma mark -
#pragma mark debug
void GandoBox2D::debugRender()
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_VERTEX_ARRAY);
	if(world != NULL)
		this->world->DrawDebugData();
	else {
		std::cout << "Box2d world is NULL, please check that you initialized it" << std::endl;
		assert(world != NULL);
	}

	// restore default GL states
	glDisableClientState(GL_VERTEX_ARRAY);
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);	
}

void GandoBox2D::addDebugSpriteWithCoords(float x, float y)
{
	//Create and add a placeholder BoxSprite to our debug sprite vector.
	Gbox *box = (Gbox *)malloc(sizeof(Gbox));
	box->x = x;
	box->y = y;
	box->img = new Image();
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