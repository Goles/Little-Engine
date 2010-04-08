/*
 *  EntityStates.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _ENTITY_STATE_H_
#define _ENTITY_STATE_H_

typedef enum
{
	kEntityState_stand = 0,
	kEntityState_walk,
	kEntityState_attack,
	kEntityState_hit,
	kEntityState_die,
	kEntityState_num, //used for the total number of states.
} kEntityState;

#endif