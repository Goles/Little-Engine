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

//Interface
#pragma mark -
#pragma mark GEComponent Interface
void gecFSM::update(float delta)
{
	GameEntity *ge = CompBehaviour::GEComponent::getOwnerGE();
	
	/*Switch the entity sprite*/
	gecVisual *visualComp = static_cast<gecVisual *>(ge->getGEC("CompVisual"));
	gecAnimatedSprite *animatedSprite = static_cast<gecAnimatedSprite *> (visualComp);
	
	if(animatedSprite)
	{
		//This could be even better, instead of "getNameForAction" it could be like
		//get "State" for action, where state is a structure defining all the properties
		//of the animation for a state, like PingPong, etc etc etc.
		animatedSprite->setCurrentAnimation(this->getNameForAction(state));
		animatedSprite->setCurrentRunning(true);
	}	
}

#pragma mark -
#pragma mark delegate
void gecFSM::animationFinishedDelegate()
{
	//This could be even better, if we are delegating, the best is to
	//notify the sprite to perform opossite action of what are we doing.
	//So we could actually have a map like Action ^ -Action.
	this->performAction(kBehaviourAction_stopAttack);
}

#pragma mark -
#pragma mark public interface
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
	
	//We check if the resulting state is valid.
	if(this->getNameForAction(resultingState).compare("NO_EXISTING_STATE") > 0)
		state = resultingState;
	else {
		//std::cout << "Warning non-existant state!" << std::endl;
		//assert(this->getNameForAction(resultingState).compare("NO_EXISTING_STATE") > 0);
	}
}

#pragma mark -
#pragma mark protected interface
void gecFSM::initFsmTable()
{
	for(int i = 0; i < MAX_STATES; i++)
		for(int j = 0; j < MAX_ACTION; j++)
			fsmTable[i][j] = kBehaviourState_null;
}

const std::string gecFSM::getNameForAction(kBehaviourState action) const
{	
	actionMap::const_iterator it;
	it = actionNameMap.find(action);
	
	if(it != actionNameMap.end())
		return it->second;
	
	return "NO_EXISTING_STATE";
}
