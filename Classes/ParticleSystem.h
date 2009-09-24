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

@class Particle;
@class ParticleController;
@class ParticleEmitter;
@class ParticleRenderer;

@interface ParticleSystem : NSObject 
{
	unsigned int		particleNumber;		//Total number of particles in the system
	
	Particle			**array;
	ParticleController	*systemController;	
	ParticleEmitter		*systemEmitter;
	ParticleRenderer	*systemRenderer;
}

@property(retain, nonatomic) ParticleEmitter *systemEmitter;

@property (readwrite) unsigned int particleNumber;
@property Particle **array;

@end
