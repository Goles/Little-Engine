//
//  ParticleContainer.m
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParticleContainer.h"
#import "ConstantsAndMacros.h"
#import "Particle.h"
#import "Texture2D.h"
#import "ParticleFunctions.h"

@implementation ParticleContainer

- (id) initWithParticles:(int) particleNum
{
	particleNumber = particleNum;
	
	//We load the particle Texture.
	particleTexture = [[Texture2D alloc] initWithImage:[UIImage imageNamed:@"Particle.png"]];
	
	if ((self = [super init])) 
	{		
		array = (Particle **)malloc(particleNum * sizeof(Particle *));
		
		for(int i = 0; i < particleNum; i++)
		{
			array[i] = [[Particle alloc] init];
		}
	}
	return self;
}

static void addVertex(float x, float y, float uvx, float uvy, unsigned color)
{
	ParticleVertex *vert = &_interleavedVertexs[_vertexCount];
	vert->v[0]	= x;
	vert->v[1]	= y;
	vert->uv[0]	= uvx;
	vert->uv[1] = uvy;
	vert->color	= color;
}


- (void) draw
{
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT,GL_NICEST);
	glHint(GL_POINT_SMOOTH_HINT,GL_NICEST);
	
	glPushMatrix();

	
	for(int i = 0; i < particleNumber; i++)
	{
		glLoadIdentity();
		glColor4f(array[i].lifeTime, (array[i].lifeTime)/2, (array[i].lifeTime)/8, array[i].lifeTime);

		[particleTexture drawAtPoint:array[i].position];
		
		if(array[i].lifeTime > 0.0)
			[array[i] update];
		else {
			[array[i] reset];
		}
	}
	glPopMatrix();
	
	glDisable(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_VERTEX_ARRAY);
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	
	
	/*for(int i = 0; i < particleNumber; i++)
	{
		float HSV = {array[i].lifeTime, 1.0f, 1.0f};
	}*/

}

- (void) dealloc
{
	for(int i = 0; i < particleNumber; i++)
	{
		[array[i] release];
	}
	
	free(array);
	
	[super dealloc];
}

@end
