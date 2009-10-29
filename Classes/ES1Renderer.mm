//
//  ES1Renderer.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ES1Renderer.h"
#import "ConstantsAndMacros.h"
#import "Texture2D.h"
#import "EmitterFunctions.h"
#import "SingletonParticleSystemManager.h"

@implementation ES1Renderer

@synthesize aSystem;

// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }

		
		/*
		 * Image allocation
		 */
		particleTextures = new Image();
		particleTextures->initWithUIImage([UIImage imageNamed:@"player.png"], 1.0f, GL_LINEAR);
		particleTextures->setAlpha(1.0);
		
		/*
		 *	Different Emitters Benchmark
		 */
				
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireSmall atStartPosition:CGPointMake(50, 100)];
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireMedium atStartPosition:CGPointMake(100, 100)];
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireBig atStartPosition:CGPointMake(150, 100)];
		
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionSmall atStartPosition:CGPointMake(250, 300)];
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionMedium atStartPosition:CGPointMake(250, 200)];
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionBig atStartPosition:CGPointMake(250, 100)];
		
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainSmall atStartPosition:CGPointMake(50, 300)];
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainMedium atStartPosition:CGPointMake(100, 300)];		
		[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainBig atStartPosition:CGPointMake(150, 300)];		
		
		
		/*
		 *	Smoke Benchmark
		 */
		//[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_Smoke atStartPosition:CGPointMake(150, 100) withImage:particleTextures];		
		
		/*
		 *	Ship Benchmark
		 */
		
		someImage = new Image();
		someImage->initWithUIImage([UIImage imageNamed:@"player.png"], 1.0f, GL_LINEAR);
		someImage->setAlpha(3.0); 
		someImage->setRotation(180);
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
	}
	
	return self;
}

- (void) setupView
{	
	// setup viewport and projection
	glViewport(0, 0, backingWidth, backingHeight);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(0, 320, 0, 480, -1, 1);
	glMatrixMode(GL_MODELVIEW);
	glEnable(GL_DEPTH_TEST);
}

- (void) render
{
	[EAGLContext setCurrentContext:context];
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);

	if(!viewSetup)
	{
		[self setupView];
		viewSetup = YES;
	}
	
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[[SingletonParticleSystemManager sharedParticleSystemManager] drawSystems];
	
	
	someImage->renderAtPoint(CGPointMake(150, 100), YES);	//draw the ship image.
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void) mainGameLoop
{
	CFTimeInterval		time;
	float				delta;
	time	= CFAbsoluteTimeGetCurrent();
	delta	= time - lastTime;
	
	//[self render:delta];
	
	lastTime = time;
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}

	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

@end
