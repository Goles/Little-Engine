//
//  ActionManager.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ActionManager.h"
#include "Action.h"
#include "GameEntity.h"
#include <iostream>

gg::action::ActionManager* gg::action::ActionManager::m_instance = NULL;

namespace gg { namespace action {
    
void ActionManager::update(float delta)
{
    ActionMap::iterator it;
    
    for (it = actions.begin(); it != actions.end(); ++it)
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
    
    if (it != actions.end())
    {
        it->second->push_back(action);
    }else {
        ActionVector *newAction = new ActionVector;
       
        newAction->push_back(action);
        
        std::pair<unsigned, ActionVector *> pair(target->getId(), newAction);        
        actions.insert(pair);
    }
}
    
void ActionManager::removeAction(IAction *action)
{
    ActionMap::iterator entityActions = actions.find(action->target()->getId());
    
    ActionVector::iterator it;
        
    //Note: I didn't use std::find because performance was nearly the same/the same as 
    //sequential search over unsorted std::vector. Maybe it would be a good idea to sort
    //the actions vector in order to use a binary_search by id().
    for (it = entityActions->second->begin(); it != entityActions->second->end(); ++it) 
    {
        if (static_cast<Action *>(*it)->id() == static_cast<Action *>(action)->id()) 
        {
            std::cout << "Action Removed" << std::endl;
            entityActions->second->erase(it);
            return;
        }
    }
}

}}

