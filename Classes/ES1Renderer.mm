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
#import "GEComponent.h"
#import "gecAnimatedSprite.h"
#import "gecVisualContainer.h"
#import "gecButton.h"
#import "gecJoystick.h"


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
	aSceneManager = new SceneManager();
	//[self particlesTest];
	//[self componentTest1];
	
	//[self componentTest2Button];
	//[self componentTest3Joystick];
	[self geTemplateManagerTest1];
}

/*
 *
 *	TESTS
 *
 */
#pragma mark TESTS

- (void) deleteTest1
{
	/*GameEntity *a = new ParticleSystem(40, true,  0);
	
	delete a;*/
}

- (void) sceneManagerTest1
{	
	/*SceneManager *aTestManager = new SceneManager();
	
	testSystem = aTestManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"));
	
	aTestManager->debugPrintEntityList();
	
	PARTICLE_MANAGER->debugPrintList();*/
}

-(void) sceneManagerTest2Sort
{
	//aSceneManager = new SceneManager();
	
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

- (void) componentTest1
{
	GameEntity *anEntity		= new GameEntity();
	GameEntity *anEntity2		= new GameEntity();
	GameEntity *anEntity3		= new GameEntity();
	GameEntity *anEntity4		= new GameEntity();
	GameEntity *anEntity5		= new GameEntity();
	
	std::vector<int> aVector;

	aVector.push_back(1);
	aVector.push_back(0);
	aVector.push_back(2);
	aVector.push_back(0);
	aVector.push_back(3);
	aVector.push_back(0);
	aVector.push_back(4);
	aVector.push_back(0);
	
	ss = new SpriteSheet();
	ss->initWithImageNamed("prototypePlayerSheet.png", 100, 100, 0.0, 1.0);	
	
	gecAnimatedSprite *spriteComp;
	gecAnimatedSprite *spriteComp2,
					  *spriteComp3,
					  *spriteComp4,
					  *spriteComp5;
						
	
	spriteComp = new gecAnimatedSprite();				//new gecAnimatedSpriteComponent
	spriteComp->addAnimation("walking", aVector, ss);	//add a full animation to the gec
	spriteComp->setCurrentAnimation("walking");			//we set it to walk ( just now )
	spriteComp->setCurrentRunning(true);				//we set it to be ON ( just now )
	spriteComp->setCurrentRepeating(true);				//we set it to repeat ( Just now )
	spriteComp->setOwnerGE(anEntity);					//we must set the owner of this.
	
	spriteComp2 = new gecAnimatedSprite();			
	spriteComp2->addAnimation("walking", aVector, ss);
	spriteComp2->setCurrentAnimation("walking");		
	spriteComp2->setCurrentRunning(true);			
	spriteComp2->setCurrentRepeating(true);			
	spriteComp2->setOwnerGE(anEntity2);	
	
	
	spriteComp3 = new gecAnimatedSprite();			
	spriteComp3->addAnimation("walking", aVector, ss);
	spriteComp3->setCurrentAnimation("walking");		
	spriteComp3->setCurrentRunning(true);			
	spriteComp3->setCurrentRepeating(true);			
	spriteComp3->setOwnerGE(anEntity3);	
	
	spriteComp4 = new gecAnimatedSprite();			
	spriteComp4->addAnimation("walking", aVector, ss);
	spriteComp4->setCurrentAnimation("walking");		
	spriteComp4->setCurrentRunning(true);			
	spriteComp4->setCurrentRepeating(true);			
	spriteComp4->setOwnerGE(anEntity4);	
	
	spriteComp5 = new gecAnimatedSprite();			
	spriteComp5->addAnimation("walking", aVector, ss);
	spriteComp5->setCurrentAnimation("walking");		
	spriteComp5->setCurrentRunning(true);			
	spriteComp5->setCurrentRepeating(true);			
	spriteComp5->setOwnerGE(anEntity5);	
	
	gecVisualContainer *aContainer = new gecVisualContainer();	//new visual components container
	aContainer->addGecVisual(spriteComp);						//we add the animation component
	
	gecVisualContainer *aContainer2 = new gecVisualContainer();	//new visual components container
	aContainer2->addGecVisual(spriteComp2);						//we add the animation component
	
	gecVisualContainer *aContainer3 = new gecVisualContainer();	//new visual components container
	aContainer3->addGecVisual(spriteComp3);						//we add the animation component
	
	gecVisualContainer *aContainer4 = new gecVisualContainer();	//new visual components container
	aContainer4->addGecVisual(spriteComp4);						//we add the animation component
	
	gecVisualContainer *aContainer5 = new gecVisualContainer();	//new visual components container
	aContainer5->addGecVisual(spriteComp5);						//we add the animation component
	
	anEntity->setGEC(aContainer);							
	anEntity->x = 160.0;
	anEntity->y = 240.0;
	anEntity->isActive = true;	
	
	anEntity2->setGEC(aContainer2);
	anEntity2->x = 100.0;
	anEntity2->y = 100.0;
	anEntity2->isActive = true;
	
	anEntity3->setGEC(aContainer3);
	anEntity3->x = 200.0;
	anEntity3->y = 200.0;
	anEntity3->isActive = true;
	
	anEntity4->setGEC(aContainer4);
	anEntity4->x = 250.0;
	anEntity4->y = 250.0;
	anEntity4->isActive = true;
	
	anEntity5->setGEC(aContainer5);
	anEntity5->x = 40.0;
	anEntity5->y = 40.0;
	anEntity5->isActive = true;
	
	aSceneManager->addEntity(anEntity);
	aSceneManager->addEntity(anEntity2);
	aSceneManager->addEntity(anEntity3);
	aSceneManager->addEntity(anEntity4);
	aSceneManager->addEntity(anEntity5);
}

- (void) componentTest2Button
{
	GameEntity *anEntity = new GameEntity();
	
	std::vector<int> aVector, aVector2, aVector3;
	
	aVector.push_back(0);
	aVector.push_back(0);
	aVector2.push_back(1);
	aVector2.push_back(0);
	aVector3.push_back(2);
	aVector3.push_back(0);
	
	ss = new SpriteSheet();
	ss->initWithImageNamed("buttons_test.png", 200, 50, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", aVector, ss);
	spriteComp->addAnimation("hot", aVector2, ss);
	spriteComp->addAnimation("active", aVector3, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);
	
	gecButton *buttonComp;	
	buttonComp = new gecButton();
	buttonComp->setOwnerGE(anEntity);
	buttonComp->setShape(CGRectMake(240.0, 160.0, 200, 50));
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(buttonComp);
	anEntity->x = 240.0;
	anEntity->y = 160.0;
	anEntity->isActive  = true;
	
	//aSceneManager = new SceneManager();
	aSceneManager->addEntity(anEntity);
}

- (void) componentTest3Joystick
{
	GameEntity *anEntity = new GameEntity();
	
	/*Build the joystick*/
	
	std::vector<int> aVector;
	
	aVector.push_back(0);
	aVector.push_back(0);
	
	ss = new SpriteSheet();
	ss->initWithImageNamed("joystick_tes.png", 60, 60, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", aVector, ss);
	spriteComp->addAnimation("hot", aVector, ss);
	spriteComp->addAnimation("active", aVector, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);
	
	gecJoystick *jComp;	
	jComp = new gecJoystick();
	jComp->setOwnerGE(anEntity);
	jComp->setShape(CGRectMake(100.0, 100.0, 100.0, 100.0));

	jComp->setCenter(100.0, 100.0);

	anEntity->setGEC(spriteComp);
	anEntity->setGEC(jComp);
	anEntity->x = 100.0;
	anEntity->y = 100.0;
	anEntity->isActive  = true;
	
	/*Build a game Entity*/
	GameEntity *anotherEntity = new GameEntity();
	
	ss2 = new SpriteSheet();
	ss2->initWithImageNamed("prototypePlayerSheet.png", 100, 100, 0.0, 1.0);
	
	std::vector<int> aVector2;
	
	aVector2.push_back(1);
	aVector2.push_back(0);
	aVector2.push_back(2);
	aVector2.push_back(0);
	aVector2.push_back(3);
	aVector2.push_back(0);
	aVector2.push_back(4);
	aVector2.push_back(0);
	
	gecAnimatedSprite *animation;
	
	animation = new gecAnimatedSprite();				//new gecAnimatedSpriteComponent
	animation->addAnimation("walking", aVector2, ss2);	//add a full animation to the gec
	animation->setCurrentAnimation("walking");			//we set it to walk ( just now )
	animation->setCurrentRunning(true);				//we set it to be ON ( just now )
	animation->setCurrentRepeating(true);				//we set it to repeat ( Just now )
	animation->setOwnerGE(anotherEntity);					//we must set the owner of this.
	
	gecVisualContainer *aContainer = new gecVisualContainer();	//new visual components container
	aContainer->addGecVisual(animation);						//we add the animation component
	
	anotherEntity->setGEC(aContainer);
	anotherEntity->x = 240;
	anotherEntity->y = 160;
	anotherEntity->isActive = true;
	
	/*Bind Joystick to entity*/
	jComp->subscribeGameEntity(anotherEntity);
	
	//aSceneManager = new SceneManager();
	aSceneManager->addEntity(anEntity);
	aSceneManager->addEntity(anotherEntity);
}

- (void) geTemplateManagerTest1
{
	//GEFACTORY->createGE(std::string("testFunction1"));
	aSceneManager->addEntity(GEFACTORY->createGE("testDummy"));   
}

- (void) particlesTest
{	
	//aSceneManager = new SceneManager();
	
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireSmall, CGPointMake(50, 100) , "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireMedium, CGPointMake(100, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FireBig, CGPointMake(150, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionSmall, CGPointMake(200, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionMedium, CGPointMake(250, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_ExplosionBig, CGPointMake(300, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainSmall, CGPointMake(350, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainMedium, CGPointMake(400, 100), "Particle2.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainBig, CGPointMake(450, 100), "Particle2.pvr"));
	//aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_Smoke, CGPointMake(150, 101), "smoke.pvr"));
	aSceneManager->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_Smoke, CGPointMake(140, 265), "smoke.pvr"));
	
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
	
	[context release];
	context = nil;
	
	delete TEXTURE_MANAGER;
	
	[super dealloc];
}

@end
