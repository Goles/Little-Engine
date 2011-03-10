//
//  Particle.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/9/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __PARTICLE_H__
#define __PARTICLE_H__

#include "ConstantsAndMacros.h"

namespace gg 
{  
    namespace particle 
    {

        struct Particle 
        {
            GGPoint m_position;
            GGPoint m_speed;    
            float m_life;
            float m_size;
            float m_decay;
            unsigned char rotation;
            bool m_active;
        };
        
        namespace utils 
        {
            inline void update(Particle &in_particle, float delta)
            {
                in_particle.m_position.x += in_particle.m_speed.x * delta;
                in_particle.m_position.y += in_particle.m_speed.y * delta;
                in_particle.m_life -= in_particle.m_decay * delta;                
            }
        }
    }
}

#endif