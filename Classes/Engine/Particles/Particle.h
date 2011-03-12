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
#include "OpenGLCommon.h"
namespace gg 
{  
    namespace particle 
    {

        struct Particle 
        {
            GGPoint position;
            GGPoint speed;  
            float life;
            float decay;
            unsigned short index;
            unsigned char color_R;
            unsigned char color_G;
            unsigned char color_B;
            unsigned char color_A;
            unsigned char rotation;
        };
        
        namespace utils
        {
            inline Particle makeParticle(const CGPoint &in_position,
                                         const CGPoint &in_speed,
                                         float in_life,
                                         float in_decay,
                                         unsigned char in_colorR,
                                         unsigned char in_colorG,
                                         unsigned char in_colorB,
                                         unsigned char in_colorA,
                                         unsigned char in_rotation)
            {
                Particle p;
                p.position.x = in_position.x;
                p.position.y = in_position.y;
                p.speed.x = in_speed.x;
                p.speed.y = in_speed.y;
                p.life = in_life;
                p.decay = in_decay;
                p.color_R = in_colorR;
                p.color_G = in_colorG;
                p.color_B = in_colorB;
                p.color_A = in_colorA;
                p.rotation = in_rotation;
                
                return p;
            }
        }
        
        namespace render
        {
            struct ParticleVertex
            {
                short v[2];
                unsigned color;
                float uv[2];
            };
            
            struct PointSprite
            {
                short v[2];
                unsigned color;
                float size;
            };
            
            enum EnumType
            {
                kRenderingMode_PointSprites = 0,
                kRenderingMode_2xTriangles,
            };
            
            enum EnumColor
            {
                kColor_R = 0,
                kColor_G,
                kColor_B,
                kColor_A,
            };
            
            /* Function to add a vertex to an interleavedVertex[] array*/
            inline void addVertex(float x, float y, float uvx, float uvy, unsigned color, ParticleVertex _interleavedVertexs[], unsigned *_vertexCount)
            {
                ParticleVertex *vert = &_interleavedVertexs[(*_vertexCount)];
                vert->v[0]	= x;
                vert->v[1]	= y;
                vert->uv[0]	= uvx;
                vert->uv[1] = uvy;
                vert->color	= color;
                (*_vertexCount)++;
            }
            
            /* Function to add a pointSprite to an interleavedPointSprite[] array */
            inline void addPointSprite(float x, float y, unsigned color, float size, PointSprite _interleavedPointSprites[], unsigned *_pointSpriteCount)
            {
                PointSprite	*sprite	= &_interleavedPointSprites[(*_pointSpriteCount)];
                sprite->v[0]	= x;
                sprite->v[1]	= y;
                sprite->size	= size;
                sprite->color	= color;
                
                (*_pointSpriteCount)++;
            }
        }
    }
}

#endif