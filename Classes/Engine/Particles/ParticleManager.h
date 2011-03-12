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
        int maxParticles() { return m_maxParticles; }
        
        Particle *createParticle() {
            return &(m_pool->create());
        }
        
        void releaseParticle(const Particle *p)
        {
            m_pool->release(p->index);
        }
        
        ~ParticleManager()
        {
            delete m_pool;
        }
    
    protected:
        ParticleManager() : m_pool(0) {}
        
    private:        
        typedef gg::utils::ObjectPool<gg::particle::Particle> ParticlePool;

        int m_maxParticles;
        ParticlePool *m_pool;

        static ParticleManager *m_instance;
    };
}}

#endif