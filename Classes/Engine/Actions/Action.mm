//
//  Action.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "Action.h"
#include "GameEntity.h"

namespace gg { namespace action {
    
Action::Action() : m_target(NULL), m_id(UINT_MAX) 
{
    
}
    
bool Action::isDone()
{
    return true;
}

void Action::setTarget(GameEntity *target)
{
    static int incremental_id = 0;
    
    m_id = incremental_id;
    m_target = target;
    
    ++incremental_id;
    
    afterSetTarget();
}

unsigned Action::targetId()
{
#ifdef DEBUG
    assert(m_target != NULL);
#endif
    return m_target->getId();
}    
    
void Action::afterSetTarget()
{
    //Init Stuff here ( optional 
}

void Action::stop()
{
    m_target = NULL;
}

}}