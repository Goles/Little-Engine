//
//  MoveToAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/5/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __MOVE_TO_ACTION_H__
#define __MOVE_TO_ACTION_H__

#include "FiniteTimeAction.h"
#include "ConstantsAndMacros.h"

namespace gg { namespace action {
  
class MoveToAction : public FiniteTimeAction
{
public:
    MoveToAction();
    virtual void afterUpdate(float dt);
    virtual void started();
    void setEndPoint(const GGPoint &endPoint);
    
private:
    GGPoint m_startPoint;
    GGPoint m_endPoint;
    GGPoint m_delta;
};
    
}}

#endif