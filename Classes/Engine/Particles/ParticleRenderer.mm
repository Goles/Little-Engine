//
//  ParticleRenderer.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#include "SharedTextureManager.h"
#include "ParticleRenderer.h"
#include "gecParticleSystem.h"
#include "Texture2D.h"
#include "Particle.h"
#include "OpenGLCommon.h"
#include "FileUtils.h"

@implementation ParticleRenderer

@synthesize renderingMode;
@synthesize continuousRendering;
@synthesize resetCount;

#pragma mark initializers

- (id) initWithSystemReference:(void *) inReference particlesArray:(Particle **)inParticlesArray particles:(int)inParticleNumber type:(int) inRenderingMode
{
	if((self = [super init]))
	{
		particleSystemReference = (gecParticleSystem *)inReference;
		
		if(particleSystemReference != NULL && inParticlesArray != NULL)
		{
			array = inParticlesArray;
			_vertexCount		= 0;
			_pointSpriteCount	= 0;
			_particleNumber		= inParticleNumber;
			
			renderingMode	= inRenderingMode;
			
			switch (inRenderingMode) {
				case kRenderingMode_PointSprites:
					_interleavedPointSprites = (PointSprite *)malloc(sizeof(PointSprite)*inParticleNumber);
					break;
				case kRenderingMode_2xTriangles:
					_interleavedVertexs = (ParticleVertex *)malloc(sizeof(ParticleVertex)*inParticleNumber*6); //The 2x is because two triangles per particle are needed
					break;
				default:
					NSLog(@"Problem when allocating the vertex arrays");
					break;
			}
			
			/*we initialize the gl buffer*/
			glGenBuffers(1, &bufferID);
		}
	}
	return self;
}

- (void) testDelegateReference
{
	((gecParticleSystem *)particleSystemReference)->render();
}

#pragma mark vertexPushingModes

- (void) pushVertexs2XTriangles
{
	/*
	 * We asume the whole system will use the same texture, so this will not change.
	 *
	
	GLfloat	width  = (GLfloat)[particleTexture pixelsWide],
	height = (GLfloat)[particleTexture pixelsHigh];
	*/
	for(int i = 0; i < _particleNumber; i++)
	{
		float cachedParticleLifeTime = array[i].lifeTime;
		float cachedAlpha			 = cachedParticleLifeTime/(array[i].lastLifespan+array[i].startingLifeTime);
		
		float w = 32.0f;
		
		[array[i] setRotation:[array[i] rotation] + 0.009];
		
		// Instead of changing GL state (translate, rotate) we rotate the sprite's corners here.  This lets us batch sprites at any rotation.
        // Fixme not very efficient way to rotate :P
		
		float cachedRotation	= [array[i] rotation];
		float cachedPositionX	= [array[i] position].x;
		float cachedPositionY	= [array[i] position].y;
		
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
		
		/*
		 * Update particle
		 */
		if(array[i].lifeTime > 0.0)
		{	
			[array[i] update];
		}
		else {
			[array[i] reset];
		}
		
		/*First we asign the Color to the particle.*/
		unsigned char RGB[3];
		
		unsigned char shortAlpha = cachedAlpha*255.0f;
		
		Color3D particleColor = [array[i] currentColor];	//The current particle color
		
		RGB[0] = particleColor.blue;
		RGB[1] = particleColor.green;
		RGB[2] = particleColor.red;
		
		unsigned color = (shortAlpha << 24) | (RGB[0] << 16) | (RGB[1] << 8) | (RGB[2] << 0);
		
		/*Then we start calculating the coords of the particle texture square.*/

		//Then we pass both of our triangles that actually compose a particle position..
		// Triangle #1
        addVertex(topLeftX, topLeftY, 0, 0, color, _interleavedVertexs, &_vertexCount);
        addVertex(topRightX, topRightY, 1, 0, color, _interleavedVertexs, &_vertexCount);
        addVertex(bottomLeftX, bottomLeftY, 0, 1, color, _interleavedVertexs, &_vertexCount);
        
        // Triangle #2
        addVertex(topRightX, topRightY, 1, 0, color, _interleavedVertexs, &_vertexCount);
        addVertex(bottomLeftX, bottomLeftY, 0, 1, color, _interleavedVertexs, &_vertexCount);
        addVertex(bottomRightX, bottomRightY, 1, 1, color, _interleavedVertexs, &_vertexCount);
		
		if (_vertexCount >= MAX_VERTEX)
		{
			_vertexCount = MAX_VERTEX;
		}
	}
}

- (void) pushVertexsPointSprites
{	
	for(int i = 0; i < _particleNumber; i++)
	{
		float cachedParticleLifeTime = array[i].lifeTime;
		float cachedAlpha			 = cachedParticleLifeTime/(array[i].lastLifespan+array[i].startingLifeTime);
		
		/*
		 * Update particle
		 */		
		if(cachedParticleLifeTime > 0.01)
			[array[i] update];
		else{
			if(continuousRendering)
				[array[i] reset];
			else {
				if([array[i] isActive])
				{	
					resetCount++;	
					[array[i] setIsActive:NO];
					
					if(resetCount == _particleNumber) //check this only if we added a new particle to the inactive particles
					{	
						systemDeactivation = YES; //deactivate the whole system once all it's particles are inactive.
						resetCount = 0;			  //we set to zero to be ready for another System Activation.
					}
				}
			}
		}

		/*First we asign the Color to the particle.*/
		unsigned char RGB[3];
		unsigned char shortAlpha = cachedAlpha*255.0f;

		Color3D particleColor = [array[i] currentColor];	//The current particle color
		
		RGB[0] = particleColor.blue;
		RGB[1] = particleColor.green;
		RGB[2] = particleColor.red;
		
		unsigned color = (shortAlpha << 24) | (RGB[0] << 16) | (RGB[1] << 8) | (RGB[2] << 0);
		
		/*We add the point sprite to the array.*/				
		addPointSprite(array[i].position.x, 
					   array[i].position.y, 
					   color, 
					   array[i].size*cachedAlpha, 
					   _interleavedPointSprites, 
					   &_pointSpriteCount);

		if (_pointSpriteCount >= MAX_POINT_SPRITE)
		{
			_pointSpriteCount = MAX_POINT_SPRITE;
		}
	}

	/*Now that I pushed all my pointSprites, I can go and fill my buffer*/
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, bufferID);
	glBufferData(GL_ARRAY_BUFFER, sizeof(PointSprite)*_pointSpriteCount, _interleavedPointSprites, GL_DYNAMIC_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
}

/*This will fill the correct interleaved arrays.*/
- (void) update
{
	switch (renderingMode) {
		case kRenderingMode_PointSprites:
			[self pushVertexsPointSprites];
			break;
		
		case kRenderingMode_2xTriangles:
			[self pushVertexs2XTriangles];
			break;		
		default:
			NSLog(@"Unrecognized Rendering mode when trying to update the interleaved arrays.");
			break;
	}
	
	if(systemDeactivation)
	{
		((gecParticleSystem *)particleSystemReference)->setIsActive(NO);
		systemDeactivation = NO; // we reset the flag of the deactivation.
	}
}

#pragma mark drawing

- (void) draw
{
	TEXTURE_MANAGER->bindTexture(particleSubTexture->getTextureName());

	glEnable(GL_TEXTURE_2D);
	
	switch (renderingMode) {
		case kRenderingMode_PointSprites: //If We are drawing pointSprites.
			if(!_pointSpriteCount)
				return;
			
			glEnable(GL_BLEND);
			glBlendFunc(GL_SRC_ALPHA, GL_ONE);
			
			
			glEnable(GL_POINT_SPRITE_OES);
			glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
			
			glEnableClientState(GL_VERTEX_ARRAY);
			glEnableClientState(GL_COLOR_ARRAY);
			glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
			
			
			glBindBuffer(GL_ARRAY_BUFFER, bufferID);
			
			glVertexPointer(2, GL_SHORT, sizeof(PointSprite), 0);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(PointSprite), (GLvoid *)sizeof(GL_UNSIGNED_BYTE));
			glPointSizePointerOES(GL_FLOAT, sizeof(PointSprite), (GLvoid *) (sizeof(GL_FLOAT)*2));
			
			glDrawArrays(GL_POINTS, 0, _pointSpriteCount);
			
			glBindBuffer(GL_ARRAY_BUFFER, 0);
			
			glDisable(GL_POINT_SPRITE_OES);
			glDisableClientState(GL_VERTEX_ARRAY);
			glDisableClientState(GL_COLOR_ARRAY);
			glDisableClientState(GL_POINT_SIZE_ARRAY_OES);
			
			_pointSpriteCount = 0;
			break;
			
		case kRenderingMode_2xTriangles: //If we are drawing triangles.
			if (!_vertexCount)
				return;	
			
			glEnable(GL_BLEND);
			//glBlendFunc(GL_SRC_ALPHA, GL_ONE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);

			glEnableClientState(GL_TEXTURE_COORD_ARRAY);
			glEnableClientState(GL_COLOR_ARRAY);
			glEnableClientState(GL_VERTEX_ARRAY);
			
			glVertexPointer(2, GL_SHORT, sizeof(ParticleVertex), &_interleavedVertexs[0].v);
			glTexCoordPointer(2, GL_FLOAT, sizeof(ParticleVertex), &_interleavedVertexs[0].uv);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(ParticleVertex), &_interleavedVertexs[0].color);
			glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
			
			
			glDisableClientState(GL_TEXTURE_COORD_ARRAY);
			glDisableClientState(GL_COLOR_ARRAY);
			glDisableClientState(GL_VERTEX_ARRAY);
			
			_vertexCount = 0;
			
			break;
		default:
			
			printf("Unrecognized rendering mode. This shouldn't happen.\n");
			
			break;
	}
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_BLEND);
	glDisableClientState(GL_TEXTURE_2D);
}

#pragma mark setters
- (void) setParticleSubTexture:(Image *) inImage
{
	particleSubTexture = inImage;
}

@end
