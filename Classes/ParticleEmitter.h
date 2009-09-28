//
//  ParticleEmitter.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Particle;

@interface ParticleEmitter : NSObject 
{
	id delegate;
	CGPoint emitionSource;
	CGPoint emitionEnd;
	
	float slopeM;		// Will conform a line equation
	float interceptN;	// Will conform a line equation
	
	Particle **array; //Should contain system's array reference.
	
	short int currentFX;
	
	BOOL calculatedInterpolation;
	float linearInterpolation;		//Distance between particles to cover certain distance.
}

@property (nonatomic, retain) id delegate;
@property (readwrite) CGPoint emitionSource;

- (void) update;
- (void) setSystemXSpeed:(float) inXSpeed 
				  ySpeed:(float) inYSpeed 
				  xAccel:(float) inXAccel 
				  yAccel:(float) inYAccel 
				lifeTime:(float) inLifeTime 
				  source:(CGPoint) inSource 
				position:(CGPoint) inPosition;

- (id) initWithDelegate:(id)inDelegate;
- (void) setCurrentFX:(int)fx withSource:(CGPoint)inSource andEnd:(CGPoint)inEnd;
- (void) updateEmitionSource;
- (void) setArrayReference;

- (void) calculateLinearEmission;

@end
