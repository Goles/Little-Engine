/*
 *  gecFSM.cpp
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/4/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "gecFSM.h"
#include "GameEntity.h"
#include "gecAnimatedSprite.h"
#include "LuaManager.h"

std::string gecFSM::mComponentID = "gecFSM";

//Interface
#pragma mark -
#pragma mark GEComponent Interface
void gecFSM::update(float delta)
{	
}

void gecFSM::performAction(const std::string &action)
{
    //TODO: Fix this
//	luabind::call_function<void>(LR_MANAGER_STATE, "targetPerformAction", action.c_str(), this->getOwnerGE()->getId());
}