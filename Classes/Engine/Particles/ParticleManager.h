//
//  ParticleSystem.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/9/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __PARTICLE_SYSTEM_H__
#define __PARTICLE_SYSTEM_H__

#include "ObjectPool.h"
#include "Particle.h"

#define PARTICLE_MANAGER gg::particle::ParticleManager::getInstance() 

namespace gg { namespace particle {
    
    class ParticleManager 
    {
        
    public:
        static ParticleManager* getInstance();

        void update();
        
        void setMaxParticles(int number);
        
        Particle *createParticle() {
            return &(m_pool.create());
        }
        
        ~ParticleManager();
    
    protected:
        ParticleManager() : m_maxParticles(0),
                            m_pool(0) {}
        
    private:        
        typedef gg::utils::ObjectPool<gg::particle::Particle> ParticlePool;

        int m_maxParticles;
        ParticlePool m_pool;

        static ParticleManager *m_instance;
    };
}}

#endif