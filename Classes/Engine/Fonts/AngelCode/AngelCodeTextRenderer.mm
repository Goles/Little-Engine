//
//  File.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 7/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "AngelCodeTextRenderer.h"
#include "SharedTextureManager.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

AngelCodeTextRenderer::AngelCodeTextRenderer(): m_position(CGPointZero), 
                                                m_font(NULL), 
                                                m_active(true)
{
    //Build something here.
}

void AngelCodeTextRenderer::render()
{
	glPushMatrix();
	//glTranslatef(m_position.x, m_position.y, 0);
	
	m_font->render(m_text);
	
    //TEXTURE_MANAGER->rebindPreviousTexture();
    
	glPopMatrix();
}

bool AngelCodeTextRenderer::isActive()
{
	return m_active;
}

void AngelCodeTextRenderer::setText(const char *text)
{
	m_text.assign(text);
}

void AngelCodeTextRenderer::setFont(IFont *in_font)
{
	m_font = in_font;
}

void AngelCodeTextRenderer::setPosition(int x, int y)
{
	m_position.x = x;
	m_position.y = y;
}