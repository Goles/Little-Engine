/*
 *  gecBehaviour.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GEC_BEHAVIOUR_H_
#define _GEC_BEHAVIOUR_H_

#include "GEComponent.h"
#include "BehaviourStates.h"
#include "BehaviourActions.h"

class gecBehaviour: public GEComponent
{
	//GecComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
protected:
	int state;
	
private:
	static gec_id_type mFamilyID;
};

#endif