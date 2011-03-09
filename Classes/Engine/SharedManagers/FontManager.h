/*
 *  FontManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
	Basic Usage:
		 IFont *font = FONT_MANAGER->getFont("TOONISH.ttf",12);
		 font->setText("EHLO!");
		 font->render();
 */

#ifndef __FONT_MANAGER_H__
#define __FONT_MANAGER_H__

#include <map>
#include <vector>
#include <string>

#include "FTGL/ftgles.h"
#include "ITextRenderer.h"

#define FONT_MANAGER FontManager::getInstance()

class FontManager
{
public:
	~FontManager();
	static FontManager* getInstance();
	void render();
	FTFont *getFont(const std::string &fontName, int fontSize);
	ITextRenderer* getTextRenderer(const std::string &in_fontName, int font_size);
	
protected:
	FTFont *createFont(const std::string &fontName, int fontSize, const std::string &key);
	
private:
	typedef std::map<std::string, FTFont *> FontMap;
	typedef std::vector<ITextRenderer *> TextureStrings;
	FontManager(){}	
	
	//Self Instance
	static FontManager *instance;

	//Font Container
	FontMap m_fonts;
	TextureStrings m_strings;
};

#endif