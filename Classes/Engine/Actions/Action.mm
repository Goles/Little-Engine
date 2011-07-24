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
    
Action::Action() 
    : m_target(NULL)
    , m_id(UINT_MAX)
    , m_repeatTimes(0)
{
    static int incremental_id = 0;
    m_id = incremental_id;
    ++incremental_id;
}

void Action::setTarget(GameEntity *target)
{
    m_target = target;
    afterSetTarget();
}

void Action::afterSetTarget()
{
    //Overload if needed.
}
    
unsigned Action::targetId()
{
#ifdef DEBUG
    assert(m_target != NULL);
#endif
    return m_target->getId();
}

bool Action::isDone()
{
    return true;
}
    
bool Action::ended()
{
    if (m_repeatTimes > 0) {
        --m_repeatTimes;
        return false;
    }
    
    return true;
}    
    
void Action::stop()
{
    m_target = NULL;
}

}} //END gg::action