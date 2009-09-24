//
//  ParticleController.m
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 Gando Games. All rights reserved.
//

/*
 *
 *	
	The Particle controller is responsible for particle (of the System Array) actions as a set.
 
	Ex: 
		- Rotation around a point.
		- Variable particle sizes.
		- Variable particle colors.
		- Areas around the system to which the particles react in different ways.
		- Collision detection. ( with other objects or particles if necesary)
 *
 */
 
#import "ParticleController.h"
#import "ConstantsAndMacros.h"
#import "ParticleFunctions.h"
#import "Texture2D.h"
#import "Particle.h"

@implementation ParticleController

@synthesize delegate;

@synthesize	source;
@synthesize particleTexture;

- (id) initWithParticles:(int) particleNum
{
	particleNumber = particleNum;
	
	source = CGPointMake(SCREEN_WIDTH/2, 100);
	
	//We load the particle Texture.
	particleTexture = [[Texture2D alloc] initWithImage:[UIImage imageNamed:@"Particle.png"]];
	
	if ((self = [super init])) 
	{		
		array = (Particle **)malloc(particleNum * sizeof(Particle *));
		
		for(int i = 0; i < particleNum; i++)
		{
			array[i] = [[Particle alloc] initWithSource:source];
		}
	}
	return self;
}

- (void) draw
{
	for(int i = 0; i < particleNumber; i++)
	{
		if(array[i].lifeTime > 0.0)
			[array[i] update];
		else {
			[array[i] reset];
		}
		
		/*First we asign the Color to the particle.*/
		unsigned char RGB[3];
		
		//if(array[i].lifeTime < 0.0)
		//	array[i].lifeTime = 0.0;
		
		float HSV[3] = {/*array[i].lifeTime */ 230, 80, 1};
		//float HSV[3] = {255.0f, 1, 1};
		_HSVToRGB(HSV, RGB);
		
		unsigned char shortAlpha = (array[i].lifeTime)*255.0f;
		unsigned color = (shortAlpha << 24) | (RGB[0] << 16) | (RGB[1] << 8) | (RGB[2] << 0);
		
		/*Then we start calculating the coords of the particle square.*/
		GLfloat	width  = (GLfloat)[particleTexture getWidth],
				height = (GLfloat)[particleTexture getHeight];
		
		
        float topRightX = width  / 2 + array[i].position.x;
        float topRightY = height / 2 + array[i].position.y;
        
        float topLeftX = -width / 2 + array[i].position.x;
        float topLeftY = height / 2 + array[i].position.y;
        
        float bottomLeftX = -width  / 2 + array[i].position.x;
        float bottomLeftY = -height / 2 + array[i].position.y;
        
        float bottomRightX =  width  / 2 + array[i].position.x;
        float bottomRightY = -height / 2 + array[i].position.y;
		
		
		//Then we pass both of our triangles that actually compose a particle.
		// Triangle #1
        addVertex(topLeftX, topLeftY, 0, 0, color);
        addVertex(topRightX, topRightY, 1, 0, color);
        addVertex(bottomLeftX, bottomLeftY, 0, 1, color);
        
        // Triangle #2
        addVertex(topRightX, topRightY, 1, 0, color);
        addVertex(bottomLeftX, bottomLeftY, 0, 1, color);
        addVertex(bottomRightX, bottomRightY, 1, 1, color);
		
		if (_vertexCount >= MAX_VERTEX)
		{
			_vertexCount = MAX_VERTEX;
		}
	}
}

- (void) moveSource:(CGPoint) newSource
{
	for(int i = 0; i < particleNumber; i++)
		array[i].source = newSource;
}

- (void) flush
{
    if (!_vertexCount)
        return;

    glVertexPointer(2, GL_SHORT, sizeof(ParticleVertex), &_interleavedVertexs[0].v);
    glTexCoordPointer(2, GL_FLOAT, sizeof(ParticleVertex), &_interleavedVertexs[0].uv);
    glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(ParticleVertex), &_interleavedVertexs[0].color);
    glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
    _vertexCount = 0;
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
