/*
 *  FontManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __FONT_MANAGER_H__
#define __FONT_MANAGER_H__

#include <map>
#include <string>

#define FONT_MANAGER FontManager::getInstance()

class IFont;

class FontManager
{
public:
	~FontManager();
	static FontManager* getInstance();
	IFont *getFont(const std::string &fontName, int fontSize);
	
protected:
	IFont *createFont(const std::string &fontName, int fontSize, const std::string &key);
	
private:
	typedef std::map<std::string, IFont *> FontMap;
	FontManager(){}	
	
	//Self Instance
	static FontManager *instance;

	//Font Container
	FontMap fonts;
};

#endif