/*
 *  CompCollision.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _CompCollision_H_
#define _CompCollision_H_

#include "Box2D.h"
#include "GEComponent.h"

class CompCollision: public GEComponent
{
	//CompCollision interface
public:
	CompCollision();
	~CompCollision();
	
	//GEComponent Interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Shared atributes
protected:
	b2Body* entityBody;
	
	//Private Atributes.
private:
	static gec_id_type mFamilyID;

};

#endif