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
	CFTimeInterval lastTime;
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	//setup
	BOOL viewSetup;
	BOOL showFPS;
	
	//Display FPS if needed
	CFTimeInterval CurrentTime;
	CFTimeInterval LastFPSUpdate;

	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
    
    //FPS Renderer
    ITextRenderer *m_fpsRenderer;
}

- (void) initGame;
- (void) setupView;
- (void) render;
- (void) setFPS;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
