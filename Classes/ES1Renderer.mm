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
#import "SceneManager.h"

@implementation ES1Renderer

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
	[self animationTest3];
	[self particlesTest];
}

/*
 *
 *	TESTS
 *
 */
#pragma mark TESTS

- (void) deleteTest1
{
	GameEntity *a = new ParticleSystem(40, true,  0);
	
	delete a;
	
	
}

- (void) sceneManagerTest1
{
	//GameEntity *anEntity = new ParticleSystem(10, true , 0);
	
	SceneManager *aTestManager = new SceneManager();
	
	//std::cout << aSceneManager->addEntity((GameEntity *)(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"))) << std::endl;
	
	testSystem = aTestManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"));
	
	aTestManager->debugPrintEntityList();
	
	PARTICLE_MANAGER->debugPrintList();
}

-(void) sceneManagerTest2Sort
{
	aSceneManager = new SceneManager();
	
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(30, 30) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(10, 10) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(70, 70) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(20, 20) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 50) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(60, 60) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(40, 40) , "Particle2.pvr"));
	
	aSceneManager->debugPrintEntityList();
	
	aSceneManager->sortEntitiesY();
	
	aSceneManager->debugPrintEntityList();
}

- (void) animationTest
{
	ss = new SpriteSheet();
	ss->initWithImageNamed("sprite_test.png", 98, 142, 0, 1.0);
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
	ss->initWithImageNamed("Sprite_Sheet_Test.png", 44.0, 64, 0, 1.0);
	
	animatedSprite = new Animation();
	
	for(int i = 0; i < 18; i++)
		animatedSprite->addFrameWithImage(ss->getSpriteAt(i, 0), 0.08);
	
	animatedSprite->setIsRunning(true);
	animatedSprite->setIsRepeating(true);
}

- (void) animationTest3
{
	ss = new SpriteSheet();
	ss->initWithImageNamed("prototypePlayerSheet.png", 100, 100, 0.0, 1.0);
	
	animatedSprite = new Animation();
	
	for(int i = 1; i <= 4; i++)
		animatedSprite->addFrameWithImage(ss->getSpriteAt(i, 0), 0.18);
	
	animatedSprite->setIsRunning(true);
	animatedSprite->setIsRepeating(true);
}

- (void) spriteSheetTest
{
	ss = new SpriteSheet();
	ss->initWithImageNamed("spritesheet16.gif", 16, 16, 0, 2.0);
	sprite = ss->getSpriteAt(4, 2);
}

- (void) particlesTest
{	
	aSceneManager = new SceneManager();
	
	testSystem	=   aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireMedium, CGPointMake(100, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireBig, CGPointMake(150, 101), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionSmall, CGPointMake(250, 300), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionMedium, CGPointMake(250, 200), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionBig, CGPointMake(250, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainSmall, CGPointMake(50, 300), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainMedium, CGPointMake(100, 300), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainBig, CGPointMake(150, 300), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_Smoke, CGPointMake(150, 100), "smoke.png"));	
}

- (void) textureManagerTest:(NSString *) inTextureName
{
	/*First we ask the texture manager to create the texture for us*/
	Texture2D *aTexture = TEXTURE_MANAGER->createTexture([inTextureName UTF8String]);
	//NSLog(@"Smoke.png: %d",[aTexture name]);
	
	/*then we ask for the texture again to check if the texture is just created once*/
	Texture2D *aTexture2 = TEXTURE_MANAGER->createTexture([inTextureName UTF8String]);
	//NSLog(@"Smoke.png: %d",[aTexture2 name]);
	
	if([aTexture name] != [aTexture2 name])
	{
		printf("TextureManagerTest 1 FAIL, different OpenGL ES textureNames (%d != %d)\n",[aTexture name],[aTexture2 name]);
		assert(aTexture);
	}else {
		printf("TextureManagerTest 1 PASS, equal OpenGL ES textureNames (%d == %d)\n",[aTexture name],[aTexture2 name]);
	}
}

#pragma mark action_methods
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
	
	if(aSceneManager != NULL)
	{
		aSceneManager->sortEntitiesY();
		aSceneManager->updateScene();
		aSceneManager->renderScene();
	}	
	
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
	
	delete PARTICLE_MANAGER;
	delete TEXTURE_MANAGER;
	
	[context release];
	context = nil;
	
	delete TEXTURE_MANAGER;
	
	[super dealloc];
}

@end
