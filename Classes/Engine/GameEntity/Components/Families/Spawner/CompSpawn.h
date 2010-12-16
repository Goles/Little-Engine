/*
 *  CompSpawn.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/15/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _COMP_SPAWN_H_
#define _COMP_SPAWN_H_

#include "GEComponent.h"

class CompSpawn: public GEComponent
{
	//GecComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
private:
	static gec_id_type mFamilyID;
};

#endif