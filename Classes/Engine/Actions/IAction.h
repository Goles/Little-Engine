//
//  IAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __I_ACTION__
#define __I_ACTION__

class GameEntity;

namespace gg { namespace action {

class IAction
{
public:
    virtual ~IAction() {}
    virtual bool isDone() = 0;
    virtual void stop() = 0;
    virtual unsigned targetId() = 0;    
    virtual void setTarget(GameEntity *target) = 0; 
    virtual void update(float delta) = 0;
    virtual void afterUpdate(float time) = 0;
    
    //Optional
    virtual void afterSetTarget() {}
    virtual void started() {}
    virtual bool ended() { return true; }
};

}} //END gg::action
#endif