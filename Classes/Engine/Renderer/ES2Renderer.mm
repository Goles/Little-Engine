//
//  ES2Renderer.m
//  Texture Shader
//
//  Created by Nicolas Goles on 6/10/10.
//  Copyright 2010 Nicolas Goles. All rights reserved.
//

#import	 "ES2Renderer.h"
#include "GandoBox2D.h"
#include "ConstantsAndMacros.h"

#define nil NULL //Due to Luabind nil definition.

@interface ES2Renderer (PrivateMethods)
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation ES2Renderer

// Create an OpenGL ES 2.0 context
- (id)init
{
    if ((self = [super init]))
    {
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		
		//Init shaders class
		s_uniform = new uniforms();
		
        if (!context || ![EAGLContext setCurrentContext:context] || ![self loadShaders])
        {
            [self release];
            return NULL;
        }
		
		//Init the Game World.
		[self initGame];
		
		
        aTexture = [[Texture2D alloc] initWithImagePath:[[NSBundle mainBundle] pathForResource:@"logo.png" ofType:NULL] filter:GL_LINEAR];
        
        // Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
        glGenFramebuffers(1, &defaultFramebuffer);
        glGenRenderbuffers(1, &colorRenderbuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
    }
	
    return self;
}

- (void) initGame
{	
	gameSceneManager = new Scene(); 
	GBOX_2D->initBaseWorld();
	//GBOX_2D->initDebugDraw();
}

- (BOOL) setupScene
{
    /*
     * Here We are basically multiplying our glOrthof matrix with a 90 degrees
     * rotation matrix. This is to be able to see our geometry.
     */
    
    GLfloat orthof_mat[16] = {
        2.0/(backingHeight - 0),                    0,                                 0,                           0,             
        0,                                  (2.0/(backingWidth - 0)),                  0,                           0,                
        0,                                          0,                          -2.0/2.0,                           0,         
        -1.0 * ((backingHeight + 0)/(backingHeight - 0)),   -1.0 * ((backingWidth - 0)/(backingWidth - 0)),   0,   1.0
    };
    
    GLfloat rotation_mat[16] = {
        0,  1,  0,  0,
		-1,  0,  0,  0,
        0,  0,  1,  0,
        0,  0,  0,  1
    };
    
    //try to use neon to multiply, if not, straight C
	matmul4_c(rotation_mat, orthof_mat, scene_transform_mat);
    
    return YES;
}

#pragma mark update_game
- (void) update:(float)delta
{	
	if(gameSceneManager)
		gameSceneManager->updateScene(delta);
	
	gameSceneManager->sortEntitiesY();
	
	GBOX_2D->update(delta);
	//	GBOX_2D->debugUpdate(delta);
}

- (void) render
{
    // Replace the implementation of this method to do your own custom drawing
	
    // This application only creates a single context which is already set current at this point.
    // This call is redundant, but needed if dealing with multiple contexts.
    [EAGLContext setCurrentContext:context];
	
	if(!scene_setup)
        scene_setup = [self setupScene];
	
    // This application only creates a single default framebuffer which is already bound at this point.
    // This call is redundant, but needed if dealing with multiple framebuffers.
    glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
	
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
	
    // Use shader program
    glUseProgram(program);
	
    // Update uniform value
	glUniform1i(s_uniform->uniform(UNIFORM_SAMPLER), 0);
    glUniformMatrix4fv(s_uniform->uniform(UNIFORM_MVP), 1, GL_FALSE, scene_transform_mat);
    
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [aTexture drawAtPoint:CGPointMake(240.0, 160.0f)];
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
    
    // This application only creates a single color renderbuffer which is already bound at this point.
    // This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
	
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
	
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
	
	
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
	
	
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
	
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
	
    glLinkProgram(prog);
	
	
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
	
	
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
	
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
	
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
	
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
	
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
	
    // Create shader program
    program = glCreateProgram();
	
    // Create and compile vertex shader
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
	
    // Create and compile fragment shader
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
	
    // Attach vertex shader to program
    glAttachShader(program, vertShader);
	
    // Attach fragment shader to program
    glAttachShader(program, fragShader);
	
    // Bind attribute locations
    // this needs to be done prior to linking
    glBindAttribLocation(program, ATTRIB_POSITION, "position");
    glBindAttribLocation(program, ATTRIB_TEXCOORD, "texcoord");
	
    // Link program
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
		
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
	
    // Get uniform locations
	s_uniform->setUniformLocation(UNIFORM_SAMPLER, glGetUniformLocation(program, "sampler"));
	s_uniform->setUniformLocation(UNIFORM_MVP, glGetUniformLocation(program, "mvp"));	
    NSLog(@"SAMPLER: %d MVP: %d", s_uniform->uniform(UNIFORM_SAMPLER), s_uniform->uniform(UNIFORM_MVP));
    
    // Release vertex and fragment shaders
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
	
    return TRUE;
}

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer
{
    // Allocate color buffer backing based on the current layer size
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
	
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }
	
    return YES;
}

- (void)dealloc
{
    // Tear down GL
    if (defaultFramebuffer)
    {
        glDeleteFramebuffers(1, &defaultFramebuffer);
        defaultFramebuffer = 0;
    }
	
    if (colorRenderbuffer)
    {
        glDeleteRenderbuffers(1, &colorRenderbuffer);
        colorRenderbuffer = 0;
    }
	
    if (program)
    {
        glDeleteProgram(program);
        program = 0;
    }
	
    // Tear down context
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
    [context release];
    context = nil;
	
    [super dealloc];
}

@end
