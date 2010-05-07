/*
 *  gecBoxCollision.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecBoxCollision.h"
#include "GandoBox2D.h"

std::string gecBoxCollision::mGECTypeID = "gecBoxCollision";

#pragma mark -
#pragma mark GEComponent Interface
void gecBoxCollision::update(float delta)
{
	/* Perform the updates for this entity here. */
}

//Override setOwnerGE to automaically assign a boxCollisionShape to the GameEntity
//in question.
void gecBoxCollision::setOwnerGE(GameEntity *ge)
{
	if(ge == NULL)
	{
		std::cout << "ERROR: Specified OwnerGameEntity can't be NULL" << std::endl;
		assert(ge != NULL);
	}
	
	//Define our Box2d body
	b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_dynamicBody;
    spriteBodyDef.position.Set(ge->x/PTM_RATIO, ge->y/PTM_RATIO);
    spriteBodyDef.userData = ge;
   
	entityBody = GBOX_2D_WORLD->CreateBody(&spriteBodyDef);
	
	//Define our Box2d Shape
    b2PolygonShape entityShape;
    entityShape.SetAsBox((ge->width/PTM_RATIO)*0.5f, (ge->height/PTM_RATIO)*0.5f);
    
	//Make our fixture definition.
	b2FixtureDef entityShapeDef;
    entityShapeDef.shape = &entityShape;
    entityShapeDef.density = 10.0;
    entityShapeDef.isSensor = true;
    
	//Finally asociate the spriteShapeDef to our entityBody.
	entityBody->CreateFixture(&entityShapeDef);
}