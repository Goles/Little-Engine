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
#include "FiniteTimeAction.h"
#include "UnisonAction.h"

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

            if((*avp->begin())->isDone())
            {
                this->removeAction((*avp->begin()));
            }
        }
    }
}

void ActionManager::addAction(IAction *action)
{
    unsigned action_id = action->getTargetId();
    
    ActionMap::iterator it = actions.find(action_id);
    
    if (it != actions.end())
    {
        it->second->push_back(action);
    }else {
        ActionVector *newAction = new ActionVector;
       
        newAction->push_back(action);
        
        std::pair<unsigned, ActionVector *> pair(action_id, newAction);        
        actions.insert(pair);
    }
}

void ActionManager::addParallelActions(FiniteTimeAction *action, ...)
{
    va_list ap;
    FiniteTimeAction *p = action;
    va_start (ap, action);
    UnisonAction *unison = new UnisonAction();
    
    while (p != NULL)
    {

        unison->addAction(p);
        

        p = va_arg (ap, FiniteTimeAction *);
    }
    
    this->addAction(unison);
    
    va_end (ap);
}
    
void ActionManager::removeAction(IAction *action)
{
    cleanupActions.push_back(action);
}

unsigned ActionManager::totalActionsNum() const
{
    ActionMap::const_iterator it1 = actions.begin();

    unsigned actionCount = 0;
    
    for(; it1 != actions.end(); ++it1)
    {
        ActionVector::iterator it2 = it1->second->begin();
        
        for(; it2 != it1->second->end(); ++it2)
        {
            ++actionCount;
        }
    }
    
    return actionCount;
}

void ActionManager::cleanup()
{
    if(cleanupActions.empty())
        return;
    
    ActionVector::iterator actionToErase = cleanupActions.begin();
    
    for(; actionToErase != cleanupActions.end(); ++actionToErase)
    {        
        ActionMap::iterator entityActions = actions.find((*actionToErase)->getTargetId());
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

ActionManager::~ActionManager()
{
    m_instance = NULL;
    cleanupActions.clear();
    
    ActionMap::iterator it = actions.begin();
    
    for(; it != actions.end(); ++it)
    {
        ActionVector::iterator action = it->second->begin();
        
        for(; action != it->second->end(); ++action)
        {
            delete *action;
        }
        
        it->second->clear();
    }
    
    actions.clear();
}
    
}}

