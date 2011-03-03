///*
// *  ftglesTextureFont.h
// *  GandoEngine
// *
// *  Created by Nicolas Goles on 2/19/11.
// *  Copyright 2011 GandoGames. All rights reserved.
// *
// */

#ifndef __FTGLES_TEXTURE_FONT__
#define __FTGLES_TEXTURE_FONT__

#include "IFont.h"

class FTFont;

class ftglesTextureFont : public IFont 
{
	
public:
	//Abstract Interface
	virtual void openFont(const std::string &fontFileName, int fontSize);
	virtual void render(const std::string &text);
	
	//Non-abstract Public interface
	ftglesTextureFont() : m_font(NULL) {}
	
private:
	FTFont *m_font;
};

#endif