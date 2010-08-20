/*
 *  CompHealth.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 6/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _CompHealth_H_
#define _CompHealth_H_

#include "GEComponent.h"

class CompHealth: public GEComponent
{
	//CompHealth interface
public:
	virtual void removeHealth(const int health) = 0;
	virtual void addHealth(const int health) = 0;
	
	//GEComponent Interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Shared Atributes
protected:
	int current_health;
	
	//Private Atributes.
private:
	static gec_id_type mFamilyID;
};

#endif