/*
 *  ParticleFunctions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 9/19/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */


#define MAX_VERTEX 20000

typedef struct 
{
	short v[2];
	unsigned color;
	float uv[2];
	float col[4];
}	ParticleVertex;

static ParticleVertex _interleavedVertexs[MAX_VERTEX];
static unsigned _vertexCount = 0;

enum { H, S, V };

void _HSVToRGB(const float *HSV, unsigned char *RGB)
{
    float h = HSV[H], s = HSV[S], v = HSV[V];
    float w = roundf(h) / 60.0f;
    float h1 = fmodf(floorf(w), 6.0f);
    float f = w - floorf(w);
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

static void addVertex(float x, float y, float uvx, float uvy, unsigned color)
{
	ParticleVertex *vert = &_interleavedVertexs[_vertexCount];
	vert->v[0]	= x;
	vert->v[1]	= y;
	vert->uv[0]	= uvx;
	vert->uv[1] = uvy;
	vert->color	= color;
	_vertexCount++;
}
