 //
//  gecParticleSystem.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/10/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "gecParticleSystem.h"
#include "GameEntity.h"
#include "ParticleManager.h"

#include <algorithm>

std::string gecParticleSystem::m_label = "gecParticleSystem";

void gecParticleSystem::init()
{
    m_particles.reserve(m_emissionRate);
    deleteIndexes.reserve(m_emissionRate);
    
    //Pre-Allocate a big chunk of vertex space
    switch (m_renderMode) {
        case gg::particle::render::kRenderingMode_PointSprites:
            m_interleavedPointSprites = (PointSprite *) malloc(sizeof(PointSprite) * PARTICLE_MANAGER->maxParticles());
            break;
            
        case gg::particle::render::kRenderingMode_2xTriangles:
            m_interleavedVertexs = (ParticleVertex *) malloc(sizeof(ParticleVertex) * (PARTICLE_MANAGER->maxParticles()) * 6);
            break;
            
        default:
            assert(false);
    }
    
    glGenBuffers(1, &m_bufferId);
}

void gecParticleSystem::render() const 
{
    glPushMatrix();
	glEnable(GL_TEXTURE_2D);
    
    TEXTURE_MANAGER->bindTexture(m_texture);

    if(gecVisual::m_dirtyTransform)
        glMultMatrixf(m_transform);
    
    if(gecVisual::m_dirtyColor)
        glColor4f(m_color[0], m_color[1], m_color[2], m_color[3]);
    
	switch (m_renderMode) 
    {
		case gg::particle::render::kRenderingMode_PointSprites:
            
			if(!m_pointSpriteCount)
				return;
			
			glEnable(GL_BLEND);
			glBlendFunc(GL_SRC_ALPHA, GL_ONE);
			
			glEnable(GL_POINT_SPRITE_OES);
			glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
			
			glEnableClientState(GL_VERTEX_ARRAY);
			glEnableClientState(GL_COLOR_ARRAY);
			glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
			
			glBindBuffer(GL_ARRAY_BUFFER, m_bufferId);
			
			glVertexPointer(2, GL_SHORT, sizeof(PointSprite), 0);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(PointSprite), (GLvoid *)sizeof(GL_UNSIGNED_BYTE));
			glPointSizePointerOES(GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GL_FLOAT)*2));
			
			glDrawArrays(GL_POINTS, 0, m_pointSpriteCount);
			
			glBindBuffer(GL_ARRAY_BUFFER, 0);
			
			glDisable(GL_POINT_SPRITE_OES);
			glDisableClientState(GL_VERTEX_ARRAY);
			glDisableClientState(GL_COLOR_ARRAY);
			glDisableClientState(GL_POINT_SIZE_ARRAY_OES);
			
			m_pointSpriteCount = 0;
            
			break;
			
		case gg::particle::render::kRenderingMode_2xTriangles:
			
            if (!m_vertexCount)
				return;	
			
			glEnable(GL_BLEND);
			//glBlendFunc(GL_SRC_ALPHA, GL_ONE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
            
			glEnableClientState(GL_TEXTURE_COORD_ARRAY);
			glEnableClientState(GL_COLOR_ARRAY);
			glEnableClientState(GL_VERTEX_ARRAY);
			
			glVertexPointer(2, GL_SHORT, sizeof(ParticleVertex), &m_interleavedVertexs[0].v);
			glTexCoordPointer(2, GL_FLOAT, sizeof(ParticleVertex), &m_interleavedVertexs[0].uv);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(ParticleVertex), &m_interleavedVertexs[0].color);
			glDrawArrays(GL_TRIANGLES, 0, m_vertexCount);
						
			glDisableClientState(GL_TEXTURE_COORD_ARRAY);
			glDisableClientState(GL_COLOR_ARRAY);
			glDisableClientState(GL_VERTEX_ARRAY);
			
			m_vertexCount = 0;
			
			break;
		
        default:
			assert(false); //shoudln't happen
    
	}
    
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_BLEND);
	glDisable(GL_TEXTURE_2D);
    glPopMatrix();
}

void gecParticleSystem::update(float delta)
{
    if(m_particles.size() > 0)
    {
        ParticleVector::iterator particle = m_particles.begin();
        
        int counter = 0;
        
        // Iterate through particles
        for (; particle != m_particles.end(); ++particle)
        {        
            (*particle)->life -= ((*particle)->decay * delta);
            
            if((*particle)->life > 0.0f)
            {
                //Update a Particle
                float alpha = (*particle)->life / m_defaultParticle.life;
                (*particle)->position.x += (*particle)->speed.x * delta;
                (*particle)->position.y += (*particle)->speed.y * delta;
                (*particle)->color_A = alpha * 255.0f;
                
                //Push the corresponding Point Sprite
                if(m_renderMode == gg::particle::render::kRenderingMode_PointSprites)
                    pushVertexPointSprite(*particle);
                else
                    assert(false);
                
            }else {
                deleteIndexes.push_back(counter);
            }
                    
            ++counter;
        }
        
        for(int i = 0; i < deleteIndexes.size(); ++i)
        {
            if(deleteIndexes[i] < m_particles.size())
            {
                PARTICLE_MANAGER->releaseParticle(m_particles[deleteIndexes[i]]);
                std::swap(m_particles[deleteIndexes[i]], m_particles.back());
                m_particles.pop_back();
            }
        }
        
        deleteIndexes.clear();
        
        //Create our vertex Arrays
        if(m_pointSpriteCount > 0)
        {
            /*Now that I pushed all my pointSprites, I can go and fill my buffer*/
            glBindBuffer(GL_ARRAY_BUFFER, 0);
            glBindBuffer(GL_ARRAY_BUFFER, m_bufferId);
            glBufferData(GL_ARRAY_BUFFER, sizeof(PointSprite)*m_pointSpriteCount, m_interleavedPointSprites, GL_DYNAMIC_DRAW);
            glBindBuffer(GL_ARRAY_BUFFER, 0);
        }
    }
    
    if(m_emit)
        this->emit(delta);
}

void gecParticleSystem::emit(float delta)
{    
    if (m_emissionDuration >= 0.0f)
        m_emissionDuration -= delta;
    
    if (m_emissionDuration <= 0.0f)
        m_emit = false;
    
    int particlesToEmit = ceilf(m_emissionRate * delta + (CCRANDOM_MINUS1_1() * m_emissionRateVariance));
    
    for(int i = 0; i < particlesToEmit; ++i)
    {
        Particle *p = PARTICLE_MANAGER->createParticle();
        
        p->position.x = this->getOwnerGE()->getPosition().y + CCRANDOM_MINUS1_1() * m_originVariance;
        p->position.y = this->getOwnerGE()->getPosition().x + CCRANDOM_MINUS1_1() * m_originVariance;
        p->speed.x = m_defaultParticle.speed.x +  CCRANDOM_MINUS1_1() * m_speedVariance;
        p->speed.y = m_defaultParticle.speed.y + CCRANDOM_MINUS1_1() * m_speedVariance;
        p->life = m_defaultParticle.life + CCRANDOM_MINUS1_1() * m_lifeVariance;
        p->decay = m_defaultParticle.decay + CCRANDOM_MINUS1_1() * m_decayVariance;
        p->color_R = m_defaultParticle.color_R;
        p->color_G = m_defaultParticle.color_G;
        p->color_B = m_defaultParticle.color_B;
        p->color_A = m_defaultParticle.color_A;
        p->rotation = m_defaultParticle.rotation;
        
        m_particles.push_back(p);
    }
}

void gecParticleSystem::pushVertex2XTriangles()
{
    ParticleVector::iterator particle = m_particles.begin();
    
	for(; particle != m_particles.end(); ++particle)
	{
        Particle *p = (*particle);    
        
		float w = 32.0f;
		
        p->rotation += 1;
		
		// Instead of changing GL state (translate, rotate) we rotate the sprite's corners here.  This lets us batch sprites at any rotation.
        // Fixme not very efficient way to rotate :P
		
		float cachedRotation	= p->rotation;
		float cachedPositionX	= p->position.y;
		float cachedPositionY	= p->position.x;
		
        float radians	= cachedRotation + (M_PI * 0.25f);
        float topRightX = cachedPositionX+ (cosf(radians) * w);
        float topRightY = cachedPositionY + (sinf(radians) * w);
        
		radians = cachedRotation + (M_PI * 3.0f * 0.25f);
        float topLeftX = cachedPositionX + (cosf(radians) * w);
        float topLeftY = cachedPositionY + (sinf(radians) * w);
        
		radians = cachedRotation + (M_PI * 5.0f * 0.25f);
        float bottomLeftX = cachedPositionX + (cosf(radians) * w);
        float bottomLeftY = cachedPositionY + (sinf(radians) * w);
        
		radians = cachedRotation + (M_PI * 7.0f * 0.25f);
        float bottomRightX = cachedPositionX + (cosf(radians) * w);
        float bottomRightY = cachedPositionY + (sinf(radians) * w);
        
		unsigned color = (p->color_A << 24) | 
                         (p->color_B << 16) | 
                         (p->color_G << 8) | 
                         (p->color_R << 0);
		
		/*Then we start calculating the coords of the particle texture square.*/
        
		//Then we pass both of our triangles that actually compose a particle position..
		// Triangle #1        
        gg::particle::render::addVertex(topLeftX, topLeftY, 0, 0, color, m_interleavedVertexs, &m_vertexCount);
        gg::particle::render::addVertex(topRightX, topRightY, 1, 0, color, m_interleavedVertexs, &m_vertexCount);
        gg::particle::render::addVertex(bottomLeftX, bottomLeftY, 0, 1, color, m_interleavedVertexs, &m_vertexCount);
        
        // Triangle #2
        gg::particle::render::addVertex(topRightX, topRightY, 1, 0, color, m_interleavedVertexs, &m_vertexCount);
        gg::particle::render::addVertex(bottomLeftX, bottomLeftY, 0, 1, color, m_interleavedVertexs, &m_vertexCount);
        gg::particle::render::addVertex(bottomRightX, bottomRightY, 1, 1, color, m_interleavedVertexs, &m_vertexCount);
	}
}

inline void gecParticleSystem::pushVertexPointSprite(const Particle *p)
{
    unsigned color = (p->color_A << 24) | 
                     (p->color_B << 16) | 
                     (p->color_G << 8) | 
                     (p->color_R << 0);
    
    addPointSprite(p->position.y, 
                   p->position.x, 
                   color, 
                   m_size * p->color_A, 
                   m_interleavedPointSprites, 
                   &m_pointSpriteCount);
}

void gecParticleSystem::pushVertexPointSprites()
{
    ParticleVector::const_iterator particle = m_particles.begin();
    
	for(; particle != m_particles.end(); ++particle)
	{ 
        Particle *p = *particle;

		unsigned color = (p->color_A << 24) | 
                         (p->color_B << 16) | 
                         (p->color_G << 8) | 
                         (p->color_R << 0);
		
		/*We add the point sprite to the array.*/				
		addPointSprite(p->position.y, 
					   p->position.x, 
					   color, 
					   m_size * p->color_A, 
					   m_interleavedPointSprites, 
					   &m_pointSpriteCount);
	}
    
    if(m_pointSpriteCount > 0)
    {
        /*Now that I pushed all my pointSprites, I can go and fill my buffer*/
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ARRAY_BUFFER, m_bufferId);
        glBufferData(GL_ARRAY_BUFFER, sizeof(PointSprite)*m_pointSpriteCount, m_interleavedPointSprites, GL_DYNAMIC_DRAW);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
    }
}
