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
#include <algorithm>
#include <vector>

gg::action::ActionManager* gg::action::ActionManager::m_instance = NULL;

namespace gg { namespace action {
    
void ActionManager::update(float delta)
{
    ActionMap::iterator it;
    
    for (it = actions.begin(); it != actions.end(); ++it)
    {
        ActionVector *avp = it->second;
        
        if(!avp->empty())
        {
            (*avp->begin())->update(delta);
        }
    }
    
    this->cleanup();
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
    cleanupActions.push_back(action);
}
    
void ActionManager::cleanup()
{
    if(cleanupActions.empty())
        return;
    
    ActionVector::iterator actionToErase = cleanupActions.begin();
    
    for(; actionToErase != cleanupActions.end(); ++actionToErase)
    {        
        ActionMap::iterator entityActions = actions.find((*actionToErase)->target()->getId());
        ActionVector::iterator it = entityActions->second->begin();
        
        //Note: I didn't use std::find because performance was nearly the same/the same as 
        //sequential search over unsorted std::vector. Maybe it would be a good idea to sort
        //the actions vector in order to use a binary_search by id().
        
        int counter = 0;
        
        std::vector<int> deleteIndexes;
        
        for (; it != entityActions->second->end(); ++it) 
        {
            if (static_cast<Action *>(*it)->id() == static_cast<Action *>(*actionToErase)->id()) 
            {
                delete *it;
                deleteIndexes.push_back(counter);
            }
            
            ++counter;
        }
        
        //Can't modify Vector while iterating through it.
        for(int i = 0; i < deleteIndexes.size(); ++i)
        {
            if(deleteIndexes[i] < entityActions->second->size())
            {
                std::swap((*entityActions->second)[deleteIndexes[i]], entityActions->second->back());
                entityActions->second->pop_back();
            }
        }
    }
    
    cleanupActions.clear();
}

}}

