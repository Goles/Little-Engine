//
//  ES1Renderer.h
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#include "ITextRenderer.h"
#include "IFont.h"
#include "ITextRenderer.h"

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
	BOOL showFps;
	
	//Display Fps if needed
	CFTimeInterval CurrentTime;
	CFTimeInterval LastFPSUpdate;

	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
	
	//FPS renderer
	ITextRenderer *textRenderer;
    
    //Test
    ITextRenderer *r;
    IFont *f;
}

- (void) update:(float)delta;
- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
- (void) setupView;
- (void) initGame;
- (void) setFps;

@end
