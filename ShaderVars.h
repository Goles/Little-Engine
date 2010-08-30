//
//  ShaderVars.h
//  Texture Shader
//
//  Created by Nicolas Goles on 6/10/10.
//  Copyright 2010 GandoGames. All rights reserved.
//

#ifndef _SHADER_VARS_H_
#define _SHADER_VARS_H_

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

// uniform index
typedef enum {
    UNIFORM_SAMPLER,
    UNIFORM_MVP,//model view projection
    NUM_UNIFORMS
} uniform_value;

// attribute index
enum {
    ATTRIB_POSITION,
    ATTRIB_COLOR,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};

class uniforms
{
public:
	GLint uniform (uniform_value v) { return uniforms[v]; }
	void  setUniformLocation (uniform_value v, GLint loc) { uniforms[v] = loc; }
private:
	GLint uniforms[NUM_UNIFORMS];
};



#endif