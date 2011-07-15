//
//  MoveByAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 7/15/11 at 2:30 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#ifndef __MoveByAction_H__
#define __MoveByAction_H__

#include "FiniteTimeAction.h"
#include "ConstantsAndMacros.h"

namespace gg { namespace action {

class MoveByAction: public FiniteTimeAction {
public:
    MoveByAction();
    virtual ~MoveByAction() {}
    virtual void afterUpdate(float dt);
    virtual void started();    
    inline void setMovementOffset(const GGPoint offset) {
        m_movementOffset = offset;
    }
    
private:
    GGPoint m_startPoint;
    GGPoint m_endPoint;
    GGPoint m_delta;
    GGPoint m_movementOffset;
};

}} // END gg::action
#endif