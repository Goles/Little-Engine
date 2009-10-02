//
//  ParticleRenderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"

@class Texture2D;
@class Particle;

@interface ParticleRenderer : NSObject 
{
	id			delegate;
	Particle	**array;			//this will be a reference to the system array.	
	Texture2D	*particleTexture;
	int renderingMode;
	GLuint bufferID;
	GLuint colorBufferID;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) Texture2D *particleTexture;
@property (readwrite) int renderingMode;

- (void) update;
- (void) draw;
- (void) pushVertexs2XTriangles;
- (void) pushVertexsPointSprites;
- (void) setArrayReference;
- (id) initWithDelegate:(id)inDelegate;

@end
