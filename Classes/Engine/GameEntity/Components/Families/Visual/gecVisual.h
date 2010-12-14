//
//  gecVisual.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef _GECVISUAL_H_
#define _GECVISUAL_H_

#include "GEComponent.h"

class gecVisual: public GEComponent
{
	//GEComponent Interface
public:
	virtual const gec_id_type& familyID() const { return mFamilyID; }	

	//gecVisual Interface
public:
	virtual void render() const = 0;
	
private:
	static gec_id_type mFamilyID;
};

#endif