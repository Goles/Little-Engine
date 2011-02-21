/*
 *  ftglesTextureFont.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "ftglesTextureFont.h"
#include <string>
#include "FTGL/ftgles.h"
#include "FileUtils.h"

void ftglesTextureFont::render()
{
	if(m_active)
		m_font->Render(m_text.c_str());
}

bool ftglesTextureFont::open(const std::string &fontFileName, int fontSize)
{
	const char *path = FileUtils::fullCPathFromRelativePath(fontFileName.c_str());
	
	m_font = new FTTextureFont(path);
	m_font->FaceSize(fontSize);
	
	if(m_font->Error())
		return false;

	m_font->CharMap(FT_ENCODING_ADOBE_LATIN_1);
	
	return true;
}

void ftglesTextureFont::setText(const std::string &in_text)
{
	m_text.assign(in_text);
}