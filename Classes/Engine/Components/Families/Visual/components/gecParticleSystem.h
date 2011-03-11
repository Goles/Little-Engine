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

#include <OpenGLES/ES1/glext.h>
#include <vector>
#include <string>

#include "gecVisual.h"
#include "Particle.h"
#include "Range.h"

using gg::utils::Range;
using gg::particle::Particle;
using gg::particle::render::ParticleVertex;
using gg::particle::render::PointSprite;
using gg::particle::render::EnumType;
using gg::particle::render::EnumColor;

class Image;

class gecParticleSystem: public gecVisual
{	
	//Particle System Interface
public:
	gecParticleSystem() : m_interleavedVertexs(0),
                          m_interleavedPointSprites(0),
                          m_renderMode(gg::particle::render::kRenderingMode_PointSprites),
                          m_vertexCount(0),
                          m_emissionDuration(0.0f),
                          m_emit(true)
    {
        init();
    }
    
    void init();
    void setDefaultParticle(Particle p) { m_defaultParticle = p; }
    
    //Getters & Setters
    std::string m_texture;
    float m_emissionRate;
    float m_emissionRateVariance;
    float m_originVariance;
    float m_lifeVariance;
    float m_speedVariance;
    float m_decayVariance;
    float m_emissionDuration;
    float m_size;
    bool m_emit;
    
	//Component interface
public:
	virtual void render() const;
	virtual const std::string &componentID() const { return m_label; }
	virtual void update(float delta);

protected:
    void emit(float delta);
    void pushVertexPointSprites();
    void pushVertex2XTriangles();
    
	//Particle System Atributes
private:
    typedef std::vector<Particle *> ParticleVector;
    
    ParticleVector m_particles;  
    Particle m_defaultParticle;

    //For Rendering
    ParticleVertex *m_interleavedVertexs;
	PointSprite *m_interleavedPointSprites;
    EnumType m_renderMode;
    GLuint m_bufferId;
	GLuint m_colorBufferId;
    mutable unsigned m_vertexCount;
    mutable unsigned m_pointSpriteCount;
    
    //Emitter Atributes
    std::string m_texture;
    float m_emissionRate;
    float m_emissionRateVariance;
    float m_originVariance;
    float m_lifeVariance;
    float m_speedVariance;
    float m_decayVariance;
    float m_emissionDuration;
    float m_size;
    bool m_emit;
    
    static std::string m_label;
};

#endif