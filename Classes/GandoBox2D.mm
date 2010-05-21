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
#include "GameEntity.h"
#include "gecBoxCollision.h"
#include "gecWeapon.h"

GandoBox2D* GandoBox2D::instance = NULL;

#pragma mark -
#pragma mark init
GandoBox2D::GandoBox2D()
{
	world = NULL;
	contactListener = NULL;
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
		
		//Initialize the contact listener for this world.
		contactListener = new GContactListener();
		world->SetContactListener(contactListener);
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
	if(world == NULL)
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
	
	int32 velocityIterations = 10;
	int32 positionIterations = 10;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(delta, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world and apply transformations
	//To keep in Sync with our Entity World
	//TODO: This is just temporary, in the future EVERYTHING that colides is a 
	//CompCollision object.
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the Sprites position and rotation with the corresponding body
			GEComponent *gc = (GEComponent *)b->GetUserData();
			
			if(gc->componentID().compare("gecBoxCollision") == 0)
			{
				gecBoxCollision *c_col = (gecBoxCollision *)gc;
				c_col->setTransform(b);
				
			}else if(gc->componentID().compare("gecWeapon") == 0){
				gecWeapon *c_weap = static_cast<gecWeapon *> (gc);
				c_weap->setTransform(b);
			}
		}	
	}

	//Get our constant contacts vector reference and declare an appropiate const
	//iterator.
	const vector<GContact> *contacts = contactListener->getContacts();
	vector<GContact>::const_iterator it;
	
	for(it = contacts->begin(); it != contacts->end(); ++it)
	{
		GContact contact = *it;
		
		//Check contact between two bodies.
		b2Body *bodyA = contact.fixtureA->GetBody();
		b2Body *bodyB = contact.fixtureB->GetBody();
		
		//If we have an entity in each of the bodies
		if(bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
		{
			GEComponent *geA = (GEComponent *)(bodyA->GetUserData());
			GEComponent *geB = (GEComponent *)(bodyB->GetUserData());
			
			if (geA->getOwnerGE() != geB->getOwnerGE())
			{
				gecBoxCollision *c_body_a = NULL;
				gecWeapon *c_weapon_a = NULL;
				gecBoxCollision *c_body_b = NULL;
				gecWeapon *c_weapon_b = NULL;
				
				//Checks for componentA.
				if (geA->componentID().compare("gecBoxCollision") == 0)
					c_body_a = (gecBoxCollision *)geA;
				else if (geA->componentID().compare("gecWeapon") == 0)
					c_weapon_a = (gecWeapon *)geA;
				
				//Checks for componentB
				if (geB->componentID().compare("gecBoxCollision") == 0)
					c_body_b = (gecBoxCollision *)geB;
				else if (geB->componentID().compare("gecWeapon") == 0)
					c_weapon_b = (gecWeapon *)geB;

				
				//If we have two different bodies colliding
				if (c_body_a != NULL && c_body_b != NULL)
				{
					geA->getOwnerGE()->x += ceilf(2*(bodyA->GetPosition().x - bodyB->GetPosition().x));
					geA->getOwnerGE()->y += ceilf(2*(bodyA->GetPosition().y - bodyB->GetPosition().y));
				}

				//Handle the collision between Entity A and B here.
				//std::cout << geA << " and " << geB << " collided" << std::endl;
			}
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
	glPushMatrix();
	
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	if(world != NULL)
		this->world->DrawDebugData();
	else {
		std::cout << "Box2d world is NULL, please check that you initialized it" << std::endl;
		assert(world != NULL);
	}

	std::vector<Gbox*>::iterator it;
	
	for(it = boxes.begin(); it < boxes.end(); ++it)
	{
		(*it)->img->renderAtPoint(CGPointMake((*it)->x, (*it)->y), true);
	}
	
	// restore default GL states
	glDisableClientState(GL_VERTEX_ARRAY);	
	glDisable(GL_BLEND);
	
	glPopMatrix();
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

//This is a debug update method designed to update Gbox
void GandoBox2D::debugUpdate(float delta)
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
#pragma mark cleanup
GandoBox2D::~GandoBox2D()
{
	if(debugDraw != NULL)
		delete debugDraw;
	
	if(world != NULL)
		delete world;
	
	if(contactListener != NULL)
		delete contactListener;
}