//
//  ParticleContainer.h
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Particle;
@class Texture2D;

@interface ParticleController : NSObject 
{
	id delegate;	//this delegate should be the particle system.
	
	CGPoint source;
	Texture2D	*particleTexture;
	int particleNumber;
	Particle	**array;
}

@property (nonatomic, retain) id delegate;

@property (readwrite) CGPoint source;
@property (nonatomic, retain) Texture2D *particleTexture;

- (id) initWithParticles:(int) particleNum;
- (void) moveSource:(CGPoint) newSource;
- (void) draw;
- (void) flush;

@end
