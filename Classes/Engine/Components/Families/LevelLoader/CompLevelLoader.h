/*
 *  CompLevelLoader.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/16/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _COMP_LEVEL_LOADER_
#define _COMP_LEVEL_LOADER_

#include "GEComponent.h"

class CompLevelLoader: public GEComponent
{
	//GecComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Public interface
public:
	virtual void loadLevel(const std::string &fileName) = 0;
	
private:
	static gec_id_type mFamilyID;
};

#endif
