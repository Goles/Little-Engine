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
    virtual void setTarget(GameEntity *target);    
    virtual void afterSetTarget();
    virtual unsigned targetId();
    virtual bool isDone();
    virtual bool ended();
    virtual void stop();
    inline const unsigned id() const { return m_id; }
    inline const unsigned repeatTimes() { return m_repeatTimes; }
    inline void setRepeatTimes(unsigned times) { m_repeatTimes = times; }
    
protected:
    GameEntity* m_target;    
    unsigned m_id;
    unsigned m_repeatTimes;
};

}} //END gg::action

#endif