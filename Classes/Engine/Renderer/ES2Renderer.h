//
//  ES2Renderer.h
//  Texture Shader
//
//  Created by Nicolas Goles on 6/10/10.
//  Copyright 2010 GandoGames. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#include "ShaderVars.h"
#include "ESRenderer.h"
#include "Texture2D.h"
#include "Scene.h"

@interface ES2Renderer : NSObject <ESRenderer>
{
@private
    //Context and init
    EAGLContext *context;
    BOOL scene_setup;
    
    // The pixel dimensions of the CAEAGLLayer
    GLint backingWidth;
    GLint backingHeight;
	
    // The OpenGL ES names for the framebuffer and renderbuffer used to render to this view
    GLuint defaultFramebuffer, colorRenderbuffer;
    GLuint program;
	uniforms *s_uniform;
    
    //Scene Transformation
    GLfloat scene_transform_mat[16];
	
	//Game Scene Manager
	Scene *gameSceneManager;
	
    //Test Texture
    Texture2D *aTexture;
}

- (void) initGame;
- (BOOL) setupScene;
- (void) update:(float)delta;
- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end

