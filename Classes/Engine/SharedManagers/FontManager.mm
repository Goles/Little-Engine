/*
 *  FontManager.mm
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "FontManager.h"

#include <iostream>
#include <sstream>
#include "IFont.h"
#include "ftglesTextureFont.h"

FontManager *FontManager::instance = NULL;

FontManager* FontManager::getInstance()
{
	if(!instance)
		instance = new FontManager();
	
	return instance;
}

IFont *FontManager::getFont(const std::string &fontName, int fontSize)
{
	std::ostringstream oss;
	
	oss << fontSize;
	
	std::string key(fontName);
	key += oss.str();
	
	FontMap::iterator result = fonts.find(key);
	
	if(result != fonts.end())
		return result->second;
	
	return this->createFont(fontName, fontSize, key);
}


IFont *FontManager::createFont(const std::string &in_fontName, int in_fontSize, const std::string &key)
{
	IFont* font = new ftglesTextureFont();
	
	if(!font->open(in_fontName, in_fontSize))
	{
		std::cout << "ERROR: Couldn't load font file " << in_fontName << std::endl;
		std::cout << "aborting..." << std::endl;
		assert(false);
	}
	
	fonts[key] = font;
	
	return font;
}

FontManager::~FontManager()
{
	FontMap::iterator font_it = fonts.begin();
	
	for(; font_it != fonts.end(); ++font_it)
	{
		delete (*font_it).second;
	}
	
	delete instance;
}