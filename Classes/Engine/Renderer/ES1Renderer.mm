//
//  ES1Renderer.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//

#import "ES1Renderer.h"

#include "ggEngine.h"
#include "AngelCodeFont.h"
#include "AngelCodeTextRenderer.h"
#include "FileUtils.h"

static int frames;
static char fpsText[32];

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
            return NULL;
        }
				
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
	}
	
	//Show the FPS if DEBUG is ON.
#ifdef DEBUG
	showFps = YES;
#endif
    
	//Start the ggEngine + Game up
	static bool game_init = NO;
	
	if(!game_init)
	{
		[self initGame];
		game_init = YES;
	}
    
	return self;
}

- (void) initGame
{
	gg::startup();
}

#pragma mark action_methods
- (void) setupView
{
	glViewport(0, 0, backingWidth, backingHeight);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glRotatef(-90.0, 0.0, 0.0, 1.0);
	glOrthof(0, SCENE_MANAGER->getWindow().width, 0, SCENE_MANAGER->getWindow().height, -1, 1);
	glMatrixMode(GL_MODELVIEW);
}

#pragma mark update_game
- (void) update:(float) delta
{
    Scene *currentScene = SCENE_MANAGER->getActiveScene();
    
    if(currentScene)
    {
        currentScene->sortEntitiesY();
        currentScene->update(delta);
    }

	[self setFps];
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
	
    Scene *current = SCENE_MANAGER->getActiveScene();
    
    if(current)
        current->render();
    
    r->render();

    
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void) setFps
{
	++frames;
	CurrentTime = CACurrentMediaTime();
	
	if ((CurrentTime - LastFPSUpdate) > 1.0f)
	{ 
		snprintf(fpsText, 32, "FPS: %d", frames);
	
		if(!r)
		{
            f = new AngelCodeFont();
            r = new AngelCodeTextRenderer();
            f->openFont(gg::utils::fullCPathFromRelativePath("test1.fnt"), 1.0);
            r->setFont(f);
			r->setPosition(350, 280);
		}			
		
		r->setText(fpsText);
		
		frames = 0;
		LastFPSUpdate = CurrentTime;
	}
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
        [EAGLContext setCurrentContext:NULL];
	
	// Shut Down the Good Game Engine
	gg::shutDown();
	
	[context release];
	context = NULL;	
	[super dealloc];
}

@end
