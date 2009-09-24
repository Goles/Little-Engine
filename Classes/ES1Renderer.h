//
//  ES1Renderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class ParticleController;
@class Texture2D;


@interface ES1Renderer : NSObject <ESRenderer>
{
	
	//Particles controller.
	ParticleController *theCanister;

@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	//setup
	BOOL viewSetup;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;

	Texture2D	*testTex;
	Texture2D	*backgroundTex;
	
}

@property (nonatomic, retain) ParticleController *theCanister;

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void) setupView;

@end
