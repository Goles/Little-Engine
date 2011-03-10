/*
 *  ParticleSystems.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 Gando-Games All rights reserved.
 *
 *	_NG
 */

#ifndef __GEC_PARTICLE_SYSTEM_H__
#define __GEC_PARTICLE_SYSTEM_H__

#include <vector>
#include <string>

#include "Particle.h"
#include "gecVisual.h"


class gecParticleSystem: public gecVisual
{	
	//Particle System Interface
public:
	//Constructor & Destructor
	gecParticleSystem(int particleNum) : m_particleNum(particleNum) { 
        this->init(); 
    }
    
	~gecParticleSystem(){};

	//Component interface
public:
	virtual void render() const;
	virtual const std::string &componentID() const { return m_label; }
	virtual void update(float delta);
	
    //Particle System private methods
private:
    void init();

	//Particle System Atributes
private:
    typedef std::vector<gg::particle::Particle *> ParticleVector;
	    
    ParticleVector m_particles;
    unsigned int m_particleNum;
    static std::string m_label;
};

#endif