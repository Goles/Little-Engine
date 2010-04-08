/*
 *  gecFSM.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GEC_FSM_H_
#define _GEC_FSM_H_

#define MAX_STATES 8
#define MAX_ACTION 8

#include "gecBehaviour.h"

class gecFSM : public gecBehaviour 
{
	//GEComponent Interface
public:
	virtual const gec_id_type&	componentID() const { return mComponentID; }
	virtual void update(float delta) const {}
	
public:
	//Constructors
	gecFSM() { state = kEntityState_walk; }
	gecFSM(kEntityState s) { state = s; }
	
	//Interface
	void setRule(kEntityState initialState, int inputAction, kEntityState resultingState);
	void performAction(int action);
	
private:
	kEntityState fsmTable[MAX_STATES][MAX_ACTION];
	static gec_id_type mComponentID;
	
};

#endif 