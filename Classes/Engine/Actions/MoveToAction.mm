//
//  MoveToAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/5/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "MoveToAction.h"
#include "GameEntity.h"
#include <iostream>

namespace gg { namespace action {

MoveToAction::MoveToAction() : m_startPoint(CGPointZero), 
                               m_endPoint(CGPointZero), 
                               m_delta(CGPointZero)
{
    //Constructor.
}

void MoveToAction::startWithTarget(GameEntity *e)
{
    Action::m_target = e;
    m_startPoint = e->getPosition();
    m_delta.x = (m_startPoint.x - m_endPoint.x);
    m_delta.y = (m_startPoint.y - m_endPoint.y);
}

void MoveToAction::refresh(float dt)
{
    float x = m_delta.x;
    float y = m_delta.y;
    
    m_target->setPosition(m_startPoint.x - (m_delta.x * dt), m_startPoint.y - (m_delta.y * dt));
}

void MoveToAction::setEndPoint(const GGPoint &endPoint)
{
    m_endPoint = endPoint;
}   
    
}}