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

#include "ITextRenderer.h"
#include "IFont.h"
#include <string>
#include <vector>
#include <tr1/unordered_map>

#define FONT_MANAGER FontManager::getInstance()

class FontManager
{
public:
	~FontManager();
	static FontManager* getInstance();
	void render();
	ITextRenderer* textRenderer(const std::string &fontName, int fontSize);
    
protected:
	IFont *createFont(const std::string &fontName, int fontSize, const std::string &key);
	
private:
	typedef std::vector<ITextRenderer *> TextRendererVector;
    typedef std::tr1::unordered_map<std::string, IFont *, std::tr1::hash<std::string> > FontMap;
	
	FontManager(){}	
	
	//Self Instance
	static FontManager *instance;

	//Font Container
	FontMap m_fonts;
    TextRendererVector m_renderers;
};

#endif