/*
 *  CompBehaviour.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _COMP_BEHAVIOUR_H_
#define _COMP_BEHAVIOUR_H_

#include "GEComponent.h"
#include "BehaviourStates.h"
#include "BehaviourActions.h"

class CompBehaviour: public GEComponent
{
	//GecComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//CompBehaviour Interface
public:
	std::string const getState() { return state; }
	void setState(const std::string &in_state) { state = in_state; }
	
protected:
	std::string state;
	
private:
	static gec_id_type mFamilyID;
};

#endif