//
//  ES2Renderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#include "SceneManager.h"

@interface ES2Renderer : NSObject <ESRenderer>
{
@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
	GLuint program;
    
    BOOL viewSetup;
    
    //This shouldn't go here, but for now let's do it
    SceneManager* gameSceneManager;
    
}

- (void) render;
- (void) update:(float) delta;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end

