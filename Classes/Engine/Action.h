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
    
    virtual ~Action();
    bool isDone();
    void startWithTarget(unsigned target);    
    void stop();
    virtual void update(float delta) = 0;
    virtual void refresh(float time) = 0;
    
private:
    GameEntity* m_target;
    
};

#endif