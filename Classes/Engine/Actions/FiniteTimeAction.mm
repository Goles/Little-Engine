//
//  FiniteTimeAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "FiniteTimeAction.h"

namespace gg { namespace action {

void FiniteTimeAction::update(float delta)
{
    if (m_firstTick) {
        started();
        m_firstTick = false;
        m_elapsed = 0.0f;        
    }
    
    m_elapsed += delta;    
    this->afterUpdate(MIN(1, m_elapsed/m_duration));
}

}} //END gg::action