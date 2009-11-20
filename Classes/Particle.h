//
//  Particle.h
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"

@interface Particle : NSObject 
{
	CGPoint		source;
	CGPoint		position;
	Color3D		startColor;
	Color3D		deltaColor;
	Color3D		currentColor;
	float		xInitialSpeed, yInitialSpeed;
	float		xSpeed,ySpeed;
	float		xAccel,yAccel;
	float		xGravity, yGravity;
	float		xAccelVariance, yAccelVariance;
	float		lifeTime;
	float		startingLifeTime;
	float		lifespanVariance;
	float		lastLifespan;
	float		rotation;
	float		decreaseFactor;
	float		size;
	float		preCalcX;	//pre-calculated xAccel + xGravity + xAccelVariance to avoid float *
	float		preCalcY;	//pre-calculated yAccel + yGravity + yAccelVariance to avoid float *
	BOOL		isActive;	
}

@property (readwrite) CGPoint position;
@property (readwrite) CGPoint source;
@property (readwrite) float xSpeed;
@property (readwrite) float ySpeed;
@property (readwrite) float xInitialSpeed;
@property (readwrite) float yInitialSpeed;
@property (readwrite) float xAccel;
@property (readwrite) float yAccel;
@property (readwrite) float xGravity;
@property (readwrite) float yGravity;
@property (readwrite) float xAccelVariance;
@property (readwrite) float yAccelVariance;
@property (readwrite) float lifeTime;
@property (readwrite) float startingLifeTime;
@property (readwrite) float lifespanVariance;
@property (readwrite) float lastLifespan;
@property (readwrite) float rotation;
@property (readwrite) float decreaseFactor;
@property (readwrite) float size;
@property (readwrite) BOOL	isActive;
@property (readwrite) float preCalcX;
@property (readwrite) float preCalcY;

- (id) init;
- (void) update;
- (void) reset;
- (void) setStartColor:(Color3D) inColor;
- (Color3D) startColor; 
- (void) setDeltaColor:(Color3D) inColor;
- (Color3D) deltaColor;
- (Color3D) currentColor;


@end
