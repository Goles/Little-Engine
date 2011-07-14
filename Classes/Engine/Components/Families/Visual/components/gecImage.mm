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

void gecImage::render() const
{
    m_image->renderAtPoint(m_position, false);
}

void gecImage::update()
{
    GameEntity *ge = this->getOwnerGE();
    m_position = ge->getPosition();
}

gecImage::~gecImage()
{
    delete m_image;
}