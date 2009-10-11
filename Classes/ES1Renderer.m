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
#import "ParticleSystem.h"
#import "ParticleEmitter.h"
#import "RenderingFunctions.h"
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
		
		
		/*FIRE
		 aSystem	= [[ParticleSystem alloc] initWithParticles:3000
													 continuous:YES];
		 */
		/*[[aSystem systemEmitter] setSystemXInitialSpeed:0.0 
										  initialYSpeed:8 
												 xAccel:0
												 yAccel:-0.2
										 xAccelVariance:0.4
										 yAccelVariance:0.1
											   xGravity:0
											   yGravity:0
											   lifeTime:0.0
												 source:CGPointMake(160, 200) 
										 decreaseFactor:20	//Bigger means slower decrease. => Higher life time
											   position:CGPointMake(160, 200)
												   size:32
											 startColor:Color3DMake(252, 164, 38, 0)
											   endColor:Color3DMake(252, 108, 0, 0)];
		*/
		/*Flame thrower fountain
		 aSystem	= [[ParticleSystem alloc] initWithParticles:1500
													 continuous:YES];
		[[aSystem systemEmitter] setSystemXInitialSpeed:0 
										  initialYSpeed:15
												 xAccel:0
												 yAccel:-0.4
										 xAccelVariance:0.8
										 yAccelVariance:0.4
											   xGravity:0
											   yGravity:0
											   lifeTime:0.0
												 source:CGPointMake(160, 200) 
										 decreaseFactor:20	//Bigger means slower decrease. => Higher life time
											   position:CGPointMake(160, 200)
												   size:32
											 startColor:Color3DMake(255, 127, 77, 0)
											   endColor:Color3DMake(255, 127, 77, 0)];
		*/
		

		
		/*SingletonParticleSystemManager *theManager = [[SingletonParticleSystemManager alloc] init];
		
		ParticleSystem *someSystem	= [[ParticleSystem alloc] initWithParticles:3 continuous:YES];
		ParticleSystem *someSystem2	= [[ParticleSystem alloc] initWithParticles:2 continuous:YES];
		ParticleSystem *someSystem3	= [[ParticleSystem alloc] initWithParticles:1 continuous:YES];
		
		[theManager insertEntity:someSystem];
		[theManager insertEntity:someSystem2];
		[theManager insertEntity:someSystem3];
		
		[theManager printListDebug];
		
		[theManager removeEntityAtPosition:2];

		[theManager printListDebug];*/
		
		/*aSystem	= [[ParticleSystem alloc] initWithParticles:40 continuous:YES renderingMode:kRenderingMode_PointSprites];
		
		[[aSystem systemEmitter] setSystemXInitialSpeed:0
										  initialYSpeed:0
												 xAccel:0
												 yAccel:0.03
										 xAccelVariance:0.1
										 yAccelVariance:0.1
											   xGravity:0
											   yGravity:0
											   lifeTime:0.0
												 source:CGPointMake(160, 200) 
										 decreaseFactor:20	//Bigger means slower decrease. => Higher life time
											   position:CGPointMake(160, 200)
												   size:16
											 startColor:Color3DMake(255, 127, 77, 0)
											   endColor:Color3DMake(255, 127, 77, 0)];

		[[aSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:CGPointMake(160, 200) andEnd:CGPointMake(100.0f, 100.0f)];
*/
		/*
		
		ParticleSystem *aSystem2	= [[ParticleSystem alloc] initWithParticles:1000 continuous:YES renderingMode:kRenderingMode_PointSprites];
		
		[[aSystem2 systemEmitter] setSystemXInitialSpeed:0
										  initialYSpeed:0
												 xAccel:0
												 yAccel:0
										 xAccelVariance:1
										 yAccelVariance:1
											   xGravity:0
											   yGravity:0
											   lifeTime:0.0
												 source:CGPointMake(160, 200) 
										 decreaseFactor:60	//Bigger means slower decrease. => Higher life time
											   position:CGPointMake(160, 200)
												   size:16
											 startColor:Color3DMake(1, 50, 255, 0)
											   endColor:Color3DMake(255, 10, 255, 0)];
		
		[[aSystem2 systemEmitter] setCurrentFX:kEmmiterFX_none withSource:CGPointMake(160, 200) andEnd:CGPointMake(100.0f, 100.0f)];
		*/
		
		/*ParticleSystem *aSystem3	= [[ParticleSystem alloc] initWithParticles:1000 continuous:YES renderingMode:kRenderingMode_PointSprites];
		[[aSystem3 systemEmitter] setSystemXInitialSpeed:0 
										  initialYSpeed:10
												 xAccel:0
												 yAccel:-0.4
										 xAccelVariance:0.8
										 yAccelVariance:0.4
											   xGravity:0
											   yGravity:0
											   lifeTime:0.0
												 source:CGPointMake(160, 200) 
										 decreaseFactor:20	//Bigger means slower decrease. => Higher life time
											   position:CGPointMake(160, 200)
												   size:32
											 startColor:Color3DMake(50, 30, 77, 0)
											   endColor:Color3DMake(255, 127, 77, 0)];
		
		[[aSystem3 systemEmitter] setCurrentFX:kEmmiterFX_none withSource:CGPointMake(160, 300) andEnd:CGPointMake(100.0f, 100.0f)]; 
		*/
		
		/*
		 *This is a benchmark.
		 */
		for(int i = 20; i < 320; i+= 40)
			for(int j = 30; j < 480; j+= 30)
				[[SingletonParticleSystemManager sharedParticleSystemManager] createParticleFX:kParticleSystemFX_smallFire atStartPosition:CGPointMake(i, j)];

		
		
		//[[SingletonParticleSystemManager sharedParticleSystemManager] insertEntity:aSystem2];
		//[[SingletonParticleSystemManager sharedParticleSystemManager] insertEntity:aSystem3];
		
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
	glOrthof(0, 320, 0, 480, 0, 1);
	glMatrixMode(GL_MODELVIEW);
	glDisable(GL_DEPTH_TEST);
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
	
	// clear background to black (don't need these if you draw a background image, since it will draw over whatever's there)
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
 	
	glEnable(GL_TEXTURE_2D);
	
	if(![aSystem textureBound])
	{
		[[aSystem currentTexture] bind];
		[aSystem setTextureBound:YES];
	}

	/*[aSystem update];
	[aSystem draw];
	*/
	
	drawSystems();
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
