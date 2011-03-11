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
            unsigned char color[4]; //RGBA
            unsigned char rotation;
        };
        
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