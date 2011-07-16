//
//  Action.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ACTION_H__
#define __ACTION_H__

#include "IAction.h"

class GameEntity;

namespace gg { namespace action {

class Action: public IAction
{
    
public:
    Action();
    virtual ~Action() {}
    virtual bool isDone();
    virtual void setTarget(GameEntity *target);
    virtual void setRepeatTimes(unsigned times);
    virtual void stop();
    virtual unsigned targetId();
    const unsigned id() const { return m_id; }
    virtual void afterSetTarget();
    virtual bool ended();
    
protected:
    GameEntity* m_target;    
    unsigned m_id;
    unsigned m_repeatTimes;
};

}} //END gg::action

#endif