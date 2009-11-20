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
#import "Animation.h"
#import "SharedParticleSystemManager.h"
#import "SharedTextureManager.h"
#import "ParticleSystem.h"
#import "SceneManager.h"

#include <iostream>

@class ParticleController;
@class Texture2D;
@class SingletonParticleSystemManager;

@interface ES1Renderer : NSObject <ESRenderer>
{
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
	
	//Testing C++ stuff
	SpriteSheet		*ss;
	Image			*sprite;
	Animation		*animatedSprite;
	ParticleSystem	*testSystem;
	SceneManager	*aSceneManager;
}

- (void) update:(float)delta;
- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void) setupView;
- (void) initGame;

/*Tests*/
- (void) sceneManagerTest1;
- (void) sceneManagerTest2Sort;
- (void) spriteSheetTest;
- (void) particlesTest;
- (void) animationTest;
- (void) animationTest2;
- (void) textureManagerTest:(NSString *) inTextureName;
 
@end
