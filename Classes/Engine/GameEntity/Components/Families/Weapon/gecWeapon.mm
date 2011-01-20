/*
 *  gecWeapon.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "gecWeapon.h"

std::string gecWeapon::mGECTypeID = "gecWeapon";

#pragma mark -
#pragma mark GEComponent Interface
void gecWeapon::update(float delta)
{
	int state = this->checkOwnerState(kBehaviourState_attack);
	
	if(state)
		this->setActive(true);
	else if(state == 0){
		this->setActive(false);
	}
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
	spriteBodyDef.userData = this;
	
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
	int offset = 0;
	(!ownerGE->getFlipHorizontally()) ? offset = 30 : offset = -30;

	GameEntity* ge = this->getOwnerGE();		
	b2Vec2 b2Position = b2Vec2((ge->x + offset)/PTM_RATIO, ge->y/PTM_RATIO);
	b->SetTransform(b2Position, 0.0f);
}

#pragma mark -
#pragma mark gecWeapon private interface.
int gecWeapon::checkOwnerState(kBehaviourState state) const
{
//	GEComponent *gec = this->getOwnerGE()->getGEC("CompBehaviour");
//	if(gec)
//	{
//		//if the component is indeed an FSM
//		if(gec->componentID().compare("gecFSM") == 0)
//		{
//			gecFSM *gec_fsm = (gecFSM *)gec;
//			
//			if(gec_fsm->getState() == state)
//				//Code 1 means that the owner's gecFSM has owner.state == state
//				return 1;
//			else {
//				//Code 0 means that the owner's gecFSM has owner.state != state
//				return 0;
//			}
//		}else {
//			//Code -1 means that the owner's CompBehaviour is not gecFSM
//			return -1;
//		}
//	}
//	
//	//Code -2 means that the owner doesn't even have a CompBehaviour.
//	return -2;
	
	assert(false);
}
