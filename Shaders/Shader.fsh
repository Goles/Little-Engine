//
//  Shader.fsh
//  Particles_2
//
//  Created by Nicolas Goles on 9/19/09.
//  Copyright Nicolas Goles 2009. All rights reserved.
//

uniform sampler2D sampler;

varying mediump vec2 texcoordVarying;

void main()
{
    gl_FragColor = texture2D(sampler, texcoordVarying);
}

