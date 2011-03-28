//
//  Action.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "Action.h"

bool Action::isDone()
{
    return true;
}

void Action::startWithTarget(GameEntity *target)
{
    m_target = target;
}

void Action::stop()
{
    m_target = NULL;
}