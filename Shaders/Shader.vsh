//
//  Shader.vsh
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright GandoGames 2009. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

uniform float translate;

void main()
{
	gl_Position = position;
	gl_Position.y += sin(translate) / 2.0;
	
	colorVarying = color;
}
