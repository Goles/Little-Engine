/*
 *  TextureFontRenderer.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 3/2/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __TEXTURE_FONT_RENDERER__
#define __TEXTURE_FONT_RENDERER__

#include "ITextRenderer.h"

class IFont;

class TextureTextRenderer : public ITextRenderer 
{
public:
	TextureTextRenderer();
	virtual void render();
	virtual bool isActive();
	virtual void setFont(IFont *font);
	virtual void setText(const char *text);
	virtual void setPosition(int x, int y);
	
private:
	CGPoint m_position;
	std::string m_text;
	IFont *m_font;
	bool m_active;
};

#endif