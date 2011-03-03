///*
// *  ftglesTextureFont.cpp
// *  GandoEngine
// *
// *  Created by Nicolas Goles on 2/19/11.
// *  Copyright 2011 GandoGames. All rights reserved.
// *
// */
//

#include "ftglesTextureFont.h"

#include <string>

#include "FTGL/ftgles.h"
#include "FontManager.h"

void ftglesTextureFont::render(const std::string &in_text)
{	
	m_font->Render(in_text.c_str());
}

void ftglesTextureFont::openFont(const std::string &fontFileName, int fontSize)
{	
	m_font = FONT_MANAGER->getFont(fontFileName, fontSize);
}
