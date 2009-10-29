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
#import "Image.h"
#import "SpriteSheet.h"

@class ParticleController;
@class Texture2D;
@class ParticleSystem;
@class SingletonParticleSystemManager;

@interface ES1Renderer : NSObject <ESRenderer>
{
@public
	ParticleSystem *aSystem;
@private
	
	/* Time since the last frame was rendered */
	CFTimeInterval lastTime;
	
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
	Image		*someImage;
	Image		*particleTextures;

	SpriteSheet *ss;
	Image		*sprite;
}

@property (nonatomic, retain) ParticleSystem *aSystem;

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void) setupView;
- (void) initGame;
- (void) particlesBenchmark1;

@end
