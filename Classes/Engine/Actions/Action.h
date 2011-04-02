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

class Action: public IAction
{

public:
    virtual bool isDone();
    virtual void startWithTarget(GameEntity *target);    
    virtual void stop();
    
protected:
    GameEntity* m_target;

};

#endif