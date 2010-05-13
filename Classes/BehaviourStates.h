/*
 *  EntityStates.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _BEHAVIOUR_STATE_H_
#define _BEHAVIOUR_STATE_H_

typedef enum
{
	kBehaviourState_null = -1,
	kBehaviourState_stand,
	kBehaviourState_walk,
	kBehaviourState_attack,
	kBehaviourState_hit,
	kBehaviourState_die,
	kBehaviourState_num, //used for the total number of states.
} kBehaviourState;

#endif