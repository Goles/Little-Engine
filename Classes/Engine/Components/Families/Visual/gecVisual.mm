//
//  gecVisual.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "gecVisual.h"

std::string gecVisual::m_id = "CompVisual";

gecVisual::gecVisual() : m_dirtyTransform(false), m_dirtyColor(false) 
{
    m_color[0] = 1.0f;
    m_color[1] = 1.0f;
    m_color[2] = 1.0f;
    m_color[3] = 1.0f;
}

void gecVisual::setTransform(const mat4f_t &transform)
{
    m_transform[0] = transform[0];
    m_transform[1] = transform[1];
    m_transform[2] = transform[2];
    m_transform[3] = transform[3];
    m_transform[4] = transform[4];
    m_transform[5] = transform[5];
    m_transform[6] = transform[6];
    m_transform[7] = transform[7];
    m_transform[8] = transform[8];
    m_transform[9] = transform[9];
    m_transform[10] = transform[10];
    m_transform[11] = transform[11];
    m_transform[12] = transform[12];
    m_transform[13] = transform[13];
    m_transform[14] = transform[14];
    m_transform[15] = transform[15];
    
    m_dirtyTransform = true;
}

void gecVisual::setColor(float R, float G, float B, float A)
{
    m_color[0] = R;
    m_color[1] = G;
    m_color[2] = B;
    m_color[3] = A;
    
    m_dirtyColor = true;
}

void gecVisual::setAlpha(float alpha) 
{ 
    m_color[3] = alpha;
    m_dirtyColor = true;
}