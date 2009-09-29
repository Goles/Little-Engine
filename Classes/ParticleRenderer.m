//
//  ParticleRenderer.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParticleRenderer.h"
#import "ParticleSystem.h"
#import "Texture2D.h"
#import "Particle.h"
#import "RendererFunctions.h"


@implementation ParticleRenderer

@synthesize delegate;
@synthesize particleTexture;
@synthesize renderingMode;

- (id) initWithDelegate:(id) inDelegate
{
	if((self = [super init]))
	{
		delegate = inDelegate;
		
		if(delegate)
		{
			[self setArrayReference];
			particleTexture = [[Texture2D alloc] initWithImagePath:@"Particle.png"]; // For now this will be instanciated here, in the future must be a pointer to a texture stored somewhere.
			renderingMode	= kRenderingMode_PointSprites;
		}
	}
	
	return self;
}

- (void) setArrayReference
{	
	array = [(ParticleSystem *)delegate array];
}

#pragma mark vertexPushingModes

- (void) pushVertexs2XTriangles
{
	/*
	 * We asume the whole system will use the same texture, so this will not change.
	 */
	GLfloat	width  = (GLfloat)[particleTexture getWidth],
	height = (GLfloat)[particleTexture getHeight];
	
	for(int i = 0; i < [delegate particleNumber]; i++)
	{
		/*First we asign the Color to the particle.*/
		unsigned char RGB[3];
		
		float HSV[3] = {array[i].lifeTime *225.0f, 1.0f, 100.0f};
		//float HSV[3] = {255.0f, 1, 1};
		_HSVToRGB(HSV, RGB);
		
		unsigned char shortAlpha = (array[i].lifeTime)*150.0f;
		unsigned color = (shortAlpha << 24) | (RGB[0] << 16) | (RGB[1] << 8) | (RGB[2] << 0);
		
		/*Then we start calculating the coords of the particle texture square.*/
		
		/*We just make two calls to get the positions*/
		float particleTextureX = array[i].position.x;
		float particleTextureY = array[i].position.y;
		
        float topRightX		= width  / 2 + particleTextureX;
        float topRightY		= height / 2 + particleTextureY;
        
        float topLeftX		= -width / 2 + particleTextureX;
        float topLeftY		= height / 2 + particleTextureY;
        
        float bottomLeftX	= -width  / 2 + particleTextureX;
        float bottomLeftY	= -height / 2 + particleTextureY;
        
        float bottomRightX	=  width  / 2 + particleTextureX;
        float bottomRightY	= -height / 2 + particleTextureY;
		
		//Then we pass both of our triangles that actually compose a particle position..
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

- (void) pushVertexsPointSprites
{
	for(int i = 0; i < [delegate particleNumber]; i++)
	{
		/*First we asign the Color to the particle.*/
		unsigned char RGB[3];
		
		float HSV[3] = {array[i].lifeTime *225.0f, 1.0f, 100.0f};
		//float HSV[3] = {255.0f, 1, 1};
		_HSVToRGB(HSV, RGB);
		
		unsigned char shortAlpha = (array[i].lifeTime)*150.0f;
		unsigned color = (shortAlpha << 24) | (RGB[0] << 16) | (RGB[1] << 8) | (RGB[2] << 0);
		
		/*We add the point sprite to the array.*/
		addPointSprite(array[i].position.x, array[i].position.y, color, array[i].size);
		
		if (_pointSpriteCount >= MAX_VERTEX)
		{
			_pointSpriteCount = MAX_VERTEX;
		}
	}
}

/*This will fill the correct interleaved arrays.*/
- (void) update
{
	switch (renderingMode) {
		case kRenderingMode_2xTriangles:
			[self pushVertexs2XTriangles];
			break;
		case kRenderingMode_PointSprites:
			[self pushVertexsPointSprites];
			break;
		default:
			NSLog(@"Unrecognized Rendering mode when trying to update the interleaved arrays.");
			break;
	}
}

- (void) draw
{
	switch (renderingMode) {
		case kRenderingMode_2xTriangles: //If we are drawing triangles.
			if (!_vertexCount)
				return;	
			
			glVertexPointer(2, GL_SHORT, sizeof(ParticleVertex), &_interleavedVertexs[0].v);
			glTexCoordPointer(2, GL_FLOAT, sizeof(ParticleVertex), &_interleavedVertexs[0].uv);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(ParticleVertex), &_interleavedVertexs[0].color);
			glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
			_vertexCount = 0;
			
			break;
		case kRenderingMode_PointSprites: //If We are drawing pointSprites.
			if(!_pointSpriteCount)
				return;
			
			glEnable(GL_POINT_SPRITE_OES);
			glTexEnvi(GL_POINT_SPRITE_OES, GL_COORD_REPLACE_OES, GL_TRUE);
			glEnableClientState(GL_POINT_SIZE_ARRAY_OES);
			
			glVertexPointer(2, GL_SHORT, sizeof(PointSprite), &_interleavedPointSprites[0].v);
			glPointSizePointerOES(GL_FLOAT, sizeof(PointSprite), &_interleavedPointSprites[0].size);
			glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(PointSprite), &_interleavedPointSprites[0].color);
			
			glDrawArrays(GL_POINTS, 0, _pointSpriteCount);
			_pointSpriteCount = 0;
			break;
		default:
			
			NSLog(@"Unrecognized rendering mode. This shouldn't happen.");
			
			break;
	}
}

@end
