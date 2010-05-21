/*
 *  CompWeapon.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

/*
 *  This Component should be used only for the prototype version. In the definitive
 *  version, this should be done with an Specific GameEntity anidated to another
 *  GameEntity (the owner of the weapon).
 *
 *  After the prototype is developed, this should be deprecated.
 */

#ifndef _CompWeapon_H_
#define _CompWeapon_H_

#include <string>

#include "GEComponent.h"
#include "Box2D.h"

class CompWeapon: public GEComponent
{
	//CompWeapon interface
public:
	virtual void attack() = 0;
	virtual void setTransform(b2Body *b) = 0;
	void setActive(bool b) { active = b; }
	const bool getActive() { return active; }
	
	//Shared atributes & Methods
protected:
	bool active;
	std::string *tag; //Tags this as a weapon
	
	//GEComponent Interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Private Atributes.
private:
	static gec_id_type mFamilyID;
};

#endif