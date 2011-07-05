//
//  Header.h
//  GandoEngine
//
//  Created by Nicolas Goles on 7/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ANGEL_CODE_TEXT_RENDERER_H__
#define __ANGEL_CODE_TEXT_RENDERER_H__

#include "ITextRenderer.h"

class IFont;

class AngelCodeTextRenderer : public ITextRenderer
{
public:
	AngelCodeTextRenderer();
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
