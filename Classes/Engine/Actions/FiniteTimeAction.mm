//
//  FiniteTimeAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "FiniteTimeAction.h"
#include "ActionManager.h"

namespace gg { namespace action {

void FiniteTimeAction::update(float delta)
{
    if(m_firstTick)
    {
        m_firstTick = false;
        m_elapsed = 0.0f;        
    }
    
    m_elapsed += delta;
    
    this->refresh(MIN(1, m_elapsed/m_duration));
    
    //Remove
    if (this->isDone())
        ACTION_MANAGER->removeAction(this);
}

}}