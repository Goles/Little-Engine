/*
 *  GandoBox2D.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/4/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "GandoBox2D.h"
#include "GandoBox2DDebug.h"
#include "CompCollisionable.h"
#include "GLES-Render.h"
#include "EventBroadcaster.h"
#include "GameEntity.h"
#include "ConstantsAndMacros.h"
#include "EventBroadcaster.h"

GandoBox2D* GandoBox2D::instance = NULL;

GandoBox2D::GandoBox2D() 
    : world(NULL)
    , contactListener(NULL)
    , debugDraw(NULL)
    , m_broadcaster(NULL)
{
	this->initBaseWorld();
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

void GandoBox2D::update(const float delta)
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 1;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(delta, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world and apply transformations
	//To keep in Sync with our Entity World
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		CompCollisionable *ccp = static_cast<CompCollisionable *>(b->GetUserData());
		
		if (ccp != NULL) 
		{
			//Synchronize the Sprites position and rotation with the corresponding body
			ccp->setTransform(b);
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
		b2Body *b2body_p1 = contact.fixtureA->GetBody();
		b2Body *b2body_p2 = contact.fixtureB->GetBody();
		
		//Obtain user data (pointers to CompCollisionable in ggengine)
		CompCollisionable *ccp1 = static_cast<CompCollisionable *>(b2body_p1->GetUserData());
		CompCollisionable *ccp2 = static_cast<CompCollisionable *>(b2body_p2->GetUserData());
		
		//OwnerGE's
		GameEntity *gep1 = ccp1->getOwnerGE();
		GameEntity *gep2 = ccp2->getOwnerGE();
		
		//If the entities are active, if they are not, we wont detect collision
		if(gep1->isActive && gep2->isActive)
		{	
			//If we have two different bodies colliding
			if (ccp1->getOwnerGE() != ccp2->getOwnerGE())
			{				
				//If the collisioners are solid then apply "solid" collision correction.
				if(ccp1->getSolid() && ccp2->getSolid())
				{
                    GGPoint pos = ccp2->getOwnerGE()->getPosition();
                    
                    ccp2->getOwnerGE()->setPositionX(pos.x - 2.0f * (b2body_p1->GetPosition().x - b2body_p2->GetPosition().x));
                    ccp2->getOwnerGE()->setPositionY(pos.y - 2.0f * (b2body_p1->GetPosition().y - b2body_p2->GetPosition().y));
				}
				
                this->notifyCollisionEntity(ccp1->getOwnerGE());
				this->notifyCollisionEntity(ccp2->getOwnerGE());
                
                //Deactivate the non-solids to avoid multi-collision
                if(it == (contacts->end() - 1))
                {
                    if(!ccp1->getSolid())
                        gep1->isActive = false;
                    
                    if(!ccp2->getSolid())
                        gep2->isActive = false;
                }  
			}
		}
	}	
}

void GandoBox2D::notifyCollisionEntity(const GameEntity * const targetEntity)
{
	//TODO:Add payload data of the collisioned entity.
    m_broadcaster->notifyTargetEntity("E_COLLISION", luabind::newtable(LR_MANAGER_STATE), targetEntity->getId());
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
	if(debugDraw)
		delete debugDraw;
	
	if(world)
		delete world;
	
	if(contactListener)
		delete contactListener;	
}