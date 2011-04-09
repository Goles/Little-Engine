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
    virtual ~Action() {}
    Action();
    virtual bool isDone();
    virtual void startWithTarget(GameEntity *target);    
    virtual void stop();
    virtual unsigned getTargetId();
    const unsigned id() const { return m_id; }
    virtual void init();
    
protected:    
    
    GameEntity* m_target;    
    unsigned m_id;
    
};
    
}}
#endif