//
//  gecInput.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "GEComponent.h"

class gecInput: public GEComponent
{
	//GEComponent Interface
public:
	virtual const gec_id_type& familyID() const { return mFamilyID; }
	
	//gecInput Interface
public:
	virtual void touchesBegan(float x, float y) = 0;
	virtual void touchesMoved(float x, float y) = 0;	
	virtual void touchesEnded(float x, float y) = 0;
	
	//Visual Family Atributes
private:
	static gec_id_type mFamilyID;

};