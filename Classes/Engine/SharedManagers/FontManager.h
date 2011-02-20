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
#include <string>
#include "LuaRegisterManager.h"

#define FONT_MANAGER FontManager::getInstance()

class IFont;

class FontManager
{
public:
	~FontManager();
	static FontManager* getInstance();
	IFont *getFont(const std::string &fontName, int fontSize);
	
	//Lua interface
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
			 luabind::class_<FontManager>("FontManager")
			 .def("getFont", &FontManager::getFont)
			 .scope
			 [
				luabind::def("getInstance", &FontManager::getInstance)
			 ]
		 ];	
	}
	
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