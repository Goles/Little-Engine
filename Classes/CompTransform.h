/*
 *  CompTransform.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

/*
 *  The transform family contains components that allow the entity to adapt it's
 *  position, movement, rotation, according to other parameters. Provides a 
 *  "common" interface for it to use.
 *
 */
 

#ifndef _CompTransform_H_
#define _CompTransform_H_

#include "GEComponent.h"

class CompTransform: public GEComponent
{
	//CompTransform interface
public:
	/* Add specific methods for CompTransform here */
	
	//GEComponent Interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Private Atributes.
private:
	static gec_id_type mFamilyID;
	
};

#endif