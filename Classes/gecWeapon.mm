/*
 *  gecWeapon.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecWeapon.h"

std::string gecWeapon::mGECTypeID = "gecWeapon";

#pragma mark -
#pragma mark GEComponent Interface
void gecWeapon::update(float delta)
{
	/* Perform the updates for this entity here. */
}

#pragma mark -
#pragma mark init
void gecWeapon::intialize()
{	
	//Create our weaponBody.
	b2BodyDef spriteBodyDef;
	spriteBodyDef.type = b2_dynamicBody;
	spriteBodyDef.position.Set(ownerGE->x/PTM_RATIO, ownerGE->y/PTM_RATIO);
	spriteBodyDef.bullet = true;
	spriteBodyDef.userData = ownerGE;
	
	weaponBody = GBOX_2D_WORLD->CreateBody(&spriteBodyDef);
	
	//Define our Box2d Shape
    b2PolygonShape entityShape;
    entityShape.SetAsBox(width/PTM_RATIO, height/PTM_RATIO);
    
	//Make our fixture definition.
	b2FixtureDef entityShapeDef;
    entityShapeDef.shape = &entityShape;
    entityShapeDef.density = 10.0f;
    entityShapeDef.isSensor = true;
	
	weaponBody->CreateFixture(&entityShapeDef);
}

#pragma mark -
#pragma mark Comp Weapon Interface
void gecWeapon::attack()
{

}

void gecWeapon::setTransform(b2Body *b)
{
	if(b == weaponBody)
	{
		GameEntity* ge = this->getOwnerGE();		
		b2Vec2 b2Position = b2Vec2((ge->x + 30)/PTM_RATIO, ge->y/PTM_RATIO);
		float32 b2Angle = 0.0f;		
		b->SetTransform(b2Position, b2Angle);
	}
}