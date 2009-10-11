//
//  ParticleSystem.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando games All rights reserved.
//

/*
 *
 *	Particle system, consists on one array of particles, a Controller, an Emitter and a Renderer.
 *
 *
 */

#import <Foundation/Foundation.h>
@class Texture2D;
@class Particle;
@class ParticleController;
@class ParticleEmitter;
@class ParticleRenderer;


@interface ParticleSystem : NSObject 
{
	unsigned int		particleNumber;		//Total number of particles in the system
	BOOL				textureBound;
	BOOL				isActive;
	
	Particle			**array;
	ParticleEmitter		*systemEmitter;
	ParticleController	*systemController;
	ParticleRenderer	*systemRenderer;
}

@property (readwrite) BOOL textureBound;
@property (readwrite) BOOL isActive;
@property (readwrite) unsigned int particleNumber;
@property (retain, nonatomic) ParticleEmitter *systemEmitter;
@property (retain, nonatomic) ParticleRenderer *systemRenderer;
@property Particle **array;


- (id) initWithParticles:(int)number
			  continuous:(BOOL)inContinuous
		   renderingMode:(int)kRenderingMode;
- (void) update;
- (void) draw;
- (Texture2D *) currentTexture;
@end
