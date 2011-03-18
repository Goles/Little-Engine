/*
 *  gecBoxCollisionable.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "gecBoxCollisionable.h"
#include "GandoBox2D.h"
#include "GameEntity.h"

std::string gecBoxCollisionable::mGECTypeID = "gecBoxCollisionable";

gecBoxCollisionable::gecBoxCollisionable() : m_size(CGSizeZero)
{
}

#pragma mark -
#pragma mark CompCollisionable Interface
void gecBoxCollisionable::setTransform(b2Body * const b)
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

void gecBoxCollisionable::setSize(CGSize in_size)
{
	m_size.width = in_size.width/PTM_RATIO;
	m_size.height = in_size.height/PTM_RATIO;
}


#pragma mark -
#pragma mark GEComponent Interface
void gecBoxCollisionable::update(float delta)
{
	/* Perform the updates for this entity here. */
	if(entityBody == NULL)
	{
		this->createB2dBodyDef();
	}
}

//Override setOwnerGE to automaically assign a boxCollisionShape to the 
//GameEntity in question.
void gecBoxCollisionable::createB2dBodyDef(void)
{	
	//Define our Box2d body
	b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_dynamicBody;
    spriteBodyDef.position.Set(this->getOwnerGE()->x, this->getOwnerGE()->y);
	spriteBodyDef.bullet = false;
    spriteBodyDef.userData = this;   
	entityBody = GBOX_2D_WORLD->CreateBody(&spriteBodyDef);

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
