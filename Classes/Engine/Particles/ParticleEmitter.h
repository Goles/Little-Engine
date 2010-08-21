//
//  ParticleEmitter.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#ifndef _PARTICLE_EMITTER_H_
#define _PARTICLE_EMITTER_H_

#include "OpenGLCommon.h"

@class Particle;

@interface ParticleEmitter : NSObject 
{
	int numberOfParticles;
	
	CGPoint emitionSource;
	CGPoint emitionEnd;
	
	float slopeM;		// Will conform a line equation
	float interceptN;	// Will conform a line equation
	
	Particle **array; //Should contain system's array reference.
	
	short int currentFX;
	
	BOOL calculatedInterpolation;
	float linearInterpolation;		//Distance between particles to cover certain distance.
}

@property (readwrite) CGPoint emitionSource;

- (void) update;
- (void) setSystemXInitialSpeed:(float)inXSpeed
				  initialYSpeed:(float)inYSpeed
						 xAccel:(float)inXAccel
						 yAccel:(float)inYAccel
				 xAccelVariance:(float)inXAccelVariance
				 yAccelVariance:(float)inYAccelVariance
					   xGravity:(float)inXGravity
					   yGravity:(float)inYGravity
					   lifeTime:(float)inLifeTime
			   lifespanVariance:(float)inLifespanVariance
						 source:(CGPoint)inSource
				 decreaseFactor:(float)inDecreaseFactor
					   position:(CGPoint)inPosition
						   size:(float)inSize
					 startColor:(Color3D)inStartColor
					   endColor:(Color3D)inEndColor;

- (id) initWithParticleNumber:(int) inNumberOfParticles particlesArray:(Particle **)inParticleArray;
- (void) setCurrentFX:(int)fx withSource:(CGPoint)inSource andEnd:(CGPoint)inEnd;
- (void) updateEmitionSource;
- (void) calculateLinearEmission;

@end

#endif