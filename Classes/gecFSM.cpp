/*
 *  gecFSM.cpp
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecFSM.h"
#include "GameEntity.h"

std::string gecFSM::mComponentID = "gecFSM";

/*Interface*/
void gecFSM::setRule(kEntityState initialState, int inputAction, kEntityState resultingState)
{
	fsmTable[initialState][inputAction] = resultingState;
}

void gecFSM::performAction(int action)
{
	GameEntity *ge = gecBehaviour::GEComponent::getOwnerGE();
	ge->debugPrintComponents();
}
