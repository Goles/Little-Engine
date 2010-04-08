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

public:
	//Constructors
	gecFSM() { state = kEntityState_walk; }
	gecFSM(kEntityState s) { state = s; }
	
private:
	kEntityState fsmTabe[MAX_STATES][MAX_ACTION];
	
};

#endif 