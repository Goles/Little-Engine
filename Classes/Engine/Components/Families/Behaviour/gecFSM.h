/*
 *  gecFSM.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _GEC_FSM_H_
#define _GEC_FSM_H_

#include "CompBehaviour.h"

class gecFSM : public CompBehaviour 
{
	//GEComponent Interface
public:
	virtual const gec_id_type&	componentID() const { return mComponentID; }
	virtual void update(float delta);
	
public:
	gecFSM() : locked(false){}
	void performAction(const std::string &action);
	
private:
	static gec_id_type mComponentID;
	bool locked; //This will lock the state machine in the case we need to.
	
};

#endif 