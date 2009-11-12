//
//  ParticleRenderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando-Games All rights reserved.
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
#import "Image.h"



@class Texture2D;
@class Particle;

@interface ParticleRenderer : NSObject 
{
	void		*particleSystemReference;	//This is a weak reference to the ParticleSystem that contains this object instance.
	Particle	**array;					//this will be a reference to the system array.	
	Image		*particleSubTexture;
	
	BOOL continuousRendering;
	BOOL systemDeactivation;
	int renderingMode;
	GLuint bufferID;
	GLuint colorBufferID;

	ParticleVertex	*_interleavedVertexs;
	PointSprite		*_interleavedPointSprites;
	unsigned _particleNumber;
	unsigned _vertexCount;
	unsigned _pointSpriteCount;
	unsigned resetCount;
}

@property (readwrite) int renderingMode;
@property (readwrite) BOOL continuousRendering;
@property (readwrite) unsigned resetCount;

- (void) update;
- (void) draw;
- (void) pushVertexs2XTriangles;
- (void) pushVertexsPointSprites;
//- (id) initWithDelegate:(id) inDelegate particles:(int)inParticleNumber type:(int) inRenderingMode;
- (id) initWithSystemReference:(void *) inReference particlesArray:(Particle **)inParticlesArray particles:(int)inParticleNumber type:(int) inRenderingMode;
- (void) setParticleSubTexture:(Image *) inImage;
- (void) testDelegateReference;


@end
