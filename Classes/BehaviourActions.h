/*
 *  EntityActions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/13/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _BEHAVIOUR_ACTIONS_H_
#define _BEHAVIOUR_ACTIONS_H_

typedef enum
{
	kBehaviourAction_none = 0,
	kBehaviourAction_doAttack,
	kBehaviourAction_stopAttack,	
	kBehaviourAction_dragGamepad,
	kBehaviourAction_stopGamepad,
} kBehaviourAction;

#endif