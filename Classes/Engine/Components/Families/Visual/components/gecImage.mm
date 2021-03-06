//
//  gecImage.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 7/13/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "gecImage.h"

#include "GameEntity.h"
#include "Image.h"

const std::string gecImage::m_componentID = "gecImage";

void gecImage::render() const
{
    glPushMatrix();
    
    //Apply Anchor Point translate
    glTranslatef(-m_anchor.x * m_image->getImageWidth() * m_image->getScale().x, 
                 -m_anchor.y * m_image->getImageHeight() * m_image->getScale().y, 
                 0.0);
    
    if (gecVisual::m_dirtyScale) {
        m_image->setScaleX(m_scale.x);
        m_image->setScaleY(m_scale.y);
    }
    
    if (gecVisual::m_dirtyTransform)
        glMultMatrixf(m_transform);
    
    if (gecVisual::m_dirtyColor) {
        m_image->setColorFilter(m_color[0], m_color[1], m_color[2], m_color[3]);
    }
    
    m_image->renderAtPoint(m_position, false);
    
    glPopMatrix();
}

void gecImage::update(float delta)
{
    GameEntity *ge = this->getOwnerGE();
    m_position = ge->getPosition();
}

gecImage::~gecImage()
{
    delete m_image;
}