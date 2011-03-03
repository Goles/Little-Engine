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
#include "FileUtils.h"
#include "FTFont.h"
#include "ftglesTextureFont.h"
#include "IFont.h"
#include "TextureTextRenderer.h"

FontManager *FontManager::instance = NULL;

FontManager* FontManager::getInstance()
{
	if(!instance)
		instance = new FontManager();
	
	return instance;
}

FTFont *FontManager::getFont(const std::string &fontName, int fontSize)
{
	std::ostringstream oss;
	
	oss << fontSize;
	
	std::string key(fontName);
	key += oss.str();
	
	FontMap::iterator result = m_fonts.find(key);
	
	if(result != m_fonts.end())
		return result->second;
	
	return this->createFont(fontName, fontSize, key);
}


FTFont *FontManager::createFont(const std::string &in_fontName, int in_fontSize, const std::string &key)
{
	const char *path = FileUtils::fullCPathFromRelativePath(in_fontName.c_str());
	
	FTFont* font = new FTTextureFont(path);
	
	if(font->Error())
	{
		std::cout << "ERROR: Couldn't load font file " << in_fontName << std::endl;
		std::cout << "aborting..." << std::endl;
		assert(false);
	}
	
	font->FaceSize(in_fontSize);
	
	m_fonts[key] = font;
	
	return font;
}

ITextRenderer* FontManager::getTextRenderer(const std::string &in_fontName, int font_size)
{
	ITextRenderer *tr = new TextureTextRenderer();	
	IFont *font = new ftglesTextureFont();
	font->openFont(in_fontName, font_size);
	tr->setFont(font);

	m_strings.push_back(tr);
	
	return tr;
}

void FontManager::render()
{
	TextureStrings::iterator a_string = m_strings.begin();
	
	for(; a_string != m_strings.end(); ++a_string)
	{
		(*a_string)->render();
	}
}

FontManager::~FontManager()
{
	FontMap::iterator font_it = m_fonts.begin();
	TextureStrings::iterator string_it = m_strings.begin();
	
	//Delete cached Textures.
	for(; font_it != m_fonts.end(); ++font_it)
	{
		delete (*font_it).second;
	}
	
	//Delete TextStrins.
	for(; string_it != m_strings.end(); ++string_it)
	{
		delete (*string_it);
	}
	
	delete instance;
}