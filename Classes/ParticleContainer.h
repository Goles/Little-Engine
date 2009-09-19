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

typedef struct 
{
	short v[2];
	unsigned color;
	float uv[2];
}	ParticleVertex;


@interface ParticleContainer : NSObject 
{
	Texture2D	*particleTexture;
	int particleNumber;
	Particle	**array;
	
}

- (id) initWithParticles:(int) particleNum;
- (void) draw;

@end
