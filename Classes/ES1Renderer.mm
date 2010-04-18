//
//  ES1Renderer.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

#import "ES1Renderer.h"
#import "ConstantsAndMacros.h"
#import "Texture2D.h"
#import "EmitterFunctions.h"
#import "FileUtils.h"
#import "SceneManager.h"
#import "GEComponent.h"
#import "gecAnimatedSprite.h"
#import "gecVisualContainer.h"
#import "gecButton.h"
#import "gecJoystick.h"
#include "gecFSM.h"
#include "gecImage.h"
#include "Image.h"
#include <boost/bind.hpp>

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

- (void) initScenes
{
	aSceneManager = new SceneManager();
}

- (void) initGame
{
	[self initScenes];
	[self fsmTest];
}

/*
 *
 *	TESTS
 *
 */
#pragma mark -
#pragma mark TESTS
- (void) fsmTest
{
	GameEntity *hitter = GE_FACTORY->createGE("hitter1", 240.0f, 160.0f);	
	GameEntity *button = GE_FACTORY->createGE("buttonDummy", 350.0f, 50.0f);

	//Configure our button
	((gecButton *)button->getGEC("CompGUI"))->setActionPressed(kBehaviourAction_doAttack);
	((gecButton *)button->getGEC("CompGUI"))->setActionReleased(kBehaviourAction_stopAttack);
	((gecButton	*)button->getGEC("CompGUI"))->addSignal(boost::bind(&gecFSM::performAction, (gecFSM*)hitter->getGEC("CompBehaviour"), _1));
	
	//Add everything to the Scene.
	aSceneManager->addEntity(hitter);
	aSceneManager->addEntity(button);
}

- (void) multiTouchTest
{
	aSceneManager->addEntity(GE_FACTORY->createGE("buttonDummy", 240.0f, 160.0f));
	aSceneManager->addEntity(GE_FACTORY->createGE("buttonDummy", 100.0f, 100.0f));
}

- (void) particlesShowOff
{
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainGiant, CGPointMake(160, 60) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_Smoke, CGPointMake(240, 120) , "smoke.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainBig, CGPointMake(240, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainGiant, CGPointMake(320, 60) , "Particle2.pvr"));
}

- (void) geTemplateManagerTest1
{
	GameEntity *gE		= aSceneManager->addEntity(GE_FACTORY->createGE("testDummy",240.0f, 160.0f));
	GameEntity *joypadE = aSceneManager->addEntity(GE_FACTORY->createGE("joypad", 70.0f, 70.0f));
	aSceneManager->addEntity(GE_FACTORY->createGE("buttonDummy", 350.0f, 50.0f));	
	((gecJoystick *)joypadE->getGEC("CompGUI"))->subscribeGameEntity(gE);
}

- (void) particlesTest
{		
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireMedium, CGPointMake(100, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireBig, CGPointMake(150, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionSmall, CGPointMake(200, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionMedium, CGPointMake(250, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionBig, CGPointMake(300, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainSmall, CGPointMake(350, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainMedium, CGPointMake(400, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainBig, CGPointMake(450, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_Smoke, CGPointMake(140, 265), "smoke.pvr"));
	
}

- (void) textureManagerTest:(NSString *) inTextureName
{
	/*First we ask the texture manager to create the texture for us*/
	Texture2D *aTexture = TEXTURE_MANAGER->createTexture([inTextureName UTF8String]);
	
	/*then we ask for the texture again to check if the texture is just created once*/
	Texture2D *aTexture2 = TEXTURE_MANAGER->createTexture([inTextureName UTF8String]);
	
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
	glRotatef(-90.0, 0.0, 0.0, 1.0);
	glOrthof(0, 480, 0, 320, -1, 1);
	glMatrixMode(GL_MODELVIEW);
	glEnable(GL_DEPTH_TEST);
}

#pragma mark update_game
- (void) update:(float)delta
{
	if(aSceneManager)
		aSceneManager->updateScene(delta);
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
	delete GE_FACTORY;
	
	[context release];
	context = nil;

	
	[super dealloc];
}

@end
