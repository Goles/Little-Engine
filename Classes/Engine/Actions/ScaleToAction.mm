//
//  ScaleToAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/14/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ScaleToAction.h"
#include "ConstantsAndMacros.h"
#include "gecVisual.h"

namespace gg { namespace action {
  
//void ScaleToAction::afterUpdate(float dt)
//{
//    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
//    
//    if(visual)
//        visual->setTransform();
//}
//    
void ScaleToAction::started()
{
    gecVisual *visualp = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
    
    if(visualp)
    {
        float startScaleX = visualp->getScale().x;        
        float startScaleY = visualp->getScale().y;
        
        mat4f_t *m = new mat4f_t;
        CGAffineToGL(CGAffineTransformMakeScale(startScaleX, startScaleY), m); 
    }

}

}}