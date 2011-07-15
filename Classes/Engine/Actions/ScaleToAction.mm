//
//  ScaleToAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/14/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ScaleToAction.h"
#include "gecVisual.h"
#include "GameEntity.h"

namespace gg { namespace action {

ScaleToAction::ScaleToAction() : m_startScale(CGPointMake(1.0f, 1.0f)), m_deltaScale(CGPointZero), m_endScale(CGPointZero)
{
}

void ScaleToAction::setEndScale(const GGPoint &scale)
{
    m_endScale.x = scale.x;
    m_endScale.y = scale.y;
}
    
void ScaleToAction::started()
{
    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
    
    if (visual) {
        m_startScale = visual->scale();
        m_deltaScale.x = m_endScale.x - m_startScale.x;
        m_deltaScale.y = m_endScale.y - m_startScale.y;
    }
}
    
void ScaleToAction::afterUpdate(float dt)
{
    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
    
    if (visual)
        visual->setScale(CGPointMake (m_startScale.x + (m_deltaScale.x * dt), m_startScale.y + (m_deltaScale.y * dt)));
}

}} //END gg::action