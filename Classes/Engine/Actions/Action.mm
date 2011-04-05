//
//  Action.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "Action.h"

namespace gg { namespace action {

bool Action::isDone()
{
    return true;
}

void Action::startWithTarget(GameEntity *target)
{
    static int incremental_id = 0;
    
    m_id = incremental_id;
    m_target = target;
    
    ++incremental_id;
}

void Action::stop()
{
    m_target = NULL;
}

}}