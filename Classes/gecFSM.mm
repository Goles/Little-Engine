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
#include "gecAnimatedSprite.h"

std::string gecFSM::mComponentID = "gecFSM";

/*Interface*/
#pragma mark -
#pragma mark public interface
void gecFSM::setRule(kEntityState initialState, 
					 int inputAction, 
					 kEntityState resultingState, 
					 const std::string &resultingStateName)
{
	fsmTable[initialState][inputAction] = resultingState;
	actionNameMap.insert(actionMapPair(resultingState, resultingStateName));
}

void gecFSM::performAction(int action)
{
	kEntityState resultingState = fsmTable[state][action];	
	GameEntity *ge = gecBehaviour::GEComponent::getOwnerGE();
	
	/*Switch the entity sprite*/
	gecVisual *visualComp = static_cast<gecVisual *>(ge->getGEC("CompVisual"));
	gecAnimatedSprite *animatedSprite = static_cast<gecAnimatedSprite *> (visualComp);
	
	if(animatedSprite != NULL)
		animatedSprite->setCurrentAnimation(this->getNameForAction(resultingState));
}

#pragma mark -
#pragma mark protected interface
const std::string& gecFSM::getNameForAction(kEntityState action)
{	
	actionMap::iterator it;
	it = actionNameMap.find(action);
	
	if(it != actionNameMap.end())
	{
		std::cout << it->second << std::endl;
	}
	
	return NULL;
}

