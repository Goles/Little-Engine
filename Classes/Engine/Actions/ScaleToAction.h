//
//  ScaleToAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/14/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __SCALE_TO_ACTION_H__
#define __SCALE_TO_ACTION_H__

#include "FiniteTimeAction.h"
#include "ConstantsAndMacros.h"

namespace gg { namespace action {

class ScaleToAction : public FiniteTimeAction 
{
public:
    ScaleToAction();
    virtual ~ScaleToAction() {}
    virtual void afterUpdate(float dt);    
    virtual void started();
    void setEndScale(const GGPoint &endScale);
    
private:
    GGPoint m_startScale;
    GGPoint m_deltaScale;
    GGPoint m_endScale;
};

}} //END gg::action
    
#endif