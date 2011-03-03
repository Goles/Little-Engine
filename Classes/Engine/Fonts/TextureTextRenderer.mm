/*
 *  TextureFontRenderer.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 3/2/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "TextureTextRenderer.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#include "IFont.h"

TextureTextRenderer::TextureTextRenderer() :	m_position(CGPointZero), 
												m_font(NULL), 
												m_active(true)
{
}

void TextureTextRenderer::render()
{
	glPushMatrix();
	glTranslatef(m_position.x, m_position.y, 0);
	
	m_font->render(m_text);
	
	glPopMatrix();
}

bool TextureTextRenderer::isActive()
{
	return m_active;
}

void TextureTextRenderer::setText(const char *text)
{
	m_text.assign(text);
}

void TextureTextRenderer::setFont(IFont *in_font)
{
	m_font = in_font;
}

void TextureTextRenderer::setPosition(int x, int y)
{
	m_position.x = x;
	m_position.y = y;
}
