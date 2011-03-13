//
//  ParticleSystem.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 3/9/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "ParticleManager.h"
#include <iostream>
gg::particle::ParticleManager* gg::particle::ParticleManager::m_instance = NULL;

namespace gg { namespace particle {
        
    ParticleManager* ParticleManager::getInstance()
    {
        if(m_instance == NULL)
            m_instance = new ParticleManager();

        return m_instance;
    }
    
    void ParticleManager::setMaxParticles(int max)
    {
        m_maxParticles = max;
        m_pool = new ParticlePool(m_maxParticles);        
    }
}}





