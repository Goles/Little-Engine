//
//  ParticleRenderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_VERTEX 20000

@class Texture2D;
@class Particle;

@interface ParticleRenderer : NSObject 
{
	id			delegate;
	Particle	**array;	//this will be a reference to the system array.
	Texture2D	*particleTexture;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Texture2D *particleTexture;

- (void) draw;
- (void) pushVertexs;
- (void) setArrayReference;
- (id) initWithDelegate:(id)inDelegate;

@end
