//
//  ParticleSystem_.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Particle.h"
#import "ParticleEmitter.h"
#import	"ParticleController.h"
#import "ParticleRenderer.h"

Class ParticleSystem_
{
public:
	id 					initWithParticles(int number, BOOL isContinuous, int kRenderingMode);
	
	//Getters
	unsigned int 		getParticleNumber();
	BOOL				getTextureBound();
	BOOL				getIsActive();
	Particle			**getArray();
	ParticleEmitter 	*getSystemEmitter();
	ParticleRenderer 	*getSystemRenderer();
	
private:
	unsigned int		particleNumber;		//Total number of particles in the system
	BOOL				textureBound;
	BOOL				isActive;
	
	Particle			**array;
	ParticleEmitter		*systemEmitter;
	ParticleController	*systemController;
	ParticleRenderer	*systemRenderer;
};
