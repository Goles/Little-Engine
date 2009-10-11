//
//  ParticleRenderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

/*
 *
 *	The particle Renderer has the hability to render particles mainly, and 
 *	filling the VBO's to make this happen. Interaction with the SingletonParticleSystemManager
 *  will be added in order to be able to draw massive arrays with all the ParticleSystems vertexes on them.
 *
 *  _NG
 */

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"
#import "RenderingFunctions.h"

@class Texture2D;
@class Particle;

@interface ParticleRenderer : NSObject 
{
	id			delegate;
	Particle	**array;			//this will be a reference to the system array.	
	Texture2D	*particleTexture;
	
	int renderingMode;
	GLuint bufferID;
	GLuint colorBufferID;
	
	BOOL continuousRendering;
	
	ParticleVertex	*_interleavedVertexs;
	PointSprite		*_interleavedPointSprites;
	
	unsigned _vertexCount;
	unsigned _pointSpriteCount;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Texture2D *particleTexture;
@property (readwrite) int renderingMode;
@property (readwrite) BOOL continuousRendering;

- (void) update;
- (void) draw;
- (void) pushVertexs2XTriangles;
- (void) pushVertexsPointSprites;
- (void) setArrayReference;
- (id) initWithDelegate:(id) inDelegate particles:(int)inParticleNumber type:(int) inRenderingMode;

@end
