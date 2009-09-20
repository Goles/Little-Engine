//
//  Particle.h
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Particle : NSObject 
{
	CGPoint source;
	CGPoint position;
	float	xSpeed,ySpeed;
	float	xAccel,yAccel;
	float	lifeTime;
	float	rotation;
}

@property (readwrite) CGPoint position;
@property (readwrite) CGPoint source;
@property (readwrite) float xSpeed;
@property (readwrite) float ySpeed;
@property (readwrite) float xAccel;
@property (readwrite) float yAccel;
@property (readwrite) float lifeTime;
@property (readwrite) float rotation;

- (id) initWithSource:(CGPoint) aSource;
- (void) update;
- (void) reset;

@end
