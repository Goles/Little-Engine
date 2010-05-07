/*
 *  gecBoxCollision.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _gecBoxCollision_H_
#define _gecBoxCollision_H_

#include "CompCollision.h"

class gecBoxCollision: public CompCollision
{
	//gecBoxCollision interface
public:
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);
	void setOwnerGE(GameEntity *gE); 
	
	//Private Atributes.
private:
	static gec_id_type mGECTypeID;
	
};

#endif