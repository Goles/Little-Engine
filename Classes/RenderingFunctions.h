/*
 *  RenderingFunctions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 9/25/09.
 *  Copyright 2009 Gando Games. All rights reserved.
 *
 */

#import "OpenGLCommon.h"

typedef enum
{
	kRenderingMode_PointSprites = 0,
	kRenderingMode_2xTriangles,
} RenderingMode;

/*Structure used when not using point-sprites. (using 2xtriangles instead to simulate quad)*/
typedef struct 
{
	short v[2];
	unsigned color;
	float uv[2];	
}	ParticleVertex;

/*Structure used when using point sprites, (doesn't need uv, but size)*/
typedef struct
{
	short v[2];
	unsigned color;
	float size;
} PointSprite;

enum { H, S, V };

#define MAX_VERTEX 20000
#define MAX_POINT_SPRITE 20000

static inline void _HSVToRGB(const float *HSV, unsigned char *RGB)
{
    float	h = HSV[H], 
			s = HSV[S], 
			v = HSV[V];
	
    float w = roundf(h) / 60.0f;
	float floorW = floor(w);
    float h1 = fmodf(floorW, 6.0f);
    float f = w - floorW;
    float p = v * (1.0f - s);
    float q = v * (1.0f - (f * s));
    float t = v * (1.0f - ((1.0f - f) * s));
    
    p *= 255.0f;
    q *= 255.0f;
    t *= 255.0f;
    v *= 255.0f;
    
    switch ((int)h1) {
        case 0:
            RGB[0] = v;
            RGB[1] = t;
            RGB[2] = p;
			break;
			
        case 1:
            RGB[0] = q;
            RGB[1] = v;
            RGB[2] = p;
			break;
			
        case 2:
            RGB[0] = p;
            RGB[1] = v;
            RGB[2] = t;
			break;
			
        case 3:
            RGB[0] = p;
            RGB[1] = q;
            RGB[2] = v;
			break;
			
        case 4:
            RGB[0] = t;
            RGB[1] = p;
            RGB[2] = v;
			break;
			
        case 5:
            RGB[0] = v;
            RGB[1] = p;
            RGB[2] = q;
			break;
			
        default:
            RGB[0] = RGB[1] = RGB[2] = 0.0f;
            NSLog(@"um that's not a color");
			break;
    }
}

/*Function that adds a whole vertex to the _interleavedVertexs[] array*/
static inline void addVertex(float x, float y, float uvx, float uvy, unsigned color, ParticleVertex _interleavedVertexs[], unsigned *_vertexCount)
{
	ParticleVertex *vert = &_interleavedVertexs[(*_vertexCount)];
	vert->v[0]	= x;
	vert->v[1]	= y;
	vert->uv[0]	= uvx;
	vert->uv[1] = uvy;
	vert->color	= color;
	(*_vertexCount)++;
}

/*Function that adds a whole pointSprite to the _interleavedPointSprites[] array*/
static inline void addPointSprite(float x, float y, unsigned color, float size, PointSprite _interleavedPointSprites[], unsigned *_pointSpriteCount)
{
	PointSprite	*sprite	= &_interleavedPointSprites[(*_pointSpriteCount)];
	sprite->v[0]	= x;
	sprite->v[1]	= y;
	sprite->size	= size;
	sprite->color	= color;

	(*_pointSpriteCount)++;
}
