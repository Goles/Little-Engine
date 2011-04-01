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

#include "SharedTextureManager.h"
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
                          m_pointSpriteCount(0),
                          m_emissionAccumulator(0.0),
                          m_emissionDuration(0.0f),
                          m_emit(true)
    {
        init();
    }
    
    void init();
    
    //Getters Setters
    inline void setTexture(const std::string &texture_name){ 
        TEXTURE_MANAGER->createTexture(texture_name);
        m_texture = texture_name; 
    }
    
    inline void setEmissionRate(float rate) { m_emissionRate = rate; }
    inline void setEmissionRateVariance(float variance) { m_emissionRateVariance = variance; }
    inline void setOriginVariance(float variance) { m_originVariance = variance; }
    inline void setLifeVariance(float variance) { m_lifeVariance = variance; }
    inline void setSpeedVariance(float variance) { m_speedVariance = variance; }
    inline void setDecayVariance(float variance) { m_decayVariance = variance; }
    inline void setEmissionDuration(float time) { m_emissionDuration = time; }
    inline void setSize(float size) { m_size = size; }
    inline void setEmit(bool do_emit) { m_emit = do_emit; }
    void setDefaultParticle(Particle p) { m_defaultParticle = p; }
    
    inline const std::string &texture() const { return m_texture; }
    inline float emissionRate() const { return m_emissionRate; }
    inline float emissionRateVariance() const { return m_emissionRateVariance; }
    inline float originVariance() const { return m_originVariance; }
    inline float lifeVariance() const { return m_lifeVariance; }
    inline float speedVariance() const { return m_speedVariance; }
    inline float decayVariance() const { return m_decayVariance; }
    inline float emissionDuration() const { return m_emissionDuration; }
    inline float size() const { return m_size; }
    
	//Component interface
public:
	virtual void render() const;
	virtual const std::string &componentID() const { return m_label; }
	virtual void update(float delta);
    
protected:
    void emit(float delta);
    void pushVertexPointSprites();
    void pushVertexPointSprite(const Particle *p);
    void pushVertex2XTriangles();
    void pushVertex2XTriangle(const Particle *p);
    
	//Particle System Atributes
private:
    typedef std::vector<Particle *> ParticleVector;
    
    ParticleVector m_particles;  
    Particle m_defaultParticle;
    std::vector<int> deleteIndexes;

    //For Rendering
    ParticleVertex *m_interleavedVertexs;
	PointSprite *m_interleavedPointSprites;
    EnumType m_renderMode;
    GLuint m_bufferId;
	GLuint m_colorBufferId;
    float m_emissionAccumulator;
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
