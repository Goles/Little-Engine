//
//  MoveByAction.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 7/15/11 at 2:30 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#include "MoveByAction.h"
#include "GameEntity.h"

namespace gg { namespace action {
  
MoveByAction::MoveByAction()
    : m_delta(CGPointZero)
    , m_startPoint(CGPointZero)
    , m_endPoint(CGPointZero)
    , m_movementOffset(CGPointZero)
{
}
    
void MoveByAction::started()
{
    m_startPoint = m_target->getPosition();
    m_endPoint.x = m_startPoint.x + m_movementOffset.x;
    m_endPoint.y = m_startPoint.y + m_movementOffset.y;
    m_delta.x = (m_startPoint.x - m_endPoint.x);
    m_delta.y = (m_startPoint.y - m_endPoint.y); 
}
    
void MoveByAction::afterUpdate(float dt)
{
    m_target->setPosition(m_startPoint.x - (m_delta.x * dt), m_startPoint.y - (m_delta.y * dt));
}

}} //END gg::action