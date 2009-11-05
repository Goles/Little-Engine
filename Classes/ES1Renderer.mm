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
#import "FileUtils.h"
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
		
		[self initGame];
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
	}
	
	return self;
}

- (void) initGame
{
	//[self animationTest2];
	[self particlesBenchmark1];
	[self animationTest];
}

- (void) animationTest
{
	ss = new SpriteSheet();
	ss->initWithImageNamed(@"sprite_test.png", 98, 142, 0, 1.0);
	//sprite = ss->getSpriteAt(4, 2);
	
	animatedSprite = new Animation();
	
	for (int i = 0; i < 10; i++)
	{		
		animatedSprite->addFrameWithImage(ss->getSpriteAt(i, 0), 0.08);
	}
	
	for (int i = 0; i < 2; i++)
	{
		animatedSprite->addFrameWithImage(ss->getSpriteAt(i,1), 0.08);
	}
	
	animatedSprite->addFrameWithImage(ss->getSpriteAt(2,1), 0.2);
		
	
	animatedSprite->setIsRunning(true);
	animatedSprite->setIsRepeating(true);
}

- (void) animationTest2
{
	ss = new SpriteSheet();
	ss->initWithImageNamed(@"Sprite_Sheet_Test.png", 44.0, 64, 0, 1.0);
	
	animatedSprite = new Animation();
	
	for(int i = 0; i < 18; i++)
		animatedSprite->addFrameWithImage(ss->getSpriteAt(i, 0), 0.08);
	
	animatedSprite->setIsRunning(true);
	animatedSprite->setIsRepeating(true);
}



- (void) spriteSheetTest
{
	ss = new SpriteSheet();
	ss->initWithImageNamed(@"spritesheet16.gif", 16, 16, 0, 2.0);
	sprite = ss->getSpriteAt(4, 2);
}

- (void) particlesBenchmark1
{
	/*
	 * Image allocation
	 */
	
	 particleTextures = new Image();
	 //particleTextures->initWithTexture([[Texture2D alloc] initWithPVRTCFile:[FileUtils fullPathFromRelativePath:@"smoke.pvr"]], 1.0);
	 particleTextures->initWithTexture([[Texture2D alloc] initWithImagePath:[[NSBundle mainBundle] pathForResource:@"smoke.png" ofType:nil] filter:GL_LINEAR], 1.0);
	 
	
	/*
	 *	Different Emitters Benchmark
	 */
	
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireSmall 
																	atStartPosition:CGPointMake(50, 100) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireMedium 
																	atStartPosition:CGPointMake(100, 100) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FireBig 
																	atStartPosition:CGPointMake(150, 100) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionSmall
																	atStartPosition:CGPointMake(250, 300) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionMedium 
																	atStartPosition:CGPointMake(250, 200) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_ExplosionBig 
																	atStartPosition:CGPointMake(250, 100) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainSmall 
																	atStartPosition:CGPointMake(50, 300) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainMedium 
																	atStartPosition:CGPointMake(100, 300) 
																		  withImage:particleTextures];
	 
	 [[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_FountainBig 
																	atStartPosition:CGPointMake(150, 300) 
																		  withImage:particleTextures];		
	
	/*
	 *	Smoke Benchmark
	 */
	[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_Smoke atStartPosition:CGPointMake(150, 100) withImage:particleTextures];		
	
	/*
	 *	Ship Benchmark
	 */		
	/*someImage = new Image();
	someImage->initWithUIImage([UIImage imageNamed:@"player.png"], 1.0f, GL_LINEAR);
	someImage->setAlpha(3.0); 
	someImage->setRotation(180);
	 */
	
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


#pragma mark update_game
- (void) update:(float)delta
{
	if(animatedSprite)
		animatedSprite->update(delta);
}

#pragma mark render_scene
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
	
	if(sprite)
		sprite->renderAtPoint(CGPointMake(150, 100), YES);
	
	if(someImage)
		someImage->renderAtPoint(CGPointMake(150, 100), YES);	//draw the ship image.
	
	/*if(animatedSprite)
	{
		for(int i = 0; i < 320; i+=5)
			for(int j = 50; j < 480; j+=50)
				animatedSprite->renderAtPoint(CGPointMake(i, j));
	}*/
	if(animatedSprite)
		animatedSprite->renderAtPoint(CGPointMake(160, 240));
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
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
