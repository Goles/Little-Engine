//
//  FadeInAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "FadeInAction.h"
#include "GameEntity.h"
#include "gecVisual.h"

void FadeInAction::refresh(float dt)
{
    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));

    if(visual)
        visual->setAlpha(255 * dt);
}
