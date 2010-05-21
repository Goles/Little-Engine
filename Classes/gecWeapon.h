/*
 *  gecWeapon.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _gecWeapon_H_
#define _gecWeapon_H_

#include "CompWeapon.h"
#include "GandoBox2D.h"
#include "GameEntity.h"

class gecWeapon: public CompWeapon
{
	//gecWeapon interface
public:
	gecWeapon(GameEntity *gE, float _width, float _height) : 
				subscribedGE(gE), 
				width(_width),
				height(_height)
				{	
					tag = new std::string("weapon"); 
					active = false; 
					ownerGE = subscribedGE; 
					this->intialize(); 
				}
	void attack();

	//CompWeapon Interface
public:
	virtual void setTransform(b2Body *b);
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);
	
	//Private Atributes.
private:
	void intialize();
	
	static gec_id_type mGECTypeID;
	b2Body* weaponBody;
	GameEntity* subscribedGE;
	float width, height;
};

#endif