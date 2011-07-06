//
//  File.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 7/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "AngelCodeTextRenderer.h"
#include "SharedTextureManager.h"

AngelCodeTextRenderer::AngelCodeTextRenderer()
    : m_position(CGPointZero)
    , m_font(NULL)
    , m_active(true)
{
}

void AngelCodeTextRenderer::render()
{
    glPushMatrix();
    glLoadIdentity();
	glTranslatef(m_position.x, m_position.y, 0);
	m_font->render(m_text);
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