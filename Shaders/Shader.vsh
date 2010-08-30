//
//  Shader.vsh
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

attribute vec2 position;
attribute vec4 color;
attribute vec2 texcoord;

varying vec2 texcoordVarying;

uniform mat4 mvp;

void main()
{
    //You CAN'T use transpose before in glUniformMatrix4fv so... here it goes.
    gl_Position = mvp * vec4(position.x, position.y, 0.0, 1.0);
    texcoordVarying = texcoord;
}