/*
 *  IFont.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 3/2/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __IFONT_H__
#define __IFONT_H__

#include <string>

class IFont
{
public:
	virtual ~IFont() {}
	virtual void openFont(const std::string &in_fontName, int in_fontSize) = 0;
	virtual void render(const std::string &in_text) = 0;
};

#endif