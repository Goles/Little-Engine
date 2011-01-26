/*
 *  gecBoxCollision.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "gecBoxCollision.h"
#include "GandoBox2D.h"
#include "GameEntity.h"

std::string gecBoxCollision::mGECTypeID = "gecBoxCollision";

gecBoxCollision::gecBoxCollision() : m_size(CGSizeZero)
{
}

#pragma mark -
#pragma mark CompCollision Interface
void gecBoxCollision::setTransform(b2Body * const b)
{
	//We only apply transformations over our own body.
	if (b == entityBody)
	{
		GameEntity* ge = this->getOwnerGE();		
		b2Vec2 b2Position = b2Vec2(ge->x/PTM_RATIO, ge->y/PTM_RATIO);
		float32 b2Angle = 0.0f;		
		b->SetTransform(b2Position, b2Angle);
	}
}

void gecBoxCollision::setSize(CGSize in_size)
{
	m_size.width = in_size.width/PTM_RATIO;
	m_size.height = in_size.height/PTM_RATIO;
}


#pragma mark -
#pragma mark GEComponent Interface
void gecBoxCollision::update(float delta)
{
	/* Perform the updates for this entity here. */
}

//Override setOwnerGE to automaically assign a boxCollisionShape to the 
//GameEntity in question.
void gecBoxCollision::createB2dBodyDef(void)
{
	//Define our Box2d body
	b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_dynamicBody;
    spriteBodyDef.position.Set(0.0f, 0.0f);
	spriteBodyDef.bullet = true;
    spriteBodyDef.userData = this;
   
	entityBody = GBOX_2D_WORLD->CreateBody(&spriteBodyDef);
	entityBody->SetLinearVelocity(b2Vec2(0.0f, 0.0f));
	//Define our Box2d Shape
    b2PolygonShape entityShape;
    entityShape.SetAsBox((m_size.width)*0.4f, (m_size.height)*0.4f);
    
	//Make our fixture definition.
	b2FixtureDef entityShapeDef;
    entityShapeDef.shape = &entityShape;
    entityShapeDef.density = 10.0f;
    entityShapeDef.isSensor = true;

	//Finally asociate the spriteShapeDef to our entityBody.
	entityBody->CreateFixture(&entityShapeDef);
}
