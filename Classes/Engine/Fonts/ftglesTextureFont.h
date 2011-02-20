/*
 *  ftglesTextureFont.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __FTGLES_TEXTURE_FONT__
#define __FTGLES_TEXTURE_FONT__

#include "IFont.h"

class FTFont;

class ftglesTextureFont : public IFont 
{
	
public:
	//Abstract Interface
	virtual void render();
	virtual bool open(const std::string &fontFileName, int fontSize);
	virtual void setText(const std::string &text);
	
	//Non-abstract Public interface
	ftglesTextureFont() : m_font(NULL), 
						  m_active(true) {}
	
private:
	FTFont *m_font;
	std::string m_text;
	bool m_active;
};

#endif