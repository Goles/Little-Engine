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
#pragma mark GEComponent Interface
void gecFSM::update(float delta) const
{
	GameEntity *ge = gecBehaviour::GEComponent::getOwnerGE();
	
	/*Switch the entity sprite*/
	gecVisual *visualComp = static_cast<gecVisual *>(ge->getGEC("CompVisual"));
	gecAnimatedSprite *animatedSprite = static_cast<gecAnimatedSprite *> (visualComp);
	
	if(animatedSprite != NULL)
	{
		//This could be even better, instead of "getNameForAction" it could be like
		//get "State" for action, where state is a structure defining all the properties
		//of the animation for a state, like PingPong, etc etc etc.
		animatedSprite->setCurrentAnimation(this->getNameForAction(state));
		animatedSprite->setCurrentRunning(true);
	}	
}

#pragma mark -
#pragma mark public interface
gecFSM::gecFSM()
{
	state	= kBehaviourState_stand;	
}

void gecFSM::setRule(kBehaviourState initialState, 
					 int inputAction, 
					 kBehaviourState resultingState, 
					 const std::string &resultingStateName)
{
	fsmTable[initialState][inputAction] = resultingState;
	actionNameMap.insert(actionMapPair(resultingState, resultingStateName));
}

void gecFSM::performAction(kBehaviourAction action)
{
	kBehaviourState resultingState = fsmTable[state][action];
	state = resultingState;
}

#pragma mark -
#pragma mark protected interface
const std::string gecFSM::getNameForAction(kBehaviourState action) const
{	
	actionMap::const_iterator it;
	it = actionNameMap.find(action);
	
	if(it != actionNameMap.end())
		return it->second;
	
	return "";
}