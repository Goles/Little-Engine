//
//  ActionManager.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ActionManager.h"
#include "IAction.h"
#include "GameEntity.h"

gg::action::ActionManager* gg::action::ActionManager::m_instance = NULL;

namespace gg { namespace action {
    
void ActionManager::update(float delta)
{
    ActionMap::iterator it;
    
    for(it = actions.begin(); it != actions.end(); ++it)
    {
        //Update single action.
        ActionVector::iterator action = it->second->begin();            
        (*action)->update(delta);
    }
}

void ActionManager::addAction(IAction *action)
{
    const GameEntity *target = action->target();
    
    ActionMap::iterator it = actions.find(target->getId());
    
    if(it != actions.end())
    {
        it->second->push_back(action);
    }else{
        ActionVector *newAction = new ActionVector;

         
        newAction->push_back(action);
        std::pair<unsigned, ActionVector *> pair(target->getId(), newAction);
        actions.insert(pair);
    }
}

}}

